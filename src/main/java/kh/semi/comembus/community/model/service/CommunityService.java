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
		Connection conn = getConnection();
		List<Community> qlist = communityDao.findQna(conn);
		close(conn);
		return qlist;
	}
	

}
