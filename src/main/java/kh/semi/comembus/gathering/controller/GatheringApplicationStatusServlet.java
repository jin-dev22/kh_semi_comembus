package kh.semi.comembus.gathering.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kh.semi.comembus.alert.model.dto.Alert;
import kh.semi.comembus.alert.model.dto.IsRead;
import kh.semi.comembus.alert.model.dto.MessageType;
import kh.semi.comembus.alert.model.service.AlertService;
import kh.semi.comembus.gathering.model.dto.Gathering;
import kh.semi.comembus.gathering.model.dto.GatheringType;
import kh.semi.comembus.gathering.model.service.GatheringService;
import kh.semi.comembus.member.model.dto.Member;
import kh.semi.comembus.member.model.dto.MemberApplicationStatus;
import kh.semi.comembus.member.model.service.MemberService;

/**
 * Servlet implementation class GatheringApplicationStatusServlet
 */
@WebServlet("/gathering/apply")
public class GatheringApplicationStatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private GatheringService gatheringService = new GatheringService();
	private MemberService memberService = new MemberService(); 
	private AlertService alertService = new AlertService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String aplcntId = request.getParameter("aplcntId");
		int psNo = Integer.parseInt(request.getParameter("psNo"));
		GatheringType psType = GatheringType.valueOf(request.getParameter("psType"));
		// System.out.println("psType@GatheringApplicationStatusServlet = " + psType);
		
		MemberApplicationStatus applyInfo = new MemberApplicationStatus(aplcntId, psNo, null);
		System.out.println("gathering@GatheringApplicationStatusServlet = " + applyInfo);
		
		int result = gatheringService.insertMemberApply(applyInfo);
		
		//모임장에게 지원신청 알림
		//지원자 닉네임찾기
		Member aplcnt = memberService.findById(aplcntId);
		String nickName = aplcnt.getNickName();
		Gathering gather = gatheringService.findByNo(psNo);
		//알림내용 글자 수 줄이기
		String title = gather.getTitle();
		String substrTitle = title.length() > 8? title.substring(0, 7)+"...": title;
		String substrNick = nickName.length() > 5? nickName.substring(0, 4)+"..." : nickName;
		String alertContent = "["+substrTitle +"]에  ["+substrNick+"]님이 지원하셨습니다.";
		
		Alert alert = new Alert(0, gather.getWriter(), psNo, 0, MessageType.NEW_APPLICANT, alertContent, IsRead.N);
		result = alertService.notifyCancelApld(alert);		
		
		HttpSession session = request.getSession();
		session.setAttribute("msg", "지원이 완료되었습니다. 추후 지원 신청 결과는 알림페이지에서 확인 가능합니다.");
		
		//회원 지원신청목록 리스트 업데이트
		List<Integer> apldPsNoList = memberService.findAllApldPsNoByMemberId(aplcntId);
		session.setAttribute("apldPsNoList", apldPsNoList);
	
		String location = "";
		if(psType.name() == "P") {
			location = "projectView";
		}
		else {
			location = "studyView";
		}
		response.sendRedirect(request.getContextPath() + "/gathering/" + location + "?psNo=" + psNo);
	}
	

}
