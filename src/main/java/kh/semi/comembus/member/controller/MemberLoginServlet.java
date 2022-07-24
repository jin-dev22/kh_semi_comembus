package kh.semi.comembus.member.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
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
			// System.out.println("memberId = " + memberId);
			// System.out.println("password = " + password);
			
			// 로그인 성공 시 리다이렉트 할 경로 가져오기
			Cookie[] cookies = request.getCookies();

			String location = "";
			if(cookies != null) {
				for(Cookie c : cookies) {
					String name = c.getName();
					String value = c.getValue();
					if("locationCookie".equals(name)) {
						location = value;
						// System.out.println("location = " + location);
						
						break;
					}
				}
			}
			
			
			Member member = memberService.findById(memberId);
			// System.out.println("member@MemberLoginServlet = " + member); 
			
			
			HttpSession session = request.getSession(true);
			
			// 로그인 성공
			if(member != null && password.equals(member.getPassword())) {
				//회원이 지원한 모임게시글 번호 목록 가져오기
				List<Integer> apldPsNoList = memberService.findAllApldPsNoByMemberId(memberId);
				
				session.setAttribute("apldPsNoList", apldPsNoList);
				session.setAttribute("loginMember", member);
				response.sendRedirect(location);
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
