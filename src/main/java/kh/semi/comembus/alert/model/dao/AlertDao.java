package kh.semi.comembus.alert.model.dao;

import static kh.semi.comembus.common.JdbcTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import kh.semi.comembus.alert.model.dto.Alert;
import kh.semi.comembus.alert.model.dto.AlertExt;
import kh.semi.comembus.alert.model.dto.IsRead;
import kh.semi.comembus.alert.model.dto.MessageType;
import kh.semi.comembus.community.model.exception.CommunityException;

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
	
	
	public int insertGatheringAlert(Connection conn, Alert alert) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertGatheringAlert");
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

	/**
	 * 알림목록 반환:
	 * 커뮤니티 게시글번호는 다시 서블릿에서 조회 후 추가하는 방식으로 작성.
	 */
	public List<AlertExt> findAlertsByMemberId(Connection conn, Map<String, Object> param) {
		List<AlertExt> alerts = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findAlertsByMemberId");		
		try {//아이디, start, end
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, (String)param.get("memberId"));
			pstmt.setInt(2, (int)param.get("start"));
			pstmt.setInt(3, (int)param.get("end"));
			rset = pstmt.executeQuery();
			while(rset.next()) {
				AlertExt al = new AlertExt(); 
				al.setAlertNo(rset.getInt("alert_no"));
				al.setReceiverId((String)param.get("memberId"));
				al.setPsNo(rset.getInt("ps_no"));
				al.setReplNo(rset.getInt("repl_no"));
				al.setMessageType(MessageType.valueOf(rset.getString("notice_type")));
				al.setContent(rset.getString("content"));
				al.setIsRead(IsRead.valueOf(rset.getString("is_read")));
				
				alerts.add(al);
			}
		} catch (SQLException e) {
			throw new AlertException("알림정보 저장 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return alerts;
	}


	public int alertHasRead(Connection conn, int alertNo) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("alertHasRead");
		//update member_notification set is_read = 'Y' where alert_no = ?
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, alertNo);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new AlertException("알림정보 저장 오류", e);
		} finally {
			close(pstmt);
		}	
		return result;
	}


	public int getTotalAlertNum(Connection conn, String memberId) {
		int totalAlertNum = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getTotalAlertNum");
		//select count(*) from member_notification where member_id = ? and is_read = 'N'
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				totalAlertNum = rset.getInt(1);
			}
		} catch (SQLException e) {
			throw new AlertException("회원 알림개수 조회 오류",e);
		}finally {
			close(rset);
			close(pstmt);
		}
		return totalAlertNum;
	}


	public String getPsTypeOfAlert(Connection conn, int alertNo) {
		String type = "";
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getPsTypeOfAlert");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, alertNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				type = rset.getString(1);
			}
		} catch (SQLException e) {
			throw new AlertException("회원 알림정보 연결 오류",e);
		}finally {
			close(rset);
			close(pstmt);
		}
		return type;
	}

}
