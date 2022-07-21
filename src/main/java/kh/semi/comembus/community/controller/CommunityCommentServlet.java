package kh.semi.comembus.community.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import kh.semi.comembus.community.model.dto.CommentLevel;
import kh.semi.comembus.community.model.dto.CommunityRepl;
import kh.semi.comembus.community.model.service.CommunityService;

/**
 * Servlet implementation class CommunityCommentServlet
 */
@WebServlet("/community/communityCommentEnroll")
public class CommunityCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommunityService communityService = new CommunityService();
  
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type = request.getParameter("co_type");
		try {
			//1.사용자입력값 처리
			CommentLevel commentLevel = CommentLevel.valueOf(Integer.parseInt(request.getParameter("commentLevel")));
			String writer = request.getParameter("writer");
			int coNo = Integer.parseInt(request.getParameter("coNo"));
			int commentRef = Integer.parseInt(request.getParameter("commentRef"));
			String content = request.getParameter("content");
			CommunityRepl commuRepl = new CommunityRepl(0, writer, coNo, null, content, commentLevel, commentRef);
			System.out.println("comment:" + commuRepl);
			
			if("Q".equals(type)) {
				int result = communityService.insertQnaComment(commuRepl);
//				HttpSession session = request.getSession();
				response.sendRedirect(request.getContextPath()+ "/community/communityView?co_type=Q&no=" + coNo);
				
			}else if("F".equals(type)) {
//				int result = communityService.insertFree(commu);
				response.sendRedirect(request.getContextPath() + "/community/communityList?co_type=F");
			}else if("S".equals(type)) {
//				int result = communityService.insertShare(commu);
				response.sendRedirect(request.getContextPath() + "/community/communityList?co_type=S");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	
	}

}
