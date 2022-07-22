package kh.semi.comembus.alert.model.dao;

import static kh.semi.comembus.common.JdbcTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Map;
import java.util.Properties;

import kh.semi.comembus.alert.model.dto.Alert;

public class AlertDao {

	private Properties prop = new Properties();
	public AlertDao() {
		String filename = AlertDao.class.getResource("/sql/alert/alert-query.properties").getPath();
		System.out.println("filename@MemberDao = " + filename);
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	public int insertCancelAlert(Connection conn, Alert alert) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertCancelAlert");
		//insert into member_notification values(seq_alert_no.nextval, ?, ?, null, ?, ?, default)
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, alert.getReceiverId());
			pstmt.setInt(2, alert.getPsNo());
			pstmt.setString(3, alert.getMessageType().name());
			pstmt.setString(4, alert.getContent());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new AlertException("알림정보 저장 오류", e);
		} finally {
			close(pstmt);
		}	
		return result;
	}

	public int insertReplAlert(Connection conn, Alert alert) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertReplAlert");
		//insert into member_notification values(seq_alert_no.nextval, ?,null, ?, ?, ?, default)
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, alert.getReceiverId());
			pstmt.setInt(2, alert.getReplNo());
			pstmt.setString(3, alert.getMessageType().name());
			pstmt.setString(4, alert.getContent());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new AlertException("알림정보 저장 오류", e);
		} finally {
			close(pstmt);
		}	
		return result;
	}
}
