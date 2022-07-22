package kh.semi.comembus.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kh.semi.comembus.common.ComembusUtils;
import kh.semi.comembus.member.model.dto.Member;
import kh.semi.comembus.member.model.service.MemberService;

/**
 * Servlet implementation class CheckMemberPassword
 */
@WebServlet("/membus/checkMemberPassword")
public class CheckMemberPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			Member member = (Member) session.getAttribute("loginMember");  
			String memberId = member.getMemberId();
			String oldPassword = ComembusUtils.getEncryptedPassword(request.getParameter("oldPw"), memberId);
			
			boolean result = member.getPassword().equals(oldPassword);
			System.out.println("[@PwChkServ]: params>>"+memberId+", "+oldPassword);
			System.out.println("[@PwChkServ]: result>>"+result);
			
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(result, response.getWriter());
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
