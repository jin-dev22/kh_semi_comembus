package kh.semi.comembus.admin.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.semi.comembus.common.ComembusUtils;
import kh.semi.comembus.member.model.dto.Member;
import kh.semi.comembus.member.model.service.MemberService;


/**
 * Servlet implementation class AdminMemberFinder
 */
@WebServlet("/admin/memberFinder")
public class AdminMemberFinder extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int cPage = 1;
			int numPerPage = 10;
			
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch (NumberFormatException e) {}
			
			String searchType = request.getParameter("searchType");
			String searchKeyword = request.getParameter("searchKeyword");
			
			Map<String, Object> param = new HashMap<>();
			param.put("searchType", searchType);
			param.put("searchKeyword", searchKeyword);
			param.put("start", (cPage - 1) * numPerPage + 1);
			param.put("end", cPage * numPerPage);
	
			List<Member> memberList = memberService.adminFindMemberLike(param);
			System.out.println("memberList = " + memberList);
			
	
			int totalContent = memberService.adminGetTotalMemberNumLike(param); 
			System.out.println("totalContent = " + totalContent);
			
			String url = request.getRequestURI() + "?searchType=" + searchType + "&searchKeyword=" + searchKeyword; 
			
			String pagebar = ComembusUtils.getPagebar(cPage, numPerPage, totalContent, url);
		
			request.setAttribute("memberList", memberList);
			request.setAttribute("pagebar", pagebar);
			
			request.getRequestDispatcher("/WEB-INF/views/admin/memberList.jsp")
					.forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
