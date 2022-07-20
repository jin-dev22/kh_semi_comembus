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
 * Servlet implementation class CommunityDeleteServlet
 */
@WebServlet("/community/communityDelete")
public class CommunityDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommunityService communityService = new CommunityService();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int no = Integer.parseInt(request.getParameter("no"));
			String type = (String) request.getParameter("co_type");
			
			if("Q".equals(type)) {
				int result = communityService.deleteQna(no);
				response.sendRedirect(request.getContextPath() + "/community/communityList?co_type=Q");
				
			}else if("F".equals(type)) {
				int result = communityService.deleteFree(no);
				response.sendRedirect(request.getContextPath() + "/community/communityList?co_type=F");
			}else if("S".equals(type)) {
				int result = communityService.deleteShare(no);
				response.sendRedirect(request.getContextPath() + "/community/communityList?co_type=S");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	
	}
}
