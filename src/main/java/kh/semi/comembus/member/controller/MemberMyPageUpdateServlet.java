package kh.semi.comembus.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.semi.comembus.member.model.dto.JobCode;
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
			String nickName = request.getParameter("nickName");
			String jobCode = request.getParameter("jobCode"); 
			String introduction = request.getParameter("Contents");
			Map<String, Object> param = new HashMap<>();
			param.put("nickName", nickName);
			param.put("jobCode", jobCode);
			param.put("introduction", introduction);
			
			int result = memberService.updateMember(param);
			
			response.sendRedirect(request.getContextPath() + "/membus/mypage");			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
