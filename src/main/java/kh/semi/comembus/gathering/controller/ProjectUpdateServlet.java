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

import kh.semi.comembus.gathering.model.dto.Gathering;
import kh.semi.comembus.gathering.model.dto.GatheringExt;
import kh.semi.comembus.gathering.model.service.GatheringService;

/**
 * Servlet implementation class ProjectEditServlet
 */
@WebServlet("/gathering/projectUpdateView")
public class ProjectUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private GatheringService gatheringService = new GatheringService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int psNo =Integer.parseInt(request.getParameter("psNo"));
			System.out.println("servlet : "+psNo);
			Gathering project = gatheringService.findByNo(psNo);
			request.setAttribute("project", project);
			request.getRequestDispatcher("/WEB-INF/views/gathering/projectUpdate.jsp")
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
			
			//1.1 사용자 입력값 처리 (project_study테이블 저장)
			int psNo = Integer.parseInt(request.getParameter("psNo"));
			// System.out.println(psNo);
			String title = request.getParameter("title");
			String content = request.getParameter("editordata");
			// System.out.println(content);
			String topic = request.getParameter("topic");
			String local = request.getParameter("local");
			String _startDate = request.getParameter("date_start");
			String _endDate = request.getParameter("date_end");
			
			Date startDate = (_startDate != null && !"".equals(_startDate))?Date.valueOf(_startDate):null;
			Date endDate = (_endDate != null && !"".equals(_endDate))?Date.valueOf(_endDate):null;
			
			//입력정보로 project_study테이블 먼저 수정
			Gathering project = new Gathering(psNo, null, null, title, null, content, 0, 0, null, local, people, null, startDate, endDate);
			int result = gatheringService.updateProject(project);
			
			//수정한 프로젝트 조회해오기(확인용)
			GatheringExt newPro = (GatheringExt)gatheringService.findByNo(psNo);
			
			//직무별 모집인원테이블 변경. 하 드 코 딩
			Map<String, Object> param = new HashMap<>();
			param.put("psNo", psNo);
			
			param.put("jobCode", "PL");
			param.put("num", planning_cnt);
			int isExist = gatheringService.isExistRow(param); 
			if(isExist == 0) {
				int insertZero = gatheringService.insertZeroToDept(param);
			}
			result = gatheringService.updateNumByDept(param); 
			
			param.put("jobCode","DG");
			param.put("num", design_cnt);
			isExist = gatheringService.isExistRow(param); 
			if(isExist == 0) {
				int insertZero = gatheringService.insertZeroToDept(param);
			}
			result = gatheringService.updateNumByDept(param); 
			
			param.put("jobCode","BE");
			param.put("num", backend_cnt);
			isExist = gatheringService.isExistRow(param); 
			if(isExist == 0) {
				int insertZero = gatheringService.insertZeroToDept(param);
			}
			result = gatheringService.updateNumByDept(param); 
						
			param.put("jobCode","FE");
			param.put("num", frontend_cnt);
			isExist = gatheringService.isExistRow(param); 
			if(isExist == 0) {
				int insertZero = gatheringService.insertZeroToDept(param);
			}
			result = gatheringService.updateNumByDept(param); 
			

			System.out.println("project = "+project);
			
			
			//3. redirect
			request.getSession().setAttribute("msg", "프로젝트를 성공적으로 수정했습니다.");
			response.sendRedirect(request.getContextPath()+"/gathering/projectList");
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
