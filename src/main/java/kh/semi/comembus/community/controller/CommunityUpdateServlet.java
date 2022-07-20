package kh.semi.comembus.community.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import kh.semi.comembus.community.model.dto.Community;
import kh.semi.comembus.community.model.service.CommunityService;

/**
 * Servlet implementation class CommunityUpdateServlet
 */
@WebServlet("/community/communityUpdate")
public class CommunityUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommunityService communityService = new CommunityService();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int no = Integer.parseInt(request.getParameter("no"));
			String type = (String) request.getParameter("co_type");
			
			if("Q".equals(type)) {
				Community qview = communityService.findByQnaNo(no);
				request.setAttribute("qview", qview);
				request.getRequestDispatcher("/WEB-INF/views/community/qnaUpdate.jsp")
				.forward(request, response);
				
			}else if("F".equals(type)) {
				Community fview = communityService.findByFreeNo(no);
				request.setAttribute("fview", fview);
				request.getRequestDispatcher("/WEB-INF/views/community/freeUpdate.jsp")
				.forward(request, response);
				
			}else if("S".equals(type)) {
				Community sview = communityService.findByShareNo(no);
				request.setAttribute("sview", sview);
				request.getRequestDispatcher("/WEB-INF/views/community/shareUpdate.jsp")
				.forward(request, response);
			}
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
			
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			int no = Integer.parseInt(request.getParameter("no"));
			String type = (String) request.getParameter("co_type");
			
			
			String title = request.getParameter("co_title");
			String writer = request.getParameter("co_writer");
			String content = request.getParameter("co_content");
			Community commu = new Community(no, title, writer, content, 0, null, 0, type);

			if("Q".equals(type)) {
				int result = communityService.updateQna(commu);
				response.sendRedirect(request.getContextPath() + "/community/communityView?co_type=Q&no="+no);
				
			}else if("F".equals(type)) {
				int result = communityService.updateFree(commu);
				response.sendRedirect(request.getContextPath() + "/community/communityView?co_type=F&no="+no);
			}else if("S".equals(type)) {
				int result = communityService.updateShare(commu);
				response.sendRedirect(request.getContextPath() + "/community/communityView?co_type=S&no="+no);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	
	}
}
