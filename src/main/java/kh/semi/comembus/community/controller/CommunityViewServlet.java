package kh.semi.comembus.community.controller;

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
import kh.semi.comembus.community.model.dto.Community;
import kh.semi.comembus.community.model.dto.CommunityRepl;
import kh.semi.comembus.community.model.service.CommunityService;

/**
 * Servlet implementation class CommunityViewServlet
 */
@WebServlet("/community/communityView")
public class CommunityViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommunityService communityService = new CommunityService();	

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int no = Integer.parseInt(request.getParameter("no"));
			String type = (String) request.getParameter("co_type");
		
			if("Q".equals(type)) {
				Community qview = communityService.findByCommuNo(no);
				List<CommunityRepl> replList = communityService.findCommuCommentcoNo(no);
				request.setAttribute("qview", qview);
				request.setAttribute("replList", replList);
				request.getRequestDispatcher("/WEB-INF/views/community/qnaView.jsp")
				.forward(request, response);
			
			}else if("F".equals(type)) {
				Community fview = communityService.findByCommuNo(no);
				List<CommunityRepl> replList = communityService.findCommuCommentcoNo(no);
				request.setAttribute("fview", fview);
				request.setAttribute("replList", replList);
				request.getRequestDispatcher("/WEB-INF/views/community/freeView.jsp")
				.forward(request, response);
			}else if("S".equals(type)) {
				Community sview = communityService.findByCommuNo(no);
				List<CommunityRepl> replList = communityService.findCommuCommentcoNo(no);
				request.setAttribute("sview", sview);
				request.setAttribute("replList", replList);
				request.getRequestDispatcher("/WEB-INF/views/community/shareView.jsp")
				.forward(request, response);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}	
  
}
