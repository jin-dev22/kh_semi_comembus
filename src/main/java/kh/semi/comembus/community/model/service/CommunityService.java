package kh.semi.comembus.community.model.service;
import static kh.semi.comembus.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kh.semi.comembus.community.model.dao.CommunityDao;
import kh.semi.comembus.community.model.dto.Community;

public class CommunityService {
	private CommunityDao communityDao = new CommunityDao();


	public List<Community> findQna() {
		List<Community> qlist = null;
		Connection conn = getConnection();
		
		try {
			qlist = communityDao.findQna(conn);
		}catch(Exception e){
			throw e;
		}finally {
			close(conn);
		}
		return qlist;
	}


	public List<Community> findFree() {
		List<Community> flist = null;
		Connection conn = getConnection();
		
		try {
			flist = communityDao.findFree(conn);
		}catch(Exception e){
			throw e;
		}finally {
			close(conn);
		}
		return flist;
	}


	public List<Community> findShare() {
		List<Community> slist = null;
		Connection conn = getConnection();
		
		try {
			slist = communityDao.findShare(conn);
		}catch(Exception e){
			throw e;
		}finally {
			close(conn);
		}
		return slist;
	}
	
	//수진코드 시작
	/**
	 * 멤버스 프로필, 마이페이지: 회원 아이디로 모든 작성글 조회
	 */
	public List<Community> findAllByMemberId(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Community> communityList = communityDao.findAllByMemberId(conn, param);
		close(conn);
		return communityList;
	}

	/**
	 * 멤버스 프로필, 마이페이지: 회원 작성글 페이징 처리용 전체 작성글 수
	 */
	public int getTotalMemberCommunityNum(String memberId) {
		Connection conn = getConnection();
		int totalCommunityNum = communityDao.getTotalMemberCommunityNum(conn, memberId);
		return totalCommunityNum;
	}
	
	//수진코드 끝
}
