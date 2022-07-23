package kh.semi.comembus.alert.model.service;

import static kh.semi.comembus.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kh.semi.comembus.alert.model.dao.AlertDao;
import kh.semi.comembus.alert.model.dao.AlertException;
import kh.semi.comembus.alert.model.dto.Alert;
import kh.semi.comembus.alert.model.dto.AlertExt;
import kh.semi.comembus.alert.model.dto.MessageType;
import kh.semi.comembus.community.model.dto.Community;
import kh.semi.comembus.gathering.model.dto.Gathering;
import kh.semi.comembus.ws.endpoint.ComembusWebSocket;

public class AlertService {

	AlertDao alertDao = new AlertDao();
	
	/**
	 * 새댓글알림
	 */
	public int notifyNewComment(Alert alert) {
		Connection conn = getConnection();
		System.out.println("@알림서비스:새댓글");
		int result = 0;
		try {
			// db insert
			result = alertDao.insertReplAlert(conn, alert);
			//user alert
			if(ComembusWebSocket.isConnected(alert.getReceiverId())&& result == 1) {
				System.out.println(">새댓글 알림. 수신자 접속중..");
				ComembusWebSocket.sendMessage(MessageType.NEW_COMMENT, handleAlertData(alert));
			}
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}
	
	/**
	 * 모임지원취소 알림
	 */
	public int notifyCancelApld(Alert alert) {
		Connection conn = getConnection();
		System.out.println("@알림서비스:지원취소");
		int result = 0;
		try {
			// db insert
			result = alertDao.insertGatheringAlert(conn, alert);
			//user alert
			if(ComembusWebSocket.isConnected(alert.getReceiverId()) && result == 1) {
				System.out.println(">지원취소 알림. 수신자 접속중..");
				ComembusWebSocket.sendMessage(MessageType.APPLY_CANCELED, handleAlertData(alert));
			}
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}
	
	/**
	 * 모임 지원자발생 알림
	 */
	public int notifyNewAplcnt(Alert alert) {
		Connection conn = getConnection();
		System.out.println("@알림서비스:신규지원자");
		int result = 0;
		try {
			// db insert
			result = alertDao.insertGatheringAlert(conn, alert);
			//user alert
			if(ComembusWebSocket.isConnected(alert.getReceiverId()) && result == 1) {
				System.out.println(">지원자 발생 알림. 수신자 접속중..");
				ComembusWebSocket.sendMessage(MessageType.NEW_APPLICANT, handleAlertData(alert));
			}
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}
	
	/**
	 * 모임 지원결과알림
	 */
	public int notifyAplcntResult(Alert alert) {
		Connection conn = getConnection();
		System.out.println("@알림서비스:지원결과");
		int result = 0;
		try {
			// db insert
			result = alertDao.insertGatheringAlert(conn, alert);
			//user alert
			if(ComembusWebSocket.isConnected(alert.getReceiverId()) && result == 1) {
				System.out.println(">지원결과 알림. 수신자 접속중..");
				ComembusWebSocket.sendMessage(MessageType.APPLY_RESULT, handleAlertData(alert));
			}
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}
	
	/**
	 * 알림 객체를 받아서 웹소켓sendMessage에 전달할 data맵 반환
	 */
	public Map<String, Object> handleAlertData(Alert alert){
		Map<String, Object> data = new HashMap<>();
		data.put("receiver", alert.getReceiverId());
		data.put("msg", alert.getContent());
		return data;
	}
	
	/**
	 * 알림목록페이지 : 멤버아이디로 해당알림목록 반환
	 */
	public List<AlertExt> findAlertsByMemberId(Map<String, Object> param) {
		Connection conn = getConnection();
		List<AlertExt> alerts = alertDao.findAlertsByMemberId(conn, param);
		close(conn);
		return alerts;
	}

	/**
	 * 알림 읽음처리
	 */
	public int alertHasRead(int alertNo) {
		Connection conn = getConnection();
		int result = alertDao.alertHasRead(conn, alertNo);
		close(conn);
		return result;
	}

	/**
	 * 알림목록 페이징용 총 알림수 
	 */
	public int getTotalAlertNum(String memberId) {
		Connection conn = getConnection();
		int totalAlertNum = alertDao.getTotalAlertNum(conn, memberId);
		close(conn);
		return totalAlertNum; 
	}
}
