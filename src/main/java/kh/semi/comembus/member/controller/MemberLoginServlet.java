package kh.semi.comembus.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kh.semi.comembus.common.ComembusUtils;
import kh.semi.comembus.member.model.dto.Member;
import kh.semi.comembus.member.model.service.MemberService;

@WebServlet("/membus/login")
public class MemberLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String location = request.getHeader("Referer");
		request.setAttribute("location", location);
		
		request.getRequestDispatcher("/WEB-INF/views/member/memberLogin.jsp")
			.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			String memberId = request.getParameter("memberId");
			String password = ComembusUtils.getEncryptedPassword(request.getParameter("password"), memberId);
			String location = request.getParameter("location");
			System.out.println("memberId = " + memberId);
			System.out.println("password = " + password);
			System.out.println("location = " + location);
			
			String[] specialLocation = {"/membus/showMemberId", "/membus/enroll", "/membus/login", "membus/resetMemberPassword"};
			boolean contain = false;
			for(int i = 0; i < specialLocation.length; i++) {
				if(location.contains(specialLocation[i])) {
					contain = true;
					// System.out.println("true>> specialLocation[" + i + "] = " + specialLocation[i]);
				}
			}
			
			Member member = memberService.findById(memberId);
			System.out.println("member@MemberLoginServlet = " + member); 
			
			HttpSession session = request.getSession(true); // session이 존재하지 않으면, 새로 생성해서 반환. true 생략 가능
			
			// 로그인 성공
			if(member != null && password.equals(member.getPassword())) {
				session.setAttribute("loginMember", member);
				
				// 특정 경로에 머물다가 로그인한 경우 메인페이지로 리다이렉트
				if(contain) {
					response.sendRedirect(request.getContextPath() + "/");
				}
				else {
					response.sendRedirect(location);
				}
			}
			// 로그인 실패
			else {
				session.setAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
				response.sendRedirect(request.getContextPath() + "/membus/login");	
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
