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

import kh.semi.comembus.common.ComembusUtils;
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
			int cPage = 1;
			int numPerPage = 5;
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch (NumberFormatException e) {}
			
			int start = (cPage - 1) * numPerPage + 1;
			int end = cPage * numPerPage;
			Map<String, Object> param = new HashMap<>();
			param.put("start", start);
			param.put("end", end);
			
			List<Member> memberList = memberService.findAll(param);
			System.out.println("memberList="+memberList);
			
			int totalMembus = memberService.getTotalMembus();
			String url = request.getRequestURI();
			String pagebar = ComembusUtils.getPagebar(cPage, numPerPage, totalMembus, url);
			
			request.setAttribute("memberList", memberList);
			request.getRequestDispatcher("/WEB-INF/views/member/memberList.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
