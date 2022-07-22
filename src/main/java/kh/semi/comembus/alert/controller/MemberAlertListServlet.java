package kh.semi.comembus.alert.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kh.semi.comembus.member.model.dto.Member;

/**
 * Servlet implementation class MemberAlertListServlet
 */
@WebServlet("/alertList")
public class MemberAlertListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Member member = (Member) session.getAttribute("loginMember");
		//멤버아이디로 알림테이블 조회. 리스트객체 속성에 넣어서 응답처리
	}

}
