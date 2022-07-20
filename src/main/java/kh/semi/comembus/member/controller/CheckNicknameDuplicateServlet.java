package kh.semi.comembus.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kh.semi.comembus.member.model.service.MemberService;

/**
 * Servlet implementation class CheckNicknameDuplicate
 */
@WebServlet("/membus/checkNicknameDuplicate")
public class CheckNicknameDuplicateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String nickName = request.getParameter("nickname");
		
		int checkNickname = memberService.checkNickname(nickName);
		
		boolean available = checkNickname == 0;
		
		response.setContentType("application/json; charset=utf-8");
		String jsonStr = new Gson().toJson(available);
		response.getWriter().print(jsonStr);
	}

}
