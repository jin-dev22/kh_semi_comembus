package kh.semi.comembus.member.model.dao;

import static kh.semi.comembus.common.JdbcTemplate.close;

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

import kh.semi.comembus.member.model.dto.JobCode;
import kh.semi.comembus.member.model.dto.Member;
import kh.semi.comembus.member.model.dto.MemberExt;
import kh.semi.comembus.member.model.dto.MemberRole;
import kh.semi.comembus.member.model.dto.QuitYN;
import kh.semi.comembus.member.model.exception.MemberException;

public class MemberDao {
	
	private Properties prop = new Properties();
	
	// 미송 코드 시작
	public MemberDao() {
		String filename = MemberDao.class.getResource("/sql/member/member-query.properties").getPath();
		System.out.println("filename@MemberDao = " + filename);
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public Member findById(Connection conn, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Member member = null;
		String sql = prop.getProperty("findById");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				member = handleMemberResultSet(rset);
			}
			
		} catch (SQLException e) {
			throw new MemberException("회원 아이디 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return member;
	}
	
	private MemberExt handleMemberResultSet(ResultSet rset) throws SQLException {
		String memberId = rset.getString("member_id"); 
		JobCode jobCode = JobCode.valueOf(rset.getString("job_code"));
		String nickName = rset.getString("member_nickname"); 
		String memberName = rset.getString("member_name"); 
		String password = rset.getString("password"); 
		String phone = rset.getString("phone");
		String introduction = rset.getString("introduction");
		MemberRole memberRole = MemberRole.valueOf(rset.getString("member_role"));
		Date enrollDate = rset.getDate("enroll_date");
		Date quitDate = rset.getDate("quit_date") != null ? rset.getDate("quit_date") : null;
		QuitYN quitYN = QuitYN.valueOf(rset.getString("quit_yn"));
		return new MemberExt(memberId, jobCode, nickName, memberName, password, phone, introduction, memberRole, enrollDate, quitDate, quitYN);
		
	}
	// 미송 코드 끝
	
	
	
	// 수진 코드 시작	
	/**
	 * 멤버스 메인페이지 : 전체회원 목록반환
	 */
	public List<Member> findAll(Connection conn, Map<String, Object> param) {
		List<Member> memberList = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findAll");

		//목록 번호 시작, 끝 입력
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int) param.get("start"));
			pstmt.setInt(2, (int) param.get("end"));
			rset = pstmt.executeQuery();
			while(rset.next()) {
				MemberExt member = handleMemberResultSet(rset);
				member.setGetheringCnt(rset.getInt("gathering_cnt"));
				//System.out.println("@dao gatherCnt>> "+member.getNickName()+": "+ member.getGetheringCnt());
				memberList.add(member);
			}
		} catch (SQLException e) {
			throw new MemberException("멤버스 전체조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return memberList;
	}
	
	/**
	 * 멤버스 메인페이지 : 페이징 처리용 전체회원 수 반환
	 */
	public int getTotalMembusNum(Connection conn) {
		int totalMembusNum = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getTotalMembusNum");
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				totalMembusNum = rset.getInt(1);
			}
		} catch (SQLException e) {
			throw new MemberException("총 회원수 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return totalMembusNum;
	}

	/**
	 * 멤버스 메인페이지 : 멤버스 조건 검색시 회원목록 반환
	 */
	public List<Member> findMemberLike(Connection conn, Map<String, Object> param) {
		List<Member> memberList = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findMemberLike");
		
		String jobCode = (String) param.get("searchJobCode");
		String keyword = (String) param.get("searchKeyword");
		String gatheringYN = (String) param.get("searchGatheringYN");
		/**
		 * 	sql문 조건추가
		 * 	[str1] = "and job_code = " + param.get("searchJobCode");
		 *	[str2] = "and upper(member_nickname) like upper('%"+"param.get("searchKeyword")"+"%')";
		 *	[str3] = "gathering_cnt >"+param.get("searchGatheringYN"); 
		 */
		if(!"ALL".equals(jobCode)) {
			sql = sql.replace("[str1]", "and job_code = '" + jobCode +"'");
		}else {
			sql = sql.replace("[str1]", " ");
		}
		
		if(!keyword.isEmpty()) {
			sql = sql.replace("[str2]", "and upper(member_nickname) like upper('%"+keyword+"%')");			
		}else {
			sql = sql.replace("[str2]", " ");
		}
		
		if("Y".equals(gatheringYN)) {
			sql = sql.replace("[str3]", "gathering_cnt > 0 and");
		}else if("N".equals(gatheringYN)) {
			sql = sql.replace("[str3]", "gathering_cnt = 0 and");
		}else {
			sql = sql.replace("[str3]", " ");
		}
		
		//System.out.println("@Dao:Sql>>"+sql);
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int) param.get("start"));
			pstmt.setInt(2, (int) param.get("end"));
			rset = pstmt.executeQuery();
			while(rset.next()) {
				MemberExt member = handleMemberResultSet(rset);
				member.setGetheringCnt(rset.getInt("gathering_cnt"));
				memberList.add(member);
				//System.out.println("@dao>> "+member);
			}
		} catch (SQLException e) {
			throw new MemberException("멤버스 조건조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return memberList;
	}

	public int getTotalMembusNumLike(Connection conn, Map<String, Object> param) {
		int totalMembusNumlike = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getTotalMembusNumLike");
	
		String jobCode = (String) param.get("searchJobCode");
		String keyword = (String) param.get("searchKeyword");
		String gatheringYN = (String) param.get("searchGatheringYN");
		//select count(*) from (select m.*, (select  count(*) from  project_study where ps_no in (select ps_no from member_application_status where member_id = m.member_id and result = 'O') and sysdate between start_date and end_date) gathering_cnt from member m  where quit_yn = 'N' [str1] [str2] ) m [str3]
		if(!"ALL".equals(jobCode)) {
			sql = sql.replace("[str1]", "and job_code = '" + jobCode +"'");
		}else {
			sql = sql.replace("[str1]", " ");
		}
		
		if(!keyword.isEmpty()) {
			sql = sql.replace("[str2]", "and upper(member_nickname) like upper('%"+keyword+"%')");
		}else {
			sql = sql.replace("[str2]", " ");
		}
		 
		if("Y".equals(gatheringYN)) {
			sql = sql.replace("[str3]", "where gathering_cnt > 0");
		}else if("N".equals(gatheringYN)) {
			sql = sql.replace("[str3]", "where gathering_cnt = 0");
		}else {
			sql = sql.replace("[str3]", " ");
		}
		//System.out.println("@dao:memNumSql>>"+sql);
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				totalMembusNumlike = rset.getInt(1);
			}			
		} catch (SQLException e) {
			throw new MemberException("회원 조건 검색 결과 수 조회 오류", e);
		}finally {
			close(rset);
			close(pstmt);
		}
		return totalMembusNumlike;
	}
	
	
	// 수진 코드 끝

}
