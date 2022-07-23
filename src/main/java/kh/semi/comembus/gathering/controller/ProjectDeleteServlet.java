package kh.semi.comembus.gathering.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.semi.comembus.gathering.model.service.GatheringService;

/**
 * Servlet implementation class ProjectDeleteServlet
 */
@WebServlet("/gathering/projectDelete")
public class ProjectDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private GatheringService gatheringService = new GatheringService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int psNo = Integer.parseInt(request.getParameter("psNo"));
			System.out.println("psNo = "+ psNo);
			
			//project삭제
			int result = gatheringService.deleteProject(psNo);
			
			//3. 리다이렉트
			request.getSession().setAttribute("msg", "프로젝트를 성공적으로 삭제했습니다.");
			response.sendRedirect(request.getContextPath()+"/gathering/projectList");
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
