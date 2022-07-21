package kh.semi.comembus.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kh.semi.comembus.member.model.service.MemberService;

/**
 * Servlet implementation class MemberQuitServlet
 */
@WebServlet("/membus/quit")
public class MemberQuitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String quitMemberId = request.getParameter("memberId");
		
		try {
			int result = memberService.memberQuit(quitMemberId);
			
			HttpSession session = request.getSession();
			String msg = "";
			if(result > 0) {
				msg = "회원탈퇴처리가 완료되었습니다.";
				session.setAttribute("msg", msg);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
