package kh.semi.comembus.common;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/terms")
public class TermsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("no"));
		
		if(no == 1) {
			request.getRequestDispatcher("/WEB-INF/views/common/terms_1.jsp")
				.forward(request, response);
		} 
		else{
			request.getRequestDispatcher("/WEB-INF/views/common/terms_2.jsp")
				.forward(request, response);
		}
	}

}
