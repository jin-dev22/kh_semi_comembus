package kh.semi.comembus.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kh.semi.comembus.common.ComembusUtils;
import kh.semi.comembus.member.model.dto.JobCode;
import kh.semi.comembus.member.model.dto.Member;
import kh.semi.comembus.member.model.service.MemberService;

/**
 * Servlet implementation class MemberEnrollServlet
 */
@WebServlet("/membus/enroll")
public class MemberEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/member/memberEnroll.jsp")
			.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String memberId = request.getParameter("enrollId");
			String password = ComembusUtils.getEncryptedPassword(request.getParameter("enrollPwd"), memberId);
			String memberName = request.getParameter("enrollName");
			String nickName = request.getParameter("enrollNickname");
			String phone = request.getParameter("enrollPhone");
			String _jobCode = request.getParameter("jobCode");
			JobCode jobCode = JobCode.valueOf(_jobCode);
			
			Member member = new Member(memberId, jobCode, nickName, memberName, password, phone, null, null, null, null, null);
			System.out.println("MemberEnrollServlet#member = " + member);
			
			int result = memberService.insertMember(member);
			System.out.println("MemberEnrollServlet#result = " + result);
			
			HttpSession session = request.getSession();
			session.setAttribute("msg", "회원가입이 완료되었습니다. 로그인 후 이용 가능합니다.");
			response.sendRedirect(request.getContextPath() + "/membus/login");
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
