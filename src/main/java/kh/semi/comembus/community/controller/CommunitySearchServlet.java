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
import kh.semi.comembus.community.model.service.CommunityService;
import kh.semi.comembus.member.model.dto.Member;

/**
 * Servlet implementation class CommunitySearchServlet
 */
@WebServlet("/community/commuFinder")
public class CommunitySearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommunityService communityService = new CommunityService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			String type = request.getParameter("co_type");
			String searchType = request.getParameter("searchType");
			String searchKeyword = request.getParameter("searchKeyword");
			
			int numPerPage = 10;
			int cPage = 1; //기본값설정
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			}catch(NumberFormatException e) {}
			
			int start = (cPage - 1) * numPerPage + 1;
			int end = cPage * numPerPage;
			
			Map<String, Object> param = new HashMap<>();
			param.put("start", start);
			param.put("end", end);
			param.put("searchType", searchType);
			param.put("searchKeyword",searchKeyword);
			System.out.println("param@servlet = " + param);

			
//			if("Q".equals(type)) {
				List<Community> qlist = communityService.QnaTitleLike(param);
				int totalContent = communityService.qnaTotalContentLike(param);
				String url = request.getRequestURI() + "?searchType=" + searchType + "&searchKeyword=" + searchKeyword;
				String pagebar = ComembusUtils.getPagebar(cPage, numPerPage, totalContent, url);
				request.setAttribute("qlist",qlist);
				request.setAttribute("pagebar", pagebar);
				request.getRequestDispatcher("/WEB-INF/views/community/qnaList.jsp")
				.forward(request, response);
				
//			}else if("F".equals(type)) {
////				List<Community> flist = communityService.FreeTitleLike(param);
//				response.sendRedirect(request.getContextPath() + "/community/communityList?co_type=F");
//			}
		}catch(Exception e) {
			throw e;
		}
		
		
	}

}
