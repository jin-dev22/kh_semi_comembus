package kh.semi.comembus.gathering.controller;

import java.io.IOException;
import java.util.ArrayList;
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
import kh.semi.comembus.gathering.model.dto.Status;
import kh.semi.comembus.gathering.model.service.GatheringService;

/**
 * Servlet implementation class SearchLocalServlet
 */
@WebServlet("/gathering/searchFilter")
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
			
			String searchLocal = request.getParameter("searchLocal");
			String searchJobcode = request.getParameter("searchJobcode");
			String selectLocalKeyword = request.getParameter("selectLocalKeyword");
			String selectJobKeyword = request.getParameter("selectJobKeyword");
			String statusYN = request.getParameter("statusYN");
			// 체크 시 N=모집중, 체크해제 시 All
			String memberId = request.getParameter("memberId");
			// 로그인을 했다면 memberId가, 안했다면 "" 공백문자가
			
			System.out.println("확인용 searchLocal = " + searchLocal);
			System.out.println("확인용 searchJobcode = " + searchJobcode);
			System.out.println("확인용 selectLocalKeyword = " + selectLocalKeyword);
			System.out.println("확인용 selectJobKeyword = " + selectJobKeyword);
			System.out.println("확인용 statusYN = " + statusYN);
			System.out.println("확인용 memberId = " + memberId);
			
			Map<String, Object> param = new HashMap<>();
			param.put("searchLocal", searchLocal);
			param.put("searchJobcode", searchJobcode);
			param.put("selectLocalKeyword", selectLocalKeyword);
			param.put("selectJobKeyword", selectJobKeyword);
			param.put("statusYN", statusYN);
			param.put("start", (cPage - 1) * numPerPage + 1);
			param.put("end", cPage * numPerPage);
			System.out.println("확인용 param = " + param);
			
			// 2. 업무로직
			// content 영역
			List<Gathering> projectList = gatheringService.findProjectLike(param);
			// bookmark 영역
			List<Gathering> memberBookmarkList = new ArrayList<>();
			if(memberId != null) {
				memberBookmarkList = gatheringService.findMemberBookmarkList(memberId);
			} 
			System.out.println("필터링확인용 projectList: " + projectList); // 확인용
			System.out.println("필터링확인용 memberBookmarkList: " + memberBookmarkList); // 확인용
			
			// pagebar 영역
			int totalContent = gatheringService.getProTotalContentLike(param);
			System.out.println("필터링 totalContent = " + totalContent); // 확인용
			System.out.println("cPage = " + cPage);
			
			response.setContentType("application/json; charset=utf-8");
			Map<String, Object> searchList = new HashMap<>();
			searchList.put("projectList", projectList);
			searchList.put("totalContent", totalContent);
			searchList.put("cPage", cPage);
			searchList.put("memberBookmarkList", memberBookmarkList);
			String jsonStr = new Gson().toJson(searchList);
			response.getWriter().print(jsonStr);
			
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
