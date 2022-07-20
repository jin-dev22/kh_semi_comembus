package kh.semi.comembus.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kh.semi.comembus.member.model.dto.Member;
import kh.semi.comembus.member.model.service.MemberService;

/**
 * Servlet implementation class CheckIdDuplicate
 */
@WebServlet("/membus/checkIdDuplicate")
public class CheckIdDuplicateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String memberId = request.getParameter("enrollId");
		System.out.println("memberId = " + memberId);
		
		Member member = memberService.findById(memberId);
		boolean available = member == null;
		System.out.println("available = " + available);
		
		response.setContentType("application/json; charset=utf-8");
		String jsonStr = new Gson().toJson(available);
		response.getWriter().print(jsonStr);
	}

}
