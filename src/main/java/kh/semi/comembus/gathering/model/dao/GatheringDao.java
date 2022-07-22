package kh.semi.comembus.gathering.model.dao;

import static kh.semi.comembus.common.JdbcTemplate.*;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import kh.semi.comembus.gathering.model.dto.Gathering;
import kh.semi.comembus.gathering.model.dto.GatheringExt;
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
				GatheringExt gathering = handleGatheringResultSet(rset);
				gathering.setRecruited_cnt(rset.getInt("recruited_cnt"));
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
	
	// Gathering에서 GatheringExt로 수정
	private GatheringExt handleGatheringResultSet(ResultSet rset) throws SQLException {
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
		return new GatheringExt(psNo, writer, psType, title, regDate, content, viewcount, bookmark, topic, local, people, status, startDate, endDate);
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
		
		String searchLocal = (String) param.get("searchLocal");
		String searchJobcode = (String) param.get("searchJobcode");
		String selectLocalKeyword = (String) param.get("selectLocalKeyword");
		String selectJobKeyword = (String) param.get("selectJobKeyword");
		String statusYN = (String) param.get("statusYN");
		System.out.println("DAO확인용 searchLocal = " + searchLocal);
		System.out.println("DAO확인용 searchJobcode = " + searchJobcode);
		System.out.println("DAO확인용 selectLocalKeyword = " + selectLocalKeyword);
		System.out.println("DAO확인용 selectJobKeyword = " + selectJobKeyword);
		System.out.println("DAO확인용 statusYN = " + statusYN);

		// where gathering_type = 'P' [str1] [str2] [str3] and end_date > sysdate)
		// [str1] = "and exists (select 1 from project_study where ps_no = ps.ps_no and upper(local) = upper('" + searchLocal + "'))"
        // [str2] = "and exists (select 2 from project_member_dept where ps_no = ps.ps_no and job_code = '" + searchJobcode + "')"
		// [str3] = "and status = '" + statusYN + "'"

		// 랜딩페이지(필터 미지정시)
		if("All".equals(selectLocalKeyword)) {
			if("All".equals(selectJobKeyword)) {
				if("All".equals(statusYN)) {
					sql = sql.replace("[str1]", " ");
					sql = sql.replace("[str2]", " ");
					sql = sql.replace("[str3]", " ");
				} else {
					sql = sql.replace("[str1]", " ");
					sql = sql.replace("[str2]", " ");
					sql = sql.replace("[str3]", "and status = '" + statusYN + "'");
				}
			} else {
				if("All".equals(statusYN)) {
					sql = sql.replace("[str1]", " ");
					sql = sql.replace("[str2]", "and exists (select 2 from project_member_dept where ps_no = ps.ps_no and job_code = '" + selectJobKeyword + "')");
					sql = sql.replace("[str3]", " ");
				} else {
					sql = sql.replace("[str1]", " ");
					sql = sql.replace("[str2]", "and exists (select 2 from project_member_dept where ps_no = ps.ps_no and job_code = '" + selectJobKeyword + "')");
					sql = sql.replace("[str3]", "and status = '" + statusYN + "'");
				}
			}
		}
		else {
			if("All".equals(selectJobKeyword)) {
				if("All".equals(statusYN)) {
					sql = sql.replace("[str1]", "and exists (select 1 from project_study where ps_no = ps.ps_no and upper(local) = upper('" + selectLocalKeyword + "'))");
					sql = sql.replace("[str2]", " ");
					sql = sql.replace("[str3]", " ");
				} else {
					sql = sql.replace("[str1]", "and exists (select 1 from project_study where ps_no = ps.ps_no and upper(local) = upper('" + selectLocalKeyword + "'))");
					sql = sql.replace("[str2]", " ");
					sql = sql.replace("[str3]", "and status = '" + statusYN + "'");
				}
			} else {
				if("All".equals(statusYN)) {
					sql = sql.replace("[str1]", "and exists (select 1 from project_study where ps_no = ps.ps_no and upper(local) = upper('" + selectLocalKeyword + "'))");
					sql = sql.replace("[str2]", "and exists (select 2 from project_member_dept where ps_no = ps.ps_no and job_code = '" + selectJobKeyword + "')");
					sql = sql.replace("[str3]", " ");
				} else {
					sql = sql.replace("[str1]", "and exists (select 1 from project_study where ps_no = ps.ps_no and upper(local) = upper('" + selectLocalKeyword + "'))");
					sql = sql.replace("[str2]", "and exists (select 2 from project_member_dept where ps_no = ps.ps_no and job_code = '" + selectJobKeyword + "')");
					sql = sql.replace("[str3]", "and status = '" + statusYN + "'");
				}
			}
		}
		System.out.println(sql);
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int)param.get("start"));
			pstmt.setInt(2, (int)param.get("end"));
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
		
		String searchLocal = (String) param.get("searchLocal");
		String searchJobcode = (String) param.get("searchJobcode");
		String selectLocalKeyword = (String) param.get("selectLocalKeyword");
		String selectJobKeyword = (String) param.get("selectJobKeyword");
		String statusYN = (String) param.get("statusYN");
		System.out.println("DAO확인용 토탈 searchLocal = " + searchLocal);
		System.out.println("DAO확인용 토탈 searchJobcode = " + searchJobcode);
		System.out.println("DAO확인용 토탈 selectLocalKeyword = " + selectLocalKeyword);
		System.out.println("DAO확인용 토탈 selectJobKeyword = " + selectJobKeyword);
		System.out.println("DAO확인용 토탈 statusYN = " + statusYN);
		
		// 랜딩페이지(필터 미지정시)
		if("All".equals(selectLocalKeyword)) {
			if("All".equals(selectJobKeyword)) {
				if("All".equals(statusYN)) {
					sql = sql.replace("[str1]", " ");
					sql = sql.replace("[str2]", " ");
					sql = sql.replace("[str3]", " ");
				} else {
					sql = sql.replace("[str1]", " ");
					sql = sql.replace("[str2]", " ");
					sql = sql.replace("[str3]", "and status = '" + statusYN + "'");
				}
			} else {
				if("All".equals(statusYN)) {
					sql = sql.replace("[str1]", " ");
					sql = sql.replace("[str2]", "and exists (select 2 from project_member_dept where ps_no = ps.ps_no and job_code = '" + selectJobKeyword + "')");
					sql = sql.replace("[str3]", " ");
				} else {
					sql = sql.replace("[str1]", " ");
					sql = sql.replace("[str2]", "and exists (select 2 from project_member_dept where ps_no = ps.ps_no and job_code = '" + selectJobKeyword + "')");
					sql = sql.replace("[str3]", "and status = '" + statusYN + "'");
				}
			}
		}
		else {
			if("All".equals(selectJobKeyword)) {
				if("All".equals(statusYN)) {
					sql = sql.replace("[str1]", "and exists (select 1 from project_study where ps_no = ps.ps_no and upper(local) = upper('" + selectLocalKeyword + "'))");
					sql = sql.replace("[str2]", " ");
					sql = sql.replace("[str3]", " ");
				} else {
					sql = sql.replace("[str1]", "and exists (select 1 from project_study where ps_no = ps.ps_no and upper(local) = upper('" + selectLocalKeyword + "'))");
					sql = sql.replace("[str2]", " ");
					sql = sql.replace("[str3]", "and status = '" + statusYN + "'");
				}
			} else {
				if("All".equals(statusYN)) {
					sql = sql.replace("[str1]", "and exists (select 1 from project_study where ps_no = ps.ps_no and upper(local) = upper('" + selectLocalKeyword + "'))");
					sql = sql.replace("[str2]", "and exists (select 2 from project_member_dept where ps_no = ps.ps_no and job_code = '" + selectJobKeyword + "')");
					sql = sql.replace("[str3]", " ");
				} else {
					sql = sql.replace("[str1]", "and exists (select 1 from project_study where ps_no = ps.ps_no and upper(local) = upper('" + selectLocalKeyword + "'))");
					sql = sql.replace("[str2]", "and exists (select 2 from project_member_dept where ps_no = ps.ps_no and job_code = '" + selectJobKeyword + "')");
					sql = sql.replace("[str3]", "and status = '" + statusYN + "'");
				}
			}
		}
		
		try {
			pstmt = conn.prepareStatement(sql);
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
	
	public List<Gathering> findMemberBookmarkList(Connection conn, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Gathering> bookmarkList = new ArrayList<>();
		String sql = prop.getProperty("findMemberBookmarkList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Gathering gathering = handleGatheringResultSet(rset);
				bookmarkList.add(gathering);
			}
		} catch (SQLException e) {
			throw new GatheringException("멤버 찜 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return bookmarkList;
	}

	public List<Gathering> findMemberBookmarkFilterList(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Gathering> bookmarkFilterlist = new ArrayList<>();
		String sql = prop.getProperty("findMemberProBookmarkFilter");
		
		String bookmarkYN = (String) param.get("bookmarkYN");
		String memberId = (String) param.get("memberId");
		// [str1] = "and exists (select 1 from bookmarked_prj_std where ps_no = ps.ps_no and member_id = '" + memberId + "')"

		// 체크 시
		if("Y".equals(bookmarkYN)) {
			sql = sql.replace("[str1]", "and exists (select 1 from bookmarked_prj_std where ps_no = ps.ps_no and member_id = '" + memberId + "')");			
		} else {
			sql = sql.replace("[str1]", " ");
		}
		System.out.println(sql);
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int)param.get("start"));
			pstmt.setInt(2, (int)param.get("end"));
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Gathering gathering = handleGatheringResultSet(rset);
				bookmarkFilterlist.add(gathering);
			}
		} catch (SQLException e) {
			throw new GatheringException("프로젝트 찜 필터 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return bookmarkFilterlist;
	}

	public int getTotalBookmarkFilter(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalbookmarkFilterContent = 0;		
		String sql = prop.getProperty("getTotalProBookmarkFilter");
		String bookmarkYN = (String) param.get("bookmarkYN");
		String memberId = (String) param.get("memberId");

		if("Y".equals(bookmarkYN)) {
			sql = sql.replace("[str1]", "and exists (select 1 from bookmarked_prj_std where ps_no = ps.ps_no and member_id = '" + memberId + "')");			
		} else {
			sql = sql.replace("[str1]", " ");
		}
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if(rset.next())
				totalbookmarkFilterContent = rset.getInt(1);
		} catch (SQLException e) {
			throw new GatheringException("프로젝트 찜 필터 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return totalbookmarkFilterContent;
	}

	public List<GatheringExt> getCapacityAll(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<GatheringExt> getCapacityAll = new ArrayList<>();
		String sql = prop.getProperty("getCapacityAll");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int)param.get("start"));
			pstmt.setInt(2, (int)param.get("end"));
			rset = pstmt.executeQuery();
			while(rset.next()) {
				GatheringExt gathering = handleGatheringExtResultSet(rset);
				getCapacityAll.add(gathering);
			}
		} catch (SQLException e) {
			throw new GatheringException("프로젝트 모집인원추가 목록 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return getCapacityAll;
	}

	private GatheringExt handleGatheringExtResultSet(ResultSet rset) {
		// TODO Auto-generated method stub
		return null;
	}
	// 선아 코드 끝
	
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
	
	public List<Gathering> findAllApldByMemberId(Connection conn, String memberId) {
		List<Gathering> gatheringApldList = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findAllApldByMemberId");
		//1:memberId
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Gathering gather = handleGatheringResultSet(rset);
				gatheringApldList.add(gather);
			}
		} catch (SQLException e) {
			throw new GatheringException("모임 지원현황 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}	
		
		return gatheringApldList;
	}
	
	public int cancelApld(Connection conn, Map<String, Object> param) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("cancelApld");
		//update member_application_status set result = 'X' where member_id = ? and ps_no = ? and result='W'
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, (String)param.get("memberId"));
			pstmt.setInt(2, (int)param.get("psNo"));
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new GatheringException("모임 지원 취소 오류", e);
		} finally {
			close(pstmt);
		}	
		
		return result;
	}
	
	/**
	 * 모임 게시글 번호로 조회하기
	 * - 지원신청 취소시 해당 게시글 정보 확인을 위해 작성했습니다. 
	 */
	public Gathering findByNo(Connection conn, int psNo) {
		Gathering gather = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findByNo");
		//1: psNo
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, psNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				gather = handleGatheringResultSet(rset);
			}
		} catch (SQLException e) {
			throw new GatheringException("모임 게시글번호 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}	
		
		return gather;
	}
	
	//수진코드 끝
	
	// 유경 코드 시작
	public int enrollProject(Connection conn, Gathering project) {
		PreparedStatement pstmt=null;
		int result = 0;
		String sql=prop.getProperty("insertProject");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, project.getWriter());
			pstmt.setObject(2, "P");
			pstmt.setString(3, project.getTitle());
			pstmt.setDate(4, project.getRegDate());
			pstmt.setString(5, project.getContent());
//			pstmt.setInt(6, project.getViewcount());
//			pstmt.setInt(7, project.getBookmark());
			pstmt.setString(8, project.getTopic());
			pstmt.setString(9, project.getLocal());
			pstmt.setInt(10, project.getPeople());
			pstmt.setObject(11, "N");
			pstmt.setDate(12, project.getStartDate());
			pstmt.setDate(13, project.getEndDate());
			
			result=pstmt.executeUpdate();
		}catch(SQLException e) {
			throw new GatheringException("프로젝트 등록 오류",e);
		}finally {
			close(pstmt);
		}
		return result;
	}

	public int getLastProjectNo(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int projectNo=0;
		//sql설정
		String sql = prop.getProperty("getLastProjectNo");
		try {
			pstmt=conn.prepareStatement(sql);
			rset=pstmt.executeQuery();
			if(rset.next()) {
				projectNo=rset.getInt(1);
			}
		}catch(SQLException e) {
			throw new GatheringException("생성된 프로젝트번호 조회 오류",e);
		}finally {
			close(rset);
			close(pstmt);
		}
		return projectNo;
	}
	
	private GatheringExt handleProjectResultSet(ResultSet rset) throws SQLException{
		int psNo=rset.getInt("psNo");
		String writer = rset.getString("writer");
		GatheringType psType = GatheringType.valueOf(rset.getString("psType"));
		String title = rset.getString("title");
		Date regDate = rset.getDate("reg_date");
		String content = rset.getString("content");
		int viewcount = rset.getInt("viewcount");
		int bookmark = rset.getInt("bookmark");
		String topic = rset.getString("topic");
		String local = rset.getString("local");
		int people = rset.getInt("people");
		Status status = Status.valueOf(rset.getString("status"));
		Date start_date = rset.getDate("start_date");
		Date end_date = rset.getDate("end_date");
//		String planning = rset.getString(")
		
		
		return new GatheringExt(psNo,writer,psType,title,regDate,content,viewcount,bookmark,topic,local,people,status,start_date,end_date);
	}

}
