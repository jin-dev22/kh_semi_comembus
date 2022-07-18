package kh.semi.comembus.community.model.service;
import java.sql.Connection;
import java.util.List;

import static kh.semi.comembus.common.JdbcTemplate.close;
import static kh.semi.comembus.common.JdbcTemplate.commit;
import static kh.semi.comembus.common.JdbcTemplate.getConnection;
import static kh.semi.comembus.common.JdbcTemplate.rollback;

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
	
	//수진코드 끝
}
