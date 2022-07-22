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

import kh.semi.comembus.common.ComembusUtils;
import kh.semi.comembus.gathering.model.dto.GatheringExt;
import kh.semi.comembus.gathering.model.service.GatheringService;
import kh.semi.comembus.member.model.dto.Member;
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
//			GatheringExt gathering = gatheringService.findByNo(psNo);
			request.setAttribute("memberList", memberList);
			request.setAttribute("pagebar", pagebar);
			request.getRequestDispatcher("/WEB-INF/views/gathering/projectApplicantStatue.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
