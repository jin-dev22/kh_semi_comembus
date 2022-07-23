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
			String type = (String) request.getParameter("co_type");
			List<Community> qlist = null;
			List<Community> flist = null;
			List<Community> slist = null;
			List<Community> best = null;
			
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

			if("Q".equals(type)) {
				qlist = communityService.findQna(param);
				int totalContent = communityService.getQnaContent();
				String url = request.getRequestURI() + "?co_type=Q"; 
				String pagebar = 
						ComembusUtils.getPagebar(cPage, numPerPage, totalContent, url);
				
				request.setAttribute("qlist", qlist);
				request.setAttribute("pagebar", pagebar);
				request.getRequestDispatcher("/WEB-INF/views/community/qnaList.jsp")
				.forward(request, response);
				
			}else if("F".equals(type)) {
				flist = communityService.findFree(param);
				int totalContent = communityService.getFreeContent();
				String url = request.getRequestURI() + "?co_type=F"; 
				String pagebar = 
						ComembusUtils.getPagebar(cPage, numPerPage, totalContent, url);
				request.setAttribute("flist", flist);
				request.setAttribute("pagebar", pagebar);
				request.getRequestDispatcher("/WEB-INF/views/community/freeList.jsp")
				.forward(request, response);
				
			}else if("S".equals(type)) {
				best = communityService.findShareBest();
				slist = communityService.findShare(param);
				int totalContent = communityService.getShareContent();
				
				//페이징
				String url = request.getRequestURI() + "?co_type=S"; 
				String pagebar = 
						ComembusUtils.getPagebar(cPage, numPerPage, totalContent, url);
				
				request.setAttribute("best", best);
				request.setAttribute("slist", slist);
				request.setAttribute("pagebar", pagebar);
				request.getRequestDispatcher("/WEB-INF/views/community/shareList.jsp")
				.forward(request, response);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}	

}
