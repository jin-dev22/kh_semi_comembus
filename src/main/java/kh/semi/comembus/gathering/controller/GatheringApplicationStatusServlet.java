package kh.semi.comembus.gathering.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kh.semi.comembus.gathering.model.dto.GatheringType;
import kh.semi.comembus.gathering.model.service.GatheringService;
import kh.semi.comembus.member.model.dto.JobCode;
import kh.semi.comembus.member.model.dto.Member;
import kh.semi.comembus.member.model.dto.MemberApplicationStatus;

/**
 * Servlet implementation class GatheringApplicationStatusServlet
 */
@WebServlet("/gathering/apply")
public class GatheringApplicationStatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private GatheringService gatheringService = new GatheringService();
	
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
		
		HttpSession session = request.getSession();
		session.setAttribute("msg", "지원이 완료되었습니다. 추후 지원 신청 결과는 알림페이지에서 확인 가능합니다.");
		
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
