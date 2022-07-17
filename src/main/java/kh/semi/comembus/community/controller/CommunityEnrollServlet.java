package kh.semi.comembus.community.controller;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import kh.semi.comembus.community.model.dto.Community;
import kh.semi.comembus.community.model.service.CommunityService;

/**
 * Servlet implementation class CommunityEnrollServlet
 */
/**
 * Servlet implementation class BoardEnrollServlet
 */
@WebServlet("/community/communityEnroll")
public class CommunityEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommunityService communityService = new CommunityService();	
	/**
	 * GET 게시글 등록폼 요청
	 * form 페이지에 연결
	 * 
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.getRequestDispatcher("/WEB-INF/views/community/qnaEnroll.jsp")
			.forward(request, response);
	
	}

	/**
	 * POST db에 insert 요청(게시글 등록하기 버튼 눌렀을시 작동할)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1.사용자입력값처리
			String title = request.getParameter("coTitle");
			String writer = request.getParameter("coWriter");
			String content = request.getParameter("coContent");
			String type = request.getParameter("coType");
			Community community = new Community(0, title, writer, content, 0, null, 0, type);
					
			// 2.업무로직
//			int result = communityService.insertCommunity(community);
			
			
			// 3.redirect(오류나지 않는이상 무조건 성공)
			//Session에 등록해야 리다이렉트 후에 내용이 나온다.
			if(type == "Q") {
				request.getSession().setAttribute("msg", "QnA 등록 성공");
				response.sendRedirect(request.getContextPath() + "/community/qnaList");
			}else if(type == "F") {
				request.getSession().setAttribute("msg", "자유 게시판 등록 성공");
				response.sendRedirect(request.getContextPath() + "/community/freeList");
			}else {
				request.getSession().setAttribute("msg", "정보공유 게시판 등록 성공");
				response.sendRedirect(request.getContextPath() + "/community/shareList");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	
	}

}
