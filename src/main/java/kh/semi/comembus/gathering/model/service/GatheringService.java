package kh.semi.comembus.gathering.model.service;

import static kh.semi.comembus.common.JdbcTemplate.close;
import static kh.semi.comembus.common.JdbcTemplate.getConnection;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import kh.semi.comembus.gathering.model.dao.GatheringDao;
import kh.semi.comembus.gathering.model.dto.Gathering;

public class GatheringService {
	GatheringDao gatheringDao = new GatheringDao();

	public List<Gathering> findGatheringAll(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Gathering> projectList = gatheringDao.findGatheringAll(conn, param);
		close(conn);
		return projectList;
	}

	public int getTotalContent() {
		Connection conn = getConnection();
		int totalContent = gatheringDao.getTotalContent(conn);
		close(conn);
		return totalContent;
	}

	//수진코드 시작
	
	//수진코드 끝
}
