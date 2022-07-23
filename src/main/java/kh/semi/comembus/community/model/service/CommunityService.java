package kh.semi.comembus.community.model.service;
import static kh.semi.comembus.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kh.semi.comembus.community.model.dao.CommunityDao;
import kh.semi.comembus.community.model.dto.Community;
import kh.semi.comembus.community.model.dto.CommunityRepl;

//태연코드 시작
public class CommunityService {
	private CommunityDao communityDao = new CommunityDao();


	public List<Community> findQna(Map<String, Object> param) {
		List<Community> qlist = null;
		Connection conn = getConnection();
		
		try {
			qlist = communityDao.findQna(conn,param);
		}catch(Exception e){
			throw e;
		}finally {
			close(conn);
		}
		return qlist;
	}


	public List<Community> findFree(Map<String, Object> param) {
		List<Community> flist = null;
		Connection conn = getConnection();
		
		try {
			flist = communityDao.findFree(conn,param);
		}catch(Exception e){
			throw e;
		}finally {
			close(conn);
		}
		return flist;
	}


	public List<Community> findShare(Map<String, Object> param) {
		List<Community> slist = null;
		Connection conn = getConnection();
		
		try {
			slist = communityDao.findShare(conn,param);
		}catch(Exception e){
			throw e;
		}finally {
			close(conn);
		}
		return slist;
	}


	public int insertQna(Community commu) {
		Connection conn = getConnection();
		int result = 0;
		
		try {
			//커뮤니티 테이블에 insert(한행)
			result = communityDao.insertQna(conn, commu);
			
		}catch(Exception e) {
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}
		return result;
	}
	

	public int insertFree(Community commu) {
		Connection conn = getConnection();
		int result = 0;
		
		try {
			result = communityDao.insertFree(conn, commu);
			
		}catch(Exception e) {
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}
		return result;
	}

	public int insertShare(Community commu) {
		Connection conn = getConnection();
		int result = 0;
		
		try {
			result = communityDao.insertShare(conn, commu);
			
		}catch(Exception e) {
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}
		return result;
	}


	public int getQnaContent() {
		Connection conn = getConnection();
		int totalContent = communityDao.getQnaContent(conn);
		close(conn);
		return totalContent;
	}
	
	public int getFreeContent() {
		Connection conn = getConnection();
		int totalContent = communityDao.getFreeContent(conn);
		close(conn);
		return totalContent;
	}
	
	public int getShareContent() {
		Connection conn = getConnection();
		int totalContent = communityDao.getShareContent(conn);
		close(conn);
		return totalContent;
	}
	
	public Community findByCommuNo(int no) {
		Community qview = null;
		Connection conn = getConnection();
		try {
			qview = communityDao.findByCommuNo(conn, no);
		} catch (Exception e) {
			throw e;
		} finally {
			close(conn);
		}
		return qview;
	
		}

	
	public int updateCommu(Community commu) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = communityDao.updateCommu(conn,commu);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}
		return result;
	}
	
	
	public int deleteCommu(int no) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = communityDao.deleteCommu(conn, no);
			commit(conn);
		}catch(Exception e) {
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}
		return result;
	}

	
	public int insertCommuComment(CommunityRepl commuRepl) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = communityDao.insertCommuComment(conn, commuRepl);
			commit(conn);
			
		}catch(Exception e) {
			rollback(conn);
			throw e;
			
		}finally {
			close(conn);
		}
		return result;
	}
	
	public List<CommunityRepl> findCommuCommentcoNo(int coNo) {
		Connection conn = getConnection();
		List<CommunityRepl> replList = communityDao.findCommuCommentcoNo(conn, coNo);
		close(conn);
		return replList;
	}

	public int deleteCommuComment(int no) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = communityDao.deleteCommuComment(conn, no);
			commit(conn);
			
		}catch(Exception e) {
			rollback(conn);
			throw e;
			
		}finally {
			close(conn);
		}
		return result;
	}

	
	//태연코드 끝
	
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
		close(conn);
		return totalCommunityNum;
	}

	/**
	 * 커뮤니티 댓글알림: 게시물별 회원의 가장 최신 댓글찾기
	 * @param param 
	 */
	public int getLastReplNoByMemIdCoNo(Map<String, Object> param) {
		Connection conn = getConnection();
		int lastRepleNoByMemCo = communityDao.getLastReplNoByMemIdCoNo(conn, param);
		close(conn);
		return lastRepleNoByMemCo;
	}

	/**
	 * 알림목록페이지: 댓글알림 해당 커뮤니티 게시글번호 조회
	 */
	public Community getCoNoByReplNo(int replNo) {
		Connection conn = getConnection();
		Community comm = communityDao.getCoNoByReplNo(conn, replNo);
		close(conn);
		return comm;
	}


	

	


	//수진코드 끝
}
