package kh.semi.comembus.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.semi.comembus.member.model.service.MemberService;

/**
 * Servlet implementation class ShowMemberIdServlet
 */
@WebServlet("/membus/showMemberId")
public class ShowMemberIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			String memberName = request.getParameter("name");
			String memberPhone = request.getParameter("phone");
			// System.out.println("memberName = " + memberName);
			// System.out.println("memberPhone = " + memberPhone);
			
			Map<String, Object> param = new HashMap<>();
			param.put("memberName", memberName);
			param.put("memberPhone", memberPhone);
			
			String memberId = memberService.getMemberId(param);

			request.setAttribute("memberId", memberId);

			request.getRequestDispatcher("/WEB-INF/views/member/showMemberId.jsp")
				.forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
