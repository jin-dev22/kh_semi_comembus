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

import kh.semi.comembus.member.model.dto.Member;
import kh.semi.comembus.member.model.service.MemberService;

/**
 * Servlet implementation class MemberMyPageUpdateServlet
 */
@WebServlet("/membus/mypage/update")
public class MemberMyPageUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			Member loginMember = (Member) session.getAttribute("loginMember");
			
			String nickName = request.getParameter("nickName");
			String jobCode = request.getParameter("jobCode"); 
			String introduction = request.getParameter("introduction");
			String memberId = loginMember.getMemberId();
			Map<String, Object> param = new HashMap<>();
			param.put("nickName", nickName);
			param.put("jobCode", jobCode);
			param.put("introduction", introduction);
			param.put("memberId", memberId);
			System.out.println("[@mpUpdateSrv]: params>>"+nickName+", "+jobCode+", "+ introduction+", "+memberId);
			
			int result = memberService.updateMember(param);
			if(result > 0) {
				loginMember = memberService.findById(memberId);
			}else {
				session.setAttribute("msg", "회원정보 수정 실패. 관리자에게 문의하세요.");
			}
			
			session.setAttribute("loginMember", loginMember);
			response.sendRedirect(request.getContextPath() + "/membus/mypage");			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}

