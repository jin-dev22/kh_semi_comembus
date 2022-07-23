package kh.semi.comembus.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.semi.comembus.member.model.service.MemberService;

/**
 * Servlet implementation class AdminMemberEnrollNumberServlet
 */
@WebServlet("/admin/memberEnrollNum")
public class AdminMemberEnrollNumberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
   
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
	
			int memberEnrollNumToday = memberService.getMemberEnrollNumToday();
			int totalNum = memberService.getTotalMembusNum();
			
			request.setAttribute("memberEnrollNumToday", memberEnrollNumToday);
			request.setAttribute("totalMemberNum", totalNum);
			
			request.getRequestDispatcher("/WEB-INF/views/admin/statistics.jsp")
				.forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
