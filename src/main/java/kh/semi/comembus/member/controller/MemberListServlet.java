package kh.semi.comembus.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.semi.comembus.member.model.dto.Member;
import kh.semi.comembus.member.model.service.MemberService;

/**
 * Servlet implementation class MemberListServlet
 */
@WebServlet("/membus/list")
public class MemberListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 사용자 입력 페이지 정보
			int numPerPage = 5;
			int cPage = 1;
//			try {
//				cPage = Integer.parseInt(request.get)
//			} catch (Exception e) {
//				// TODO: handle exception
//			}
			
			Map<String, Object> param = new HashMap<>();
			param.put("start", 1);
			param.put("end", 16);
			List<Member> memberList = memberService.findAll(param);
			System.out.println("memberList="+memberList);
			
			request.setAttribute("memberList", memberList);
			request.getRequestDispatcher("/WEB-INF/views/member/memberList.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
