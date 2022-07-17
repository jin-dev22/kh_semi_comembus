package kh.semi.comembus.community.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import kh.semi.comembus.community.model.dto.Community;
import kh.semi.comembus.community.model.service.CommunityService;

/**
 * Servlet implementation class CommunityListServlet
 */
@WebServlet("/community/communityList")
public class CommunityListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommunityService communityService = new CommunityService();	

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			List<Community> qlist = communityService.findQna();
//			List<Community> flist = communityService.findFree();
//			List<Community> slist = communityService.findShare();
			
			String co_type = request.getParameter("co_type");
			
			if("Q".equals(co_type)) {
				request.setAttribute("qlist", qlist);
				System.out.println("커뮤니티 게시판 출력");
				request.getRequestDispatcher("/WEB-INF/views/community/qnaList.jsp")
				.forward(request, response);
			}else if("F".equals(co_type)) {
//				request.setAttribute("flist", flist);
				System.out.println("자유 게시판 출력");
				request.getRequestDispatcher("/WEB-INF/views/community/freeList.jsp")
				.forward(request, response);
			}else {
//				request.setAttribute("flist", flist);
				System.out.println("정보공유 게시판 출력");
				request.getRequestDispatcher("/WEB-INF/views/community/shareList.jsp")
				.forward(request, response);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}	

}
