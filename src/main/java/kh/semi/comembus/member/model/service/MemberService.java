package kh.semi.comembus.member.model.service;

import static kh.semi.comembus.common.JdbcTemplate.*;

import java.sql.Connection;

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
	
	// 수진 코드 끝

}
