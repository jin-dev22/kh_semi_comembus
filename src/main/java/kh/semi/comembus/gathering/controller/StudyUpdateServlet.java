package kh.semi.comembus.gathering.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.semi.comembus.gathering.model.dto.Gathering;
import kh.semi.comembus.gathering.model.service.GatheringService;

/**
 * Servlet implementation class StudyUpdateServlet
 */
@WebServlet("/gathering/studyUpdateView")
public class StudyUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private GatheringService gatheringService = new GatheringService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int psNo =Integer.parseInt(request.getParameter("psNo"));
			System.out.println("servlet : "+psNo);
			Gathering study = gatheringService.findByNo(psNo);
			request.setAttribute("study", study);
			request.getRequestDispatcher("/WEB-INF/views/gathering/studyUpdate.jsp")
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
		try {
			
			String writer = request.getParameter("writer");
			int psNo = Integer.parseInt(request.getParameter("psNo"));
			System.out.println("psNo = " + psNo);
			String title = request.getParameter("title");
			String content = request.getParameter("editordata");
			String topic = request.getParameter("topic");
			String local = request.getParameter("local");
			int people = Integer.parseInt(request.getParameter("people"));
			String _startDate = request.getParameter("date_start");
			String _endDate = request.getParameter("date_end");
			
			Date startDate = (_startDate != null && !"".equals(_startDate))?Date.valueOf(_startDate):null;
			Date endDate = (_endDate != null && !"".equals(_endDate))?Date.valueOf(_endDate):null;
			
			Gathering study = new Gathering(psNo, null, null, title, null, content, 0, 0, null, local, people, null, startDate, endDate);

			System.out.println("study = "+ study);
			
			//2. 업무로직
			int result = gatheringService.updateStudy(study);
			
			//3. redirect
			request.getSession().setAttribute("msg", "스터디를 성공적으로 등록했습니다.");
			response.sendRedirect(request.getContextPath()+"/gathering/studyList");
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
