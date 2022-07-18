package kh.semi.comembus.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.semi.comembus.member.model.dto.MemberExt;
import kh.semi.comembus.member.model.service.MemberService;

/**
 * Servlet implementation class MemberProfileViewServlet
 */
@WebServlet("/membus/profile")
public class MemberProfileViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//멤버 아이디값 받아서 조회
		String memberId = request.getParameter("memberId");		
		MemberExt member = (MemberExt) memberService.findById(memberId);
		member.setJobName(memberService.getJobName(member.getJobCode()));
		System.out.println("@profileSrv>>"+member.getJobCode());
		//view단 처리
		request.setAttribute("member", member);
		request.getRequestDispatcher("/WEB-INF/views/member/memberProfile.jsp").forward(request, response);
	}

}
