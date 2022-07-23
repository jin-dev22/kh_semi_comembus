package kh.semi.comembus.alert.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kh.semi.comembus.alert.model.dto.AlertExt;
import kh.semi.comembus.alert.model.service.AlertService;
import kh.semi.comembus.community.model.dto.Community;
import kh.semi.comembus.community.model.service.CommunityService;
import kh.semi.comembus.member.model.dto.Member;

/**
 * Servlet implementation class MemberAlertListServlet
 */
@WebServlet("/alerts")
public class MemberAlertListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private AlertService alertService = new AlertService(); 
    private CommunityService communityService = new CommunityService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			Member member = (Member) session.getAttribute("loginMember");
			String memberId = member.getMemberId();
			//페이징처리
			int cPage = 1;
			int numPerPage = 3;
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch (NumberFormatException e) {}
			int start = (cPage - 1) * numPerPage + 1;
			int end = cPage * numPerPage;
			Map<String, Object> param = new HashMap<>();
			param.put("start", start);
			param.put("end", end);
			param.put("memberId", memberId);
			
			
			
			//멤버아이디로 알림테이블 조회. 리스트객체 속성에 넣어서 응답처리
			List<AlertExt> alerts = alertService.findAlertsByMemberId(param);
			if(alerts != null && !alerts.isEmpty()) {
				for(int i = 0; i < alerts.size(); i++) {
					int replNo = alerts.get(i).getReplNo();
					if(replNo > 0) {//모임관련 알림일경우 null체크
						Community comm = communityService.getCoNoByReplNo(replNo);
						alerts.get(i).setCoNo(comm.getCoNo());
						alerts.get(i).setCoType(comm.getCoType());						
					}
				}
			}
			
			//페이징용 총 알림수
			int totalAlertNum = alertService.getTotalAlertNum(memberId);
			
			request.setAttribute("alerts", alerts);
			request.getRequestDispatcher("/WEB-INF/views/member/memberAlertList.jsp").forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 알림 확인여부 처리후 리다이렉트
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int alertNo = Integer.parseInt(request.getParameter("alertNo"));
			String url = request.getParameter("originUrl");
			//db에 update
			int result = alertService.alertHasRead(alertNo); 
			
			response.sendRedirect(url);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
}
