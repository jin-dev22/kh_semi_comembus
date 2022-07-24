package kh.semi.comembus.gathering.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.semi.comembus.common.ComembusUtils;
import kh.semi.comembus.gathering.model.dto.GatheringExt;
import kh.semi.comembus.gathering.model.service.GatheringService;

/**
 * Servlet implementation class StudyViewServlet
 */
@WebServlet("/gathering/studyView")
public class StudyViewServlet extends HttpServlet {
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
			String studyCookieVal = "";
			boolean hasRead = false;
			
			if(cookies != null) {
				for(Cookie c : cookies) {
					String name = c.getName();
					String value = c.getValue();
					if("studyCookie".equals(name)) {
						studyCookieVal = value;
						if(value.contains("[" + psNo + "]")) {
							hasRead = true;
						}
						break;
					}
				}
			}
			
			// 쿠키처리
			if(!hasRead) {
				Cookie cookie = new Cookie("studyCookie", studyCookieVal + "[" + psNo + "]");
				cookie.setPath(request.getContextPath() + "/gathering/studyView");
				cookie.setMaxAge(365 * 24 * 60 * 60);
				response.addCookie(cookie);
				System.out.println("[studyCookie 새로 발급되었음 : " + cookie.getValue() + "]");
			}
			
			
			
			// 2. 업무로직
			// 게시글조회 및 조회수 증가처리
//			Gathering study = hasRead ? gatheringService.findByNo(psNo) : gatheringService.findByNo(psNo, hasRead);								
			GatheringExt study = (GatheringExt) gatheringService.findByNo(psNo);
			System.out.println("study = " + study);
			
			// XSS공격대비 (Cross-site Scripting)
			study.setTitle(ComembusUtils.escapeXml(study.getTitle()));
			study.setContent(ComembusUtils.escapeXml(study.getContent()));
			
			// 개행문자 변환처리
			study.setContent(ComembusUtils.convertLineFeedToBr(study.getContent()));
//			
			//모집인원 조회해오기
			study.setRecruited_cnt(gatheringService.getRcrtdForStd(psNo));
			
			
			// 3. view단 처리
			request.setAttribute("study", study);
			request.getRequestDispatcher("/WEB-INF/views/gathering/studyDetailView.jsp")
				.forward(request, response);
			
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
