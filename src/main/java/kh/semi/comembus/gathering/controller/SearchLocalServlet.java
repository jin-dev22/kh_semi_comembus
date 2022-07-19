package kh.semi.comembus.gathering.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kh.semi.comembus.common.ComembusUtils;
import kh.semi.comembus.gathering.model.dto.Gathering;
import kh.semi.comembus.gathering.model.service.GatheringService;

/**
 * Servlet implementation class SearchLocalServlet
 */
@WebServlet("/gathering/searchLocal")
public class SearchLocalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private GatheringService gatheringService = new GatheringService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 페이징 설정
			int cPage = 1;
			int numPerPage = 12;
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch(NumberFormatException e) {}
			
			String searchType = request.getParameter("searchType");
			String searchKeyword = request.getParameter("searchKeyword");
			
			Map<String, Object> param = new HashMap<>();
			param.put("searchType", searchType);
			param.put("searchKeyword", searchKeyword);
			param.put("start", (cPage - 1) * numPerPage + 1);
			param.put("end", cPage * numPerPage);
			System.out.println(param);
			
			// 2. 업무로직
			// content 영역
			List<Gathering> projectList = gatheringService.findProjectLike(param); 
			System.out.println("필터링 projectList: " + projectList); // 확인용
			
			// pagebar 영역
			int totalContent = gatheringService.getProTotalContentLike(param);
			System.out.println("필터링 totalContent = " + totalContent); // 확인용
			// /comembus/gathering/searchLocal?searchType=local&searchKeyword=Capital
			String url = request.getRequestURI() + "?searchType=" + searchType + "&searchKeyword=" + searchKeyword;
			System.out.println("url = " + url);
			String searchPagebar = ComembusUtils.getPagebar(cPage, numPerPage, totalContent, url);
			System.out.println("searchPagebar = " + searchPagebar);
			
			response.setContentType("application/json; charset=utf-8");
			Map<String, Object> searchList = new HashMap<>();
			searchList.put("projectList", projectList);
			searchList.put("searchPagebar", searchPagebar);
			String jsonStr = new Gson().toJson(searchList);
			response.getWriter().print(jsonStr);
			
			
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
