package kh.semi.comembus.gathering.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.semi.comembus.gathering.model.dto.Gathering;
import kh.semi.comembus.gathering.model.dto.GatheringType;
import kh.semi.comembus.gathering.model.dto.Status;
import kh.semi.comembus.gathering.model.service.GatheringService;

/**
 * Servlet implementation class studyEnrollViewServlet
 */
@WebServlet("/gathering/studyEnrollView")
public class studyEnrollViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private GatheringService gatheringService = new GatheringService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
		request.getRequestDispatcher("/WEB-INF/views/gathering/studyEnrollView.jsp")
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
			
			//1. 사용자 입력값 처리
			String writer = request.getParameter("writer");
//			String _psType=request.getParameter("psType");
			String title = request.getParameter("title");
//			String _regDate = request.getParameter("regDate");
			String content = request.getParameter("editordata");
//			int viewcount = Integer.parseInt(request.getParameter("viewcount"));
//			int bookmark=Integer.parseInt(request.getParameter("bookmark"));
			String topic = request.getParameter("topic");
			String local = request.getParameter("local");
			int people = Integer.parseInt(request.getParameter("people"));
//			String _status = request.getParameter("status");
			String _startDate = request.getParameter("date_start");
			String _endDate = request.getParameter("date_end");
			
//			GatheringType psType = _psType != null ? GatheringType.valueOf(_psType) : null;
//			Date regDate = (_regDate != null && !"".equals(_regDate))?Date.valueOf(_regDate):null;
//			Status status = _status != null ? Status.valueOf(_status):null;
			Date startDate = (_startDate != null && !"".equals(_startDate))?Date.valueOf(_startDate):null;
			Date endDate = (_endDate != null && !"".equals(_endDate))?Date.valueOf(_endDate):null;
			
			Gathering study = new Gathering(0,writer,null,title,null,content,0,0,topic,local,people,null,startDate,endDate);
			
			System.out.println("study = "+study);
			
			//2. 업무로직
			int result = gatheringService.enrollStudy(study);
			
			//3. redirect
			request.getSession().setAttribute("msg", "스터디를 성공적으로 등록했습니다.");
			response.sendRedirect(request.getContextPath()+"/gathering/projectList");
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
}
