package kh.semi.comembus.gathering.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.semi.comembus.gathering.model.dto.GatheringExt;
import kh.semi.comembus.gathering.model.service.GatheringService;

/**
 * Servlet implementation class projectEnrollViewServlet
 */
@WebServlet("/gathering/projectEnrollView")
public class projectEnrollViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private GatheringService gatheringService = new GatheringService();
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
			// people 합계 처리
			int planning_cnt=0;
			int design_cnt=0;
			int frontend_cnt=0;
			int backend_cnt=0;
			//0. people값 처리
			String planning = request.getParameter("planning");
			if(planning !="") {
				planning_cnt = Integer.parseInt(request.getParameter("planning_cnt"));
			}
			String design = request.getParameter("design");
			if(design != "") {
				design_cnt = Integer.parseInt(request.getParameter("design_cnt"));
			}
			String frontend = request.getParameter("frontend");
			if(frontend != "") {
				frontend_cnt = Integer.parseInt(request.getParameter("frontend_cnt"));
			}
			String backend = request.getParameter("backend");
			if(backend != "") {
				backend_cnt = Integer.parseInt(request.getParameter("backend_cnt"));
			}
			
			System.out.println(">> planning = " + planning);
			System.out.println(">> planning_cnt = " + planning_cnt);
			System.out.println(">> design = " + design);
			System.out.println(">> design_cnt = " + design_cnt);
			System.out.println(">> frontend = " + frontend);
			System.out.println(">> frontend_cnt = " + frontend_cnt);
			System.out.println(">> backend = " + backend);
			System.out.println(">> backend_cnt = " + backend_cnt);
			
			// 사용자 입력값 처리 (project_study테이블 저장)
			String writer = request.getParameter("writer");
			String title = request.getParameter("title");
			String _regDate = request.getParameter("reg_date");
			String content = request.getParameter("editordata");
			String topic = request.getParameter("topic");
			String local = request.getParameter("local");
			String _startDate = request.getParameter("date_start");
			String _endDate = request.getParameter("date_end");
			int people = planning_cnt+design_cnt+frontend_cnt+backend_cnt;
			
			Date startDate = (_startDate != null && !"".equals(_startDate))?Date.valueOf(_startDate):null;
			Date endDate = (_endDate != null && !"".equals(_endDate))?Date.valueOf(_endDate):null;

			GatheringExt project = new GatheringExt(0, writer, null, title, null, content, 0, 0, topic, local, people, null, startDate, endDate);
			
			
			Map<Object,Object> parameter = new HashMap<>();
			Map<String,Object> parameterDep = new HashMap<>();
			parameter.put("project", project);
			parameterDep.put("planning",planning);
			parameterDep.put("planning_cnt", planning_cnt);
			parameterDep.put("design", design);
			parameterDep.put("design_cnt", design_cnt);
			parameterDep.put("frontend", frontend);
			parameterDep.put("frontend_cnt", frontend_cnt);
			parameterDep.put("backend", backend);
			parameterDep.put("backend_cnt", backend_cnt);
			parameter.put("parameterDep", parameterDep);
			System.out.println("확인용 parameter = " + parameter);
			
			//2. 업무로직
			int result = gatheringService.enrollProject(parameter);
			
			//3. redirect
			request.getSession().setAttribute("msg", "프로젝트를 성공적으로 등록했습니다.");
			response.sendRedirect(request.getContextPath()+"/gathering/projectList");
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
