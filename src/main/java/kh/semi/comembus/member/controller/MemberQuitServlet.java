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
			
			if(result > 0) {
				session.setAttribute("msg", "회원탈퇴처리가 완료되었습니다.");
				session.setAttribute("loginMember", null);
			}
			else {
				session.setAttribute("msg", "회원탈퇴처리 오류. 메인화면으로 돌아갑니다.");
			}
			request.getRequestDispatcher("/index.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
