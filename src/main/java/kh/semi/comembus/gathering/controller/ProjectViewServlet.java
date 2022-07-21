package kh.semi.comembus.gathering.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.semi.comembus.gathering.model.dto.Gathering;
import kh.semi.comembus.gathering.model.service.GatheringService;
import kh.semi.comembus.*;
import kh.semi.comembus.common.ComembusUtils;

/**
 * Servlet implementation class ProjectViewServlet
 */
@WebServlet("/gathering/projectView")
public class ProjectViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

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
				cookie.setPath(request.getContextPath() + "/project/projectView");
				cookie.setMaxAge(365 * 24 * 60 * 60);
				response.addCookie(cookie);
				System.out.println("[projectCookie 새로 발급되었음 : " + cookie.getValue() + "]");
			}
			
			
			
			// 2. 업무로직
			// 게시글조회 및 조회수 증가처리
			Gathering project = hasRead ? GatheringService.findByNo(psNo) : GatheringService.findByNo(psNo, hasRead);								
			System.out.println("project = " + project);
			
			// XSS공격대비 (Cross-site Scripting)
			project.setTitle(ComembusUtils.escapeXml(project.getTitle()));
			project.setContent(ComembusUtils.escapeXml(project.getContent()));
			
			// 개행문자 변환처리
			project.setContent(ComembusUtils.convertLineFeedToBr(project.getContent()));
			
			
			// 3. view단 처리
			request.setAttribute("project", project);
			request.getRequestDispatcher("/WEB-INF/views/project/projectDetailView.jsp")
				.forward(request, response);
			
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
