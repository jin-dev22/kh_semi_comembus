package kh.semi.comembus.gathering.model.service;

import java.sql.Connection;
import java.util.List;

import static kh.semi.comembus.common.JdbcTemplate.close;
import static kh.semi.comembus.common.JdbcTemplate.commit;
import static kh.semi.comembus.common.JdbcTemplate.getConnection;
import static kh.semi.comembus.common.JdbcTemplate.rollback;

import kh.semi.comembus.gathering.model.dao.ProjectDao;
import kh.semi.comembus.gathering.model.dto.Gathering;

public class ProjectService {
	private ProjectDao ProjectDao=new ProjectDao();

	public int enrollProject(Gathering project) {
		Connection conn= getConnection();
		int result=0;
		try {
			//Gathering table에 insert
			result =  ProjectDao.enrollProject(conn,project);
			//방금 등록된 Gathering.no 컬럼값 조회
			int psNo = ProjectDao.getLastBoardNo(conn);
			System.out.println("projectNo = "+psNo);
			
			commit(conn);
		}catch(Exception e) {
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}return result;
	}
	public Gathering findByNo(int psNo) {
		return findByNo(psNo, true);
	}
	
	public Gathering findByNo(int psNo, boolean hasRead) {
		Connection conn = getConnection();
		Gathering project = null;
		
		try {
			if(!hasRead) {
				int result=ProjectDao.updateReadCount(conn,psNo);
			}
			project = ProjectDao.findByNo(conn,psNo);			
			commit(conn);
		}
		catch(Exception e) {
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}
		return project;
	}
}
