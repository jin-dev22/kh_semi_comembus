package kh.semi.comembus.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kh.semi.comembus.member.model.service.MemberService;

/**
 * Servlet implementation class AdminMemberQuitServlet
 */
@WebServlet("/admin/memberQuit")
public class AdminMemberQuitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String quitMemberId = request.getParameter("memberId");
			System.out.println("quitMemberId= " + quitMemberId);
			
			int result = memberService.memberQuit(quitMemberId);
			boolean success = result > 0;
			
			response.setContentType("application/json; charset=utf-8");
			String jsonStr = new Gson().toJson(success);
			response.getWriter().print(jsonStr);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
