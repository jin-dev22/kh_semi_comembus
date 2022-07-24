package kh.semi.comembus.gathering.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kh.semi.comembus.alert.model.dto.Alert;
import kh.semi.comembus.alert.model.dto.IsRead;
import kh.semi.comembus.alert.model.dto.MessageType;
import kh.semi.comembus.alert.model.service.AlertService;
import kh.semi.comembus.common.ComembusUtils;
import kh.semi.comembus.gathering.model.dto.Gathering;
import kh.semi.comembus.gathering.model.dto.GatheringExt;
import kh.semi.comembus.gathering.model.dto.GatheringType;
import kh.semi.comembus.gathering.model.service.GatheringService;
import kh.semi.comembus.member.model.dto.JobCode;
import kh.semi.comembus.member.model.dto.MemberExt;
import kh.semi.comembus.member.model.service.MemberService;

/**
 * Servlet implementation class GatheringApplcntStatueViewServlet
 */
@WebServlet("/gathering/showApplicants")
public class GatheringApplcntStatueViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private GatheringService gatheringService = new GatheringService();
	private MemberService memberService = new MemberService();
	private AlertService alertService = new AlertService();
	/**
	 * 모임 상세보기 페이지에서 지원현황 탭 클릭시 페이지 이동.
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		try {
			// 사용자 입력 페이지 정보
			int cPage = 1;
			int numPerPage = 20;
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch (NumberFormatException e) {}
			
			int start = (cPage - 1) * numPerPage + 1;
			int end = cPage * numPerPage;
			Map<String, Object> param = new HashMap<>();
			param.put("start", start);
			param.put("end", end);
			//게시물번호
			int psNo = Integer.parseInt(request.getParameter("psNo"));
			param.put("psNo", psNo);
			List<MemberExt> memberList = memberService.getApldMemberList(param);
			int totalApldMemberNum = memberService.getApldMemberNum(psNo);
			String url = request.getRequestURI();
			String pagebar = ComembusUtils.getPagebar(cPage, numPerPage, totalApldMemberNum, url);
			
			//게시물 정보
			GatheringExt gathering = (GatheringExt) gatheringService.findByNo(psNo);
			
			
			request.setAttribute("gathering", gathering);
			request.setAttribute("memberList", memberList);
			request.setAttribute("pagebar", pagebar);
			request.getRequestDispatcher("/WEB-INF/views/gathering/projectApplicantStatue.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	}

	/**
	 * 모임게시글상세>>지원자현황 페이지 신청결과 전송 후 페이지 리다이렉트
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//모임게시글번호, 지원자 아이디, 지원자 직무코드, 지원결과, 게시물타입을 받아옴
			int psNo = Integer.parseInt(request.getParameter("psNum"));
			GatheringType psType = GatheringType.valueOf(request.getParameter("psType"));
			String apldResult = request.getParameter("apldResult");
			String apldMemberId = request.getParameter("apldMemberId");
			String jobCode = request.getParameter("apldMemberJobCode");

			GatheringExt gathering = (GatheringExt) gatheringService.findByNo(psNo);
			String msg = "";
			//수락할경우 직무별정원테이블, 지원현황 테이블 모두 업데이트
			if("O".equals(apldResult)) {
				switch(psType) {
				//프로젝트 게시물인경우 직무별 모집정원, 모집된 인원 비교 
				case P:
					Map<String, Integer> capacitiesByDept = new HashMap<>();
					
						capacitiesByDept = gatheringService.getCapacitiesByDept(psNo);
						int capa = capacitiesByDept.get(jobCode) != null? capacitiesByDept.get(jobCode) : 0;
						int memCnt = 0;
						switch(JobCode.valueOf(jobCode)) {
						case PL: memCnt = gathering.getPlanning_cnt(); break;
						case DG: memCnt = gathering.getDesign_cnt(); break;
						case BE: memCnt = gathering.getBackend_cnt(); break;
						case FE: memCnt = gathering.getFrontend_cnt(); break;
						}
						if(capa == memCnt || capa == 0) {
							msg = "현재 정원이 마감되었거나 모집중인 직무가 아닙니다.";
							apldResult = "X";
							break;
						}
						else {
							//모임글 직무별 모집인원현황 테이블에 모집된 인원수 update
							Map<String, Object> param = new HashMap<>();
							param.put("psNo",psNo);
							param.put("jobCode", jobCode);
							int result = gatheringService.addPSMemNumByDept(param);
							msg = "해당 직무에 추가되었습니다.";
							System.out.println("[@지원자현황서블릿] 1명추가result>>"+result);
						}
					
					break;			
				case S:
					int stdRecNum = gatheringService.getRcrtdForStd(psNo);
					int people = gathering.getPeople();
					if(stdRecNum < people) {
						int result = gatheringService.addStdMemNum(psNo);
						msg = "지원자가 추가되었습니다.";				
					}
					else {
						msg = "정원이 마감되었습니다.";
						apldResult = "X";
					}
					break;
				}
			}else {
				msg = "지원신청을 거절했습니다.";
			}
				
			//멤버 지원현황 테이블 결과 컬럼 수정
			Map<String, Object> param = new HashMap<>();
			param.put("psNo", psNo);
			param.put("apldMemberId", apldMemberId);
			param.put("apldResult", apldResult);
			int apldMemupdateResult = memberService.updateApldResult(param);
			
			int cPage = 1;
			int numPerPage = 20;
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch (NumberFormatException e) {}
			
			int start = (cPage - 1) * numPerPage + 1;
			int end = cPage * numPerPage;
			param.put("start", start);
			param.put("end", end);
			List<MemberExt> memberList = memberService.getApldMemberList(param);
			int totalApldMemberNum = memberService.getApldMemberNum(psNo);
			String url = request.getRequestURI();
			String pagebar = ComembusUtils.getPagebar(cPage, numPerPage, totalApldMemberNum, url);
			
			//알림테이블 insert
			//수신자 닉네임 찾기
			String nickName = request.getParameter("nickName");
			
			//알림내용 글자 수 줄이기
			String title = gathering.getTitle();
			String substrTitle = title.length() > 8? title.substring(0, 7)+"...": title;
			String alertContent = "모임 ["+substrTitle +"]의 지원신청이 "+ ("O".equals(apldResult) ? "수락" : "거절"+"되었습니다.");
			
			Alert alert = new Alert(0, apldMemberId, psNo, 0, MessageType.APPLY_RESULT, alertContent, IsRead.N);
			int result = alertService.notifyAplcntResult(alert);
			System.out.println("[@지원자결과처리]결과알림result>>"+result);
			
			HttpSession session = request.getSession();
			session.setAttribute("msg", msg);
			request.setAttribute("gathering", gathering);
			request.setAttribute("memberList", memberList);
			request.setAttribute("pagebar", pagebar);
			request.setAttribute("psNo", psNo);
			request.getRequestDispatcher("/WEB-INF/views/gathering/projectApplicantStatue.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
