package kh.semi.comembus.member.model.service;

import static kh.semi.comembus.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import kh.semi.comembus.member.model.dao.MemberDao;
import kh.semi.comembus.member.model.dto.JobCode;
import kh.semi.comembus.member.model.dto.Member;

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

	
	
	// 수진 코드 끝

}
