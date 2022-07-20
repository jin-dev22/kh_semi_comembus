package kh.semi.comembus.community.model.service;

import static kh.semi.comembus.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kh.semi.comembus.community.model.dao.CommunityDao;
import kh.semi.comembus.community.model.dto.Community;

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
	
	public Community findByQnaNo(int no) {
		Community qview = null;
		Connection conn = getConnection();
		try {
			qview = communityDao.findByQnaNo(conn, no);
		} catch (Exception e) {
			throw e;
		} finally {
			close(conn);
		}
		return qview;
	
		}

	public Community findByFreeNo(int no) {
		Community fview = null;
		Connection conn = getConnection();
		try {
			fview = communityDao.findByFreeNo(conn, no);
		} catch (Exception e) {
			throw e;
		} finally {
			close(conn);
		}
		return fview;
	}

	public Community findByShareNo(int no) {
		Community sview = null;
		Connection conn = getConnection();
		try {
			sview = communityDao.findByShareNo(conn, no);
		} catch (Exception e) {
			throw e;
		} finally {
			close(conn);
		}
		return sview;
	}
	
	public int updateQna(Community commu) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = communityDao.updateQna(conn,commu);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}
		return result;
	}
	
	
	public int deleteQna(int no) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = communityDao.deleteQna(conn, no);
			commit(conn);
		}catch(Exception e) {
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}
		return result;
	}
	
	public int updateFree(Community commu) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = communityDao.updateFree(conn,commu);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}
		return result;
	}
	
	public int updateShare(Community commu) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = communityDao.updateShare(conn,commu);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}
		return result;
	}
	
	public int deleteFree(int no) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = communityDao.deleteFree(conn, no);
			commit(conn);
		}catch(Exception e) {
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}
		return result;
	}
	
	public int deleteShare(int no) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = communityDao.deleteShare(conn, no);
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
		return totalCommunityNum;
	}


	


	


	

	//수진코드 끝
}
