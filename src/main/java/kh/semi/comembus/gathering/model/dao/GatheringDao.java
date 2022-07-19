package kh.semi.comembus.gathering.model.dao;

import static kh.semi.comembus.common.JdbcTemplate.*;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import kh.semi.comembus.gathering.model.dto.Gathering;
import kh.semi.comembus.gathering.model.dto.GatheringType;
import kh.semi.comembus.gathering.model.dto.Status;
import kh.semi.comembus.gathering.model.exception.GatheringException;

public class GatheringDao {
	private Properties prop = new Properties();
	
	public GatheringDao() {
		String filename = GatheringDao.class.getResource("/sql/gathering/gathering-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public List<Gathering> findGatheringAll(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Gathering> projectList = new ArrayList<>();
		String sql = prop.getProperty("findProjectAll");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int)param.get("start"));
			pstmt.setInt(2, (int)param.get("end"));
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Gathering gathering = handleGatheringResultSet(rset);
				projectList.add(gathering);
			}
		} catch (SQLException e) {
			throw new GatheringException("프로젝트 목록 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return projectList;
	}

	private Gathering handleGatheringResultSet(ResultSet rset) throws SQLException {
		int psNo = rset.getInt("ps_no");
		String writer = rset.getString("writer");
		GatheringType psType = GatheringType.valueOf(rset.getString("gathering_type"));
		String title = rset.getString("title");
		Date regDate = rset.getDate("reg_date");
		String content = rset.getString("content");
		int viewcount = rset.getInt("viewcount");
		int bookmark = rset.getInt("bookmark");
		String topic = rset.getString("topic");
		String local = rset.getString("local");
		int people = rset.getInt("people");
		Status status = Status.valueOf(rset.getString("status"));
		Date startDate = rset.getDate("start_date");
		Date endDate = rset.getDate("end_date");
		return new Gathering(psNo, writer, psType, title, regDate, content, viewcount, bookmark, topic, local, people, status, startDate, endDate);
	}

	public int getTotalContent(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalContent = 0;
		String sql = prop.getProperty("getProjectTotalContent");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if(rset.next())
				totalContent = rset.getInt(1);
		} catch (SQLException e) {
			throw new GatheringException("총 프로젝트 게시물 수 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}		
		return totalContent;
	}

	public List<Gathering> findProjectLike(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Gathering> list = new ArrayList<>();
		String sql = prop.getProperty("findProjectLike");
		String col = (String) param.get("searchType");
		String val = (String) param.get("searchKeyword");
		sql = sql.replace("#", col);
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, val);
			pstmt.setInt(2, (int)param.get("start"));
			pstmt.setInt(3, (int)param.get("end"));
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Gathering gathering = handleGatheringResultSet(rset);
				list.add(gathering);
			}
		} catch (SQLException e) {
			throw new GatheringException("프로젝트 필터 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public int getProTotalContentLike(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalContent = 0;
		String sql = prop.getProperty("getProTotalContentLike");
		String col = (String) param.get("searchType");
		String val = (String) param.get("searchKeyword");
		sql = sql.replace("#", col);
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, val);
			rset = pstmt.executeQuery();
			if(rset.next())
				totalContent = rset.getInt(1);
		} catch (SQLException e) {
			throw new GatheringException("프로젝트 필터 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return totalContent;
	}

	//수진코드 시작
	/**
	 * 멤버스 프로필,마이페이지: 회원 참가중인 모임 게시글 조회
	 */
	public List<Gathering> findAllByMemberId(Connection conn, String memberId) {
		List<Gathering> gatheringIngList = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findAllByMemberId");
		//1:memberId
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Gathering gather = handleGatheringResultSet(rset);
				gatheringIngList.add(gather);
			}
		} catch (SQLException e) {
			throw new GatheringException("참여중 모임 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}	
		
		return gatheringIngList;
	}
	
	public List<Gathering> findAllBookmarked(Connection conn, String memberId) {
		List<Gathering> gatheringBookmarkList = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findAllBookmarked");
		//1:memberId
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Gathering gather = handleGatheringResultSet(rset);
				gatheringBookmarkList.add(gather);
			}
		} catch (SQLException e) {
			throw new GatheringException("찜하기 모임 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}	
		return gatheringBookmarkList;
	}
	//수진코드 끝

}
