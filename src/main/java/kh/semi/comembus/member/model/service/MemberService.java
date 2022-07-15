package kh.semi.comembus.member.model.service;

import static kh.semi.comembus.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import kh.semi.comembus.member.model.dao.MemberDao;
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
	public int getTotalMembus() {
		Connection conn = getConnection();
		int totalMembus = memberDao.getTotalMembus(conn);
		close(conn);
		return totalMembus;
	}

	/**
	 * 멤버스 메인페이지 : 멤버스 조건 검색시 회원목록 반환 
	 */
	public List<Member> findeMemberLike(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Member> memberList = memberDao.findMemberLike(conn, param);
		close(conn);
		return memberList;
	}

	
	
	// 수진 코드 끝

}
