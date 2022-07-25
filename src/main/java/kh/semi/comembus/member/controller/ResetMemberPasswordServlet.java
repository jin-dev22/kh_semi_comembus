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
import kh.semi.comembus.member.model.service.MemberService;

/**
 * Servlet implementation class ResetMemberPasswordServlet
 */
@WebServlet("/membus/resetMemberPassword")
public class ResetMemberPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String memberName = request.getParameter("name");
			String memberPhone = request.getParameter("phone");
			String memberId = request.getParameter("id");
			// System.out.println("memberName = " + memberName);
			// System.out.println("memberPhone = " + memberPhone);
			// System.out.println("memberId = " + memberId);
			
			Map<String, Object> param = new HashMap<>();
			param.put("memberName", memberName);
			param.put("memberPhone", memberPhone);
			param.put("memberId", memberId);
			
			int checkMember = memberService.checkMember(param);
			// System.out.println("checkMember = " + checkMember);
			
			HttpSession session = request.getSession();

			// 본인확인 입력값에 해당하는 회원 정보가 없는 경우, 본인확인 페이지로 리다이렉트
			if(checkMember == 0) {
				session.setAttribute("msg", "입력하신 정보에 해당하는 회원이 존재하지 않습니다. 정보를 다시 확인하신 후 시도해주세요.");
				response.sendRedirect(request.getContextPath() + "/membus/findMemberPassword");
			}
			// 본인확인 입력값에 해당하는 회원 정보가 있는 경우, 비밀번호 재설정 폼 제공
			else {
				request.setAttribute("memberId", memberId);
				request.getRequestDispatcher("/WEB-INF/views/member/resetMemberPassword.jsp")
					.forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String memberId = request.getParameter("memberId");
		System.out.println("member@ResetMemberPasswordServlet#memberId = " + memberId);
		
		String newPassword = ComembusUtils.getEncryptedPassword(request.getParameter("resetPwd"), memberId);
		System.out.println("member@ResetMemberPasswordServlet#newPassword = " + newPassword);
		
		Map<String, Object> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("newPassword", newPassword);
		
		int result = memberService.updatePassword(param);
		request.getSession().setAttribute("msg", "비밀번호를 성공적으로 변경했습니다.");
		
		response.sendRedirect(request.getContextPath() + "/membus/login");
	}

}
