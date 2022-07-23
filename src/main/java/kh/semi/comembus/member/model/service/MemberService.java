package kh.semi.comembus.member.model.service;

import static kh.semi.comembus.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import kh.semi.comembus.member.model.dao.MemberDao;
import kh.semi.comembus.member.model.dto.JobCode;
import kh.semi.comembus.member.model.dto.Member;
import kh.semi.comembus.member.model.dto.MemberExt;

public class MemberService {

	private MemberDao memberDao = new MemberDao();
	
	// 미송 코드 시작
	public Member findById(String memberId) {
		Connection conn = getConnection();
		Member member = memberDao.findById(conn, memberId);
		close(conn);
		return member;
	}
	
	public int insertMember(Member member) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = memberDao.insertMember(conn, member);
			commit(conn);			
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	/**
	 * 아이디 찾기 : 입력값에 해당하는 아이디 반환
	 */
	public String getMemberId(Map<String, Object> param) {
		Connection conn = getConnection();
		String memberId = memberDao.getMemberId(conn, param);
		close(conn);
		return memberId;
	}
	
	/**
	 * 비밀번호 찾기를 위한 본인 확인 : 입력값에 해당하는 회원 존재 여부 반환
	 */
	public int checkMember(Map<String, Object> param) {
		Connection conn = getConnection();
		int checkMember = memberDao.checkMember(conn, param);
		close(conn);
		return checkMember;
	}
	
	public int updatePassword(Map<String, Object> param) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = memberDao.updatePassword(conn, param);
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
	 * 닉네임 중복 검사
	 */
	public int checkNickname(String nickName) {
		Connection conn = getConnection();
		int checkNickname = memberDao.checkNickname(conn, nickName);
		close(conn);
		return checkNickname;
	}
	
	// 미송 코드 끝
	
	
	
	// 수진 코드 시작
	/**
	 * 멤버스 메인페이지 : 전체회원 목록반환
	 */
	public List<Member> findAll(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Member> memberList = memberDao.findAll(conn, param);
		close(conn);
		return memberList;
	}
	
	/**
	 * 멤버스 메인페이지 : 페이징 처리용 전체회원 수 반환
	 */
	public int getTotalMembusNum() {
		Connection conn = getConnection();
		int totalMembusNum = memberDao.getTotalMembusNum(conn);
		close(conn);
		return totalMembusNum;
	}

	/**
	 * 멤버스 메인페이지 : 멤버스 조건 검색시 해당하는 회원목록 반환 
	 */
	public List<Member> findMemberLike(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Member> memberList = memberDao.findMemberLike(conn, param);
		close(conn);
		return memberList;
	}

	/**
	 * 멤버스 메인페이지 : 멤버스 조건 검색시 페이징 처리용 회원 목록 수 반환 
	 */
	public int getTotalMembusNumLike(Map<String, Object> param) {
		Connection conn = getConnection();
		int totalMembusNumlike = memberDao.getTotalMembusNumLike(conn, param);
		close(conn);
		return totalMembusNumlike;
	}


	public String getJobName(JobCode jobCode) {
		Connection conn = getConnection();
		String jobName = memberDao.getJobName(conn, jobCode);
		return jobName;
	}

	public int updateMember(Map<String, Object> param) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = memberDao.updateMember(conn, param);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public int memberQuit(String memberId) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = memberDao.memberQuit(conn, memberId);
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
	 * 모임게시글 상세->지원자현황 페이지: 지원현황테이블에서 지원자목록 조회 
	 */
	public List<MemberExt> getApldMemberList(Map<String, Object> param) {
		Connection conn = getConnection();
		List<MemberExt> getApldMemberList = memberDao.getApldMemberList(conn, param);
		close(conn);
		return getApldMemberList;
	}
	
	/**
	 * 모임게시글 상세->지원자현황 페이지: 지원자 목록페이지바용 전체 수 
	 * @param psNo 
	 */
	public int getApldMemberNum(int psNo) {
		Connection conn = getConnection();
		int apldMemberNum = memberDao.getApldMemberNum(conn, psNo);
		close(conn);
		return apldMemberNum;
	}
	
	/**
	 * 지원결과 반영
	 */
	public int updateApldResult(Map<String, Object> param) {
		Connection conn = getConnection();
		int apldMemupdateResult = memberDao.updateApldResult(conn, param);
		close(conn);
		return apldMemupdateResult;
	}
	
	// 수진 코드 끝
	
	// 선아 코드 시작
	public int insertBookmark(Map<String, Object> param) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = memberDao.insertBookmark(conn, param);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;

	}

	public int deleteBookmark(Map<String, Object> param) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = memberDao.deleteBookmark(conn, param);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}
	
	// 선아 코드 끝
}
