package kh.semi.comembus.gathering.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.semi.comembus.gathering.model.dto.GatheringExt;
import kh.semi.comembus.gathering.model.service.GatheringService;

/**
 * Servlet implementation class ProjectViewServlet
 */
@WebServlet("/gathering/projectView")
public class ProjectViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private GatheringService gatheringService = new GatheringService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 사용자입력값 처리
			int psNo = Integer.parseInt(request.getParameter("psNo"));

			// 읽음여부판단
			Cookie[] cookies = request.getCookies();
			String projectCookieVal = "";
			boolean hasRead = false;
			
			if(cookies != null) {
				for(Cookie c : cookies) {
					String name = c.getName();
					String value = c.getValue();
					if("projectCookie".equals(name)) {
						projectCookieVal = value;
						if(value.contains("[" + psNo + "]")) {
							hasRead = true;
						}
						break;
					}
				}
			}
			
			// 쿠키처리
			if(!hasRead) {
				Cookie cookie = new Cookie("projectCookie", projectCookieVal + "[" + psNo + "]");
				cookie.setPath(request.getContextPath() + "/gathering/projectView");
				cookie.setMaxAge(365 * 24 * 60 * 60);
				response.addCookie(cookie);
				System.out.println("[projectCookie 새로 발급되었음 : " + cookie.getValue() + "]");
			}
			
			// 2. 업무로직
			// 게시글조회 및 조회수 증가처리
			GatheringExt project = hasRead ? (GatheringExt)gatheringService.findByNo(psNo) : (GatheringExt)gatheringService.findByNo(psNo, hasRead);
			
			//set직무별 모집정원설정
			Map<String, Integer> capasByDept = gatheringService.getCapacitiesByDept(psNo);
			System.out.println("[플젝상세보기 직무별 모집인원은?]>>>>>>"+capasByDept);
			
			project.setBackend_cnt(capasByDept.containsKey("BE")? capasByDept.get("BE") : 0);
			project.setFrontend_cnt(capasByDept.containsKey("FE")? capasByDept.get("FE") : 0);
			project.setDesign_cnt(capasByDept.containsKey("DG")? capasByDept.get("DG") : 0);
			project.setPlanning_cnt(capasByDept.containsKey("PL")? capasByDept.get("PL") : 0);
			
			
			//직무별 모집된 인원 조회
			Map<String, Integer> cntsByDept = gatheringService.getCntsByDept(psNo);
			
			System.out.println("project = " + project);

			// 3. view단 처리
			request.setAttribute("cntsByDept", cntsByDept);
			request.setAttribute("project", project);
			request.getRequestDispatcher("/WEB-INF/views/gathering/projectDetailView.jsp")
				.forward(request, response);
			
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
