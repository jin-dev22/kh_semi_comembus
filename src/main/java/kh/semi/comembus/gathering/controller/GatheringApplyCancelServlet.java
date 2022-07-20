package kh.semi.comembus.gathering.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.semi.comembus.gathering.model.service.GatheringService;

/**
 * 모임 지원 취소하기 
 */
@WebServlet("/gathering/apply/cancel")
public class GatheringApplyCancelServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private GatheringService gatheringService = new GatheringService(); 
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//지원 취소할 모임 게시글 번호와 취소한 회원 아이디 받아오기
			String memberId = request.getParameter("memberId");
			int psNo = Integer.parseInt(request.getParameter("psNo"));
			Map<String, Object> param = new HashMap<>();
			param.put("memberId", memberId);
			param.put("psNo", psNo);
			
			System.out.println("@ApldCcServ: memId, psNo>>"+memberId + ", "+ psNo);
			
			//지원현황 테이블에서 지원결과 'X'로 변경
			int result = gatheringService.cancelApld(param);
			System.out.println("@ApldCcServ: result>>"+result);
			//변경결과적용되도록 다시 화면 로딩
			String referer = request.getHeader("Referer");
			response.sendRedirect(referer);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
