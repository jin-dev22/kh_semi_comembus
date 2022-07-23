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
import javax.servlet.http.HttpSession;

import kh.semi.comembus.common.ComembusUtils;
import kh.semi.comembus.gathering.model.dto.Gathering;
import kh.semi.comembus.gathering.model.dto.GatheringExt;
import kh.semi.comembus.gathering.model.service.GatheringService;
import kh.semi.comembus.member.model.dto.MemberExt;

/**
 * Servlet implementation class ProjectListServlet
 */
@WebServlet("/gathering/projectList")
public class ProjectListServlet extends HttpServlet {
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
			
			int start = (cPage - 1) * numPerPage + 1;
			int end = cPage * numPerPage;
			String type = "P";
			Map<String, Object> param = new HashMap<>();
			param.put("start", start);
			param.put("end", end);
			param.put("type", type);
			
			HttpSession session = request.getSession();
			MemberExt loginMember = (MemberExt) session.getAttribute("loginMember");
			String loginMemberId = null;
			
			// content 영역 
			List<Gathering> projectList = gatheringService.findGatheringAll(param);
			System.out.println(">>> param = " + param);
			System.out.println(">>> projectList = " + projectList);
			
			// 북마크
			Map<String, Object> bmParam = new HashMap<>();
			if(loginMember != null) {
				loginMemberId = loginMember.getMemberId();
				bmParam.put("loginMemberId", loginMemberId);
				System.out.println(">>> loginMemberId " + loginMemberId);
				System.out.println(">>> bmParam = " + bmParam);
			}
			List<Gathering> bookmarkList = gatheringService.findAllProBookmarked(bmParam);
			
			System.out.println(">>> 2loginMemberId " + loginMemberId);
			System.out.println(">>> bookmarkList " + bookmarkList);
						
			// pagebar 영역
			int totalContent = gatheringService.getTotalContent();
			String url = request.getRequestURI();
			String pagebar = ComembusUtils.getPagebar(cPage, numPerPage, totalContent, url);
			
			// view단처리
			request.setAttribute("projectList", projectList);
			request.setAttribute("pagebar", pagebar);
			request.setAttribute("bookmarkList", bookmarkList);
			request.getRequestDispatcher("/WEB-INF/views/gathering/projectList.jsp").forward(request, response);
			
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
