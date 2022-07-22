package kh.semi.comembus.gathering.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

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
			int planning_cnt=0;
			int design_cnt=0;
			int frontend_cnt=0;
			int backend_cnt=0;
			//0. people값 처리
			String planning = request.getParameter("planning");
			if(request.getParameter("planning_cnt")!="") {
				System.out.println("test");
				planning_cnt = Integer.parseInt(request.getParameter("planning_cnt"));
			}
			String design = request.getParameter("design");
			if(request.getParameter("design_cnt")!="") {
				design_cnt = Integer.parseInt(request.getParameter("design_cnt"));}
			String frontend = request.getParameter("frontend");
			if(request.getParameter("frontend_cnt")!="") {
				frontend_cnt = Integer.parseInt(request.getParameter("frontend_cnt"));}
			String backend = request.getParameter("backend");
			if(request.getParameter("backend_cnt")!="") {
			backend_cnt = Integer.parseInt(request.getParameter("backend_cnt"));}
			
			Map<String,Object> parameter = new HashMap<>();
			parameter.put("planning",planning);
			parameter.put("planning_cnt", planning_cnt);
			parameter.put("design", design);
			parameter.put("design_cnt", design_cnt);
			parameter.put("frontend", frontend);
			parameter.put("frontend_cnt", frontend_cnt);
			parameter.put("backend", backend);
			parameter.put("backend_cnt", backend_cnt);
			System.out.println("확인용 parameter = " + parameter);
			
			int people = planning_cnt+design_cnt+frontend_cnt+backend_cnt;
			
			//1. 사용자 입력값 처리
			String writer = request.getParameter("writer");
//			String _psType=request.getParameter("psType");
			String title = request.getParameter("title");
			System.out.println(title);
			String _regDate = request.getParameter("reg_date");
//			System.out.println(_regDate);
			String content = request.getParameter("editordata");
			System.out.println(content);
//			int viewcount = Integer.parseInt(request.getParameter("viewcount"));
//			int bookmark=Integer.parseInt(request.getParameter("bookmark"));
			String topic = request.getParameter("topic");
			String local = request.getParameter("local");
//			int people = Integer.parseInt(request.getParameter("people"));
//			String _status = request.getParameter("status");
			String _startDate = request.getParameter("date_start");
			String _endDate = request.getParameter("date_end");
			
//			GatheringType psType = _psType != null ? GatheringType.valueOf(_psType) : null;
//			Date regDate = (_regDate != null && !"".equals(_regDate))?Date.valueOf(_regDate):null;
//			Status status = _status != null ? Status.valueOf(_status):null;
			Date startDate = (_startDate != null && !"".equals(_startDate))?Date.valueOf(_startDate):null;
			Date endDate = (_endDate != null && !"".equals(_endDate))?Date.valueOf(_endDate):null;
			
			Gathering project = new Gathering(0,writer,null,title,null,content,0,0,topic,local,people,null,startDate,endDate);
//			System.out.println(_psType);
//			System.out.println(psType);
			System.out.println("project = "+project);

			
			//2. 업무로직
			int result = GatheringService.enrollProject(project);
			
			//3. redirect
			request.getSession().setAttribute("msg", "프로젝트를 성공적으로 등록했습니다.");
			response.sendRedirect(request.getContextPath()+"/gathering/projectList");
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
