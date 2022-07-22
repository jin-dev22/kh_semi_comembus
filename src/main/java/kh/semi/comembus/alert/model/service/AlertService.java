package kh.semi.comembus.alert.model.service;

import static kh.semi.comembus.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import kh.semi.comembus.alert.model.dao.AlertDao;
import kh.semi.comembus.alert.model.dao.AlertException;
import kh.semi.comembus.alert.model.dto.Alert;
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
			result = alertDao.insertCancelAlert(conn, alert);
			//user alert
			if(ComembusWebSocket.isConnected(alert.getReceiverId())) {
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
			result = alertDao.insertCancelAlert(conn, alert);
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
	 * 알림 객체를 받아서 웹소켓sendMessage에 전달할 data맵 반환
	 */
	public Map<String, Object> handleAlertData(Alert alert){
		Map<String, Object> data = new HashMap<>();
		data.put("receiver", alert.getReceiverId());
		data.put("msg", alert.getContent());
		return data;
	}
}
