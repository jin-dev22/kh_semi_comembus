package kh.semi.comembus.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kh.semi.comembus.common.ComembusUtils;
import kh.semi.comembus.member.model.dto.Member;
import kh.semi.comembus.member.model.service.MemberService;

/**
 * Servlet implementation class UpdateMemberPassword
 */
@WebServlet("/membus/updateMemberPassword")
public class UpdateMemberPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/member/updateMemberPassword.jsp")
		.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			Member member = (Member) session.getAttribute("loginMember");  
			String memberId = member.getMemberId();
			String newPassword = ComembusUtils.getEncryptedPassword(request.getParameter("resetPwd"), memberId);
			System.out.println("member@ResetMemberPasswordServlet#newPassword = " + newPassword);
			System.out.println("updatePw newPw>>"+request.getParameter("resetPwd"));
			Map<String, Object> param = new HashMap<>();
			param.put("memberId", memberId);
			param.put("newPassword", newPassword);
			
			int result = memberService.updatePassword(param);
			request.getSession().setAttribute("msg", "비밀번호를 성공적으로 변경했습니다.");
			
			response.sendRedirect(request.getContextPath() + "/membus/login");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
