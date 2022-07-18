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
			List<Community> qlist = null;
			List<Community> flist = null;
			List<Community> slist = null;
			
			String co_type = (String) request.getParameter("co_type");
			
			if("Q".equals(co_type)) {
				qlist = communityService.findQna();
				System.out.println("qlist" + qlist);
				request.setAttribute("qlist", qlist);
				request.getRequestDispatcher("/WEB-INF/views/community/qnaList.jsp")
				.forward(request, response);
				System.out.println("큐앤에이 게시판 출력");
				
			}else if("F".equals(co_type)) {
				flist = communityService.findFree();
				System.out.println("flist" + flist);
				request.setAttribute("flist", flist);
				request.getRequestDispatcher("/WEB-INF/views/community/freeList.jsp")
				.forward(request, response);
				System.out.println("자유 게시판 출력");
				
			}else {
				slist = communityService.findShare();
				System.out.println("slist" + slist);
				request.setAttribute("slist", slist);
				request.getRequestDispatcher("/WEB-INF/views/community/shareList.jsp")
				.forward(request, response);
				System.out.println("정보공유 게시판 출력");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}	

}
