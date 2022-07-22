package kh.semi.comembus.gathering.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.semi.comembus.gathering.model.service.GatheringService;

/**
 * Servlet implementation class studyEnrollViewServlet
 */
@WebServlet("/gathering/studyEnrollView")
public class studyEnrollViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private GatheringService projectService = new GatheringService();

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
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
