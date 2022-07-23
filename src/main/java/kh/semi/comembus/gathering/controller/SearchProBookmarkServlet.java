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

import kh.semi.comembus.gathering.model.dto.Gathering;
import kh.semi.comembus.gathering.model.service.GatheringService;

/**
 * Servlet implementation class SearchBookmarkServlet
 */
@WebServlet("/gathering/searchProBookmark")
public class SearchProBookmarkServlet extends HttpServlet {
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
			
			// 체크 시 Y = 찜, 체크해제 시 All
			String bookmarkYN = request.getParameter("bookmarkYN");
			// 로그인을 했다면 memberId가, 안했다면 "" 공백문자가
			String memberId = request.getParameter("memberId");
			String type = "P";
			int totalContent = 0;
			
			System.out.println(">>> 확인용 bookmarkYN = " + bookmarkYN);
			System.out.println(">>> 확인용 memberId = " + memberId);
			
			Map<String, Object> param = new HashMap<>();
			param.put("memberId", memberId);
			param.put("bookmarkYN", bookmarkYN);
			param.put("start", (cPage - 1) * numPerPage + 1);
			param.put("end", cPage * numPerPage);
			param.put("type", type);
			System.out.println(">>> 확인용 param = " + param); // 여기까지 확인완료
			
			// 2. 업무로직
			// bookmark 영역
			List<Gathering> bookmarkList = new ArrayList<>();
			if(memberId != null && "Y".equals(bookmarkYN)) { // 로그인멤버가 있고, 찜한거 체크 시
				bookmarkList = gatheringService.findProBookmarkFilter(param);
				totalContent = gatheringService.getTotalBookmarkFilter(param);
			}
			
			List<Gathering> projectList = new ArrayList<>();
			Map<String, Object> bmParam = new HashMap<>();
			if(memberId != null && "All".equals(bookmarkYN)) {
				projectList = gatheringService.findGatheringAll(param);
				totalContent = gatheringService.getProTotalContent();
				bmParam.put("loginMemberId", memberId);
				bookmarkList = gatheringService.findAllProBookmarked(bmParam);
				System.out.println(">>> memberId " + memberId);
				System.out.println(">>> bmParam = " + bmParam);
			};
			
			System.out.println(">>> 필터링확인용 bookmarkList: " + bookmarkList); // 확인용
			System.out.println(">>> 필터링확인용 projectList: " + projectList); // 확인용
			System.out.println(">>> 필터링 totalContent = " + totalContent); // 확인용
			System.out.println(">>> cPage = " + cPage);
			
			response.setContentType("application/json; charset=utf-8");
			Map<String, Object> bookmarkFilterLists = new HashMap<>();
			bookmarkFilterLists.put("bookmarkList", bookmarkList);
			bookmarkFilterLists.put("projectList", projectList);			
			bookmarkFilterLists.put("totalContent", totalContent);
			bookmarkFilterLists.put("cPage", cPage);
			
			String jsonStr = new Gson().toJson(bookmarkFilterLists);
			response.getWriter().print(jsonStr);
			
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


}
