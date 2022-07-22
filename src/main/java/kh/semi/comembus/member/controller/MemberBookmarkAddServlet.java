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

import kh.semi.comembus.gathering.model.dto.Gathering;
import kh.semi.comembus.gathering.model.service.GatheringService;
import kh.semi.comembus.member.model.service.MemberService;

/**
 * Servlet implementation class GatheringBookmarkAddServlet
 */
@WebServlet("/membus/bookmarkAdd")
public class MemberBookmarkAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	private GatheringService gatheringService = new GatheringService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			// 사용자 입력값 처리
			// 로그인한 멤버 아이디, 좋아요 한 게시글 번호
			String memberId = request.getParameter("member_id");
			int psNo = 0;
			psNo = Integer.parseInt(request.getParameter("psNo"));
			System.out.println("memberId = " + memberId);
			System.out.println("psNo = " + psNo);
			
			Map<String, Object> param = new HashMap<>();
			param.put("memberId", memberId);
			param.put("psNo", psNo);
			
			// 업무로직
			int result = memberService.insertBookmark(param);
			List<Gathering> bookmarkList = gatheringService.findAllBookmarked(memberId);
			System.out.println("result = " + result);
			
			
			response.sendRedirect(request.getHeader("Referer"));
			request.setAttribute("bookmarkList", bookmarkList);
			
			// request.getRequestDispatcher("/WEB-INF/views/gathering/projectList.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
