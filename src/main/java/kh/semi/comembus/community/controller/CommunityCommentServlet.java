package kh.semi.comembus.community.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.semi.comembus.alert.model.dto.Alert;
import kh.semi.comembus.alert.model.dto.IsRead;
import kh.semi.comembus.alert.model.dto.MessageType;
import kh.semi.comembus.alert.model.service.AlertService;
import kh.semi.comembus.community.model.dto.CommentLevel;
import kh.semi.comembus.community.model.dto.Community;
import kh.semi.comembus.community.model.dto.CommunityRepl;
import kh.semi.comembus.community.model.service.CommunityService;

/**
 * Servlet implementation class CommunityCommentServlet
 */
@WebServlet("/community/communityCommentEnroll")
public class CommunityCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommunityService communityService = new CommunityService();
	private AlertService alertService = new AlertService();
	
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

			int result = communityService.insertCommuComment(commuRepl);
			
			//게시글작성자에게 댓글알림
			Community comm = communityService.findByCommuNo(coNo);
			Map<String, Object> param = new HashMap<>();
			param.put("coNo", coNo);
			param.put("writer", writer);
			int replNo = communityService.getLastReplNoByMemIdCoNo(param);
			String title = comm.getCoTitle();
			String substrTitle = title.length() > 8? title.substring(0, 7)+"...": title;
			String alertContent = "["+substrTitle +"]에 새 댓글이 달렸습니다.";
			
			Alert alert = new Alert(0, writer, 0, replNo, MessageType.NEW_COMMENT, alertContent, IsRead.N);
			result = alertService.notifyNewComment(alert);
			
			if("Q".equals(type)) {
				response.sendRedirect(request.getContextPath()+ "/community/communityView?co_type=Q&no=" + coNo);
				
			}else if("F".equals(type)) {
				response.sendRedirect(request.getContextPath() + "/community/communityView?co_type=F&no=" + coNo);
			}else if("S".equals(type)) {
				response.sendRedirect(request.getContextPath() + "/community/communityView?co_type=S&no=" + coNo);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	
	}

}
