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
	public List<Member> findAll(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Member> memberList = memberDao.findAll(conn, param);
		close(conn);
		return memberList;
	}
	
	public int getTotalMembus() {
		Connection conn = getConnection();
		int totalMembus = memberDao.getTotalMembus(conn);
		close(conn);
		return totalMembus;
	}
	
	// 수진 코드 끝

}
