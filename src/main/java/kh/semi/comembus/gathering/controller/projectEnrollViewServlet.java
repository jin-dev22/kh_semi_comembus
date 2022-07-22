package kh.semi.comembus.gathering.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.Enumeration;

import javax.servlet.ServletContext;
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
 * Servlet implementation class projectEnrollViewServlet
 */
@WebServlet("/gathering/projectEnrollView")
public class projectEnrollViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private GatheringService GatheringService = new GatheringService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
		request.getRequestDispatcher("/WEB-INF/views/gathering/projectEnrollView.jsp")
		.forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * POST db insert 요청
	 * 
	 * 첨부파일이 포함된 게시글 등록
	 * - 1. 서버컴퓨터에 파일저장 - cos.jar
	 * 		- MultipartRequest객체 생성
	 * 			- HttpServletRequest
	 * 			- saveDirecotory
	 * 			- maxPostSize
	 * 			- encoding
	 * 			- FileRenamePolicy객체 - DefaultFileRenamePolicy(기본)
	 * 		*기존 request객체가 아닌 MultipartRequest객체에서 모든 사용자입력값을 가져와야 한다.
	 * - 2. 저장된 파일정보 attachment 레코드로 등록
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			
			//1. 사용자 입력값 처리
			String writer = request.getParameter("writer");
			String _psType=request.getParameter("psType");
			String title = request.getParameter("title");
			String _regDate = request.getParameter("regDate");
			String content = request.getParameter("content");
//			int viewcount = Integer.parseInt(request.getParameter("viewcount"));
//			int bookmark=Integer.parseInt(request.getParameter("bookmark"));
			String topic = request.getParameter("topic");
			String local = request.getParameter("local");
			int people = Integer.parseInt(request.getParameter("people"));
			String _status = request.getParameter("status");
			String _startDate = request.getParameter("startDate");
			String _endDate = request.getParameter("endDate");
			
			GatheringType psType = _psType != null ? GatheringType.valueOf(_psType) : null;
			Date regDate = (_regDate != null && !"".equals(_regDate))?Date.valueOf(_regDate):null;
			Status status = _status != null ? Status.valueOf(_status):null;
			Date startDate = (_startDate != null && !"".equals(_startDate))?Date.valueOf(_startDate):null;
			Date endDate = (_endDate != null && !"".equals(_endDate))?Date.valueOf(_endDate):null;
			
			Gathering project = new Gathering(0,writer,psType,title,regDate,content,0,0,topic,local,people,status,startDate,endDate);
			
			System.out.println("project = "+project);
			
			//2. 업무로직
			int result = GatheringService.enrollProject(project);
			
			//3. redirect
			request.getSession().setAttribute("msg", "프로젝트를 성공적으로 등록했습니다.");
			response.sendRedirect(request.getContentLength()+"/gathering/projectList");
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
