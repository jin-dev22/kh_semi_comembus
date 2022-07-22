package kh.semi.comembus.gathering.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.semi.comembus.alert.model.dto.Alert;
import kh.semi.comembus.alert.model.dto.IsRead;
import kh.semi.comembus.alert.model.dto.MessageType;
import kh.semi.comembus.alert.model.service.AlertService;
import kh.semi.comembus.gathering.model.dto.Gathering;
import kh.semi.comembus.gathering.model.service.GatheringService;

/**
 * 모임 지원 취소하기 
 */
@WebServlet("/gathering/apply/cancel")
public class GatheringApplyCancelServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private GatheringService gatheringService = new GatheringService(); 
	private AlertService alertService = new AlertService();
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
			
//			System.out.println("@ApldCcServ: memId, psNo>>"+memberId + ", "+ psNo);
			
			//지원현황 테이블에서 지원결과 'X'로 변경
			int result = gatheringService.cancelApld(param);
//			System.out.println("@ApldCcServ: result>>"+result);
			
			//모임장에게 지원신청 취소 알림
			String nickName = request.getParameter("nickName");
			Gathering gather = gatheringService.findByNo(psNo);
			//알림내용 글자 수 줄이기
			String title = gather.getTitle();
			String substrTitle = title.length() > 8? title.substring(0, 7)+"...": title;
			String substrNick = nickName.length() > 5? nickName.substring(0, 4)+"..." : nickName;
			String alertContent = "["+substrTitle +"] 지원자 ["+substrNick+"]님이 지원을 취소했습니다.";
			
			Alert alert = new Alert(0, gather.getWriter(), psNo, 0, MessageType.APPLY_CANCELED, alertContent, IsRead.N);
			result = alertService.notifyCancelApld(alert);
			
			//마이페이지에서 지원취소내용이 적용되도록 다시 화면 로딩
			response.sendRedirect(request.getContextPath() +"/membus/mypage");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
