package kh.semi.comembus.community.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kh.semi.comembus.community.model.service.CommunityService;

/**
 * Servlet implementation class CommunityCommentDeleteServlet
 */
@WebServlet("/community/communityCommentDelete")
public class CommunityCommentDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommunityService communityService = new CommunityService();
       
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	try {
			
			// 1.사용자입력값 처리(삭제하고싶은 게시글번호)
			int no = Integer.parseInt(request.getParameter("no"));
			
			// 2.업무로직
			
				int result = communityService.deleteCommuComment(no);
				response.sendRedirect(request.getHeader("Referer"));				
			
			
			// 3.리다이렉트
			
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			
		}
	
	}

}
