package kh.semi.comembus.admin.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kh.semi.comembus.member.model.service.MemberService;

/**
 * Servlet implementation class AdminMemberEnrollNumberServlet
 */
@WebServlet("/admin/memberEnrollNumPeriod")
public class AdminMemberEnrollNumberPeriodServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
   
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			String startDate = request.getParameter("inputStartDate");
			String endDate = request.getParameter("inputEndDate");
			// System.out.println("startDate = " + startDate + ", endDate =" + endDate);
			
			Map<String, Object> param = new HashMap<>();
			param.put("startDate", startDate);
			param.put("endDate", endDate);
			
			int memberEnrollNumPeriod = memberService.getMemberEnrollNumPeriod(param);
			// System.out.println("memberEnrollNumPeriod = " + memberEnrollNumPeriod);
			
			response.setContentType("application/json; charset=utf-8");
			String jsonStr = new Gson().toJson(memberEnrollNumPeriod);
			response.getWriter().print(jsonStr);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		

	
	}


}
