package kh.semi.comembus.gathering.model.dao;

import static kh.semi.comembus.common.JdbcTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;
import java.util.Properties;

import kh.semi.comembus.gathering.model.dto.Attachment;
import kh.semi.comembus.gathering.model.dto.Gathering;
import kh.semi.comembus.gathering.model.exception.GatheringException;

public class ProjectDao {
	private Properties prop = new Properties();
	
	public ProjectDao() {
		String filename = ProjectDao.class.getResource("/sql/gathering/project-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		}catch(IOException e) {
			e.printStackTrace();
		}
	}
	
	public int enrollProject(Connection conn, Gathering project) {
		PreparedStatement pstmt=null;
		int result=0;
		String sql = prop.getProperty("enrollProject");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, project.getWriter());
			pstmt.setObject(2, "P",Types.OTHER);
			pstmt.setString(3, project.getTitle());
			pstmt.setDate(4, project.getRegDate());
			pstmt.setString(5, project.getContent());
			pstmt.setInt(6, project.getViewcount());
			pstmt.setInt(7, project.getBookmark());
			pstmt.setString(8, project.getTopic());
			pstmt.setString(9, project.getLocal());
			pstmt.setInt(10, project.getPeople());
			pstmt.setObject(11, "N",Types.OTHER);
			pstmt.setDate(12, project.getStartDate());
			pstmt.setDate(13, project.getEndDate());
			
			result = pstmt.executeUpdate();
			
		}catch(SQLException e) {
			throw new GatheringException("모임 등록 오류!",e);
		}finally {
			close(pstmt);
		}
		return result;
	}

	public int getLastBoardNo(Connection conn) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int updateReadCount(Connection conn, int psNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	public Gathering findByNo(Connection conn, int psNo) {
		// TODO Auto-generated method stub
		return null;
	}

}
