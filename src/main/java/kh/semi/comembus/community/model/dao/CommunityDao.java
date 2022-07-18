package kh.semi.comembus.community.model.dao;

import static kh.semi.comembus.common.JdbcTemplate.*;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;


import kh.semi.comembus.community.model.dto.Community;
import kh.semi.comembus.community.model.exception.CommunityException;

public class CommunityDao {
	private Properties prop = new Properties();

	public CommunityDao() {
		//properties파일 가져오기
		String filename = CommunityDao.class.getResource("/sql/community/community-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	
	public List<Community> findQna (Connection conn) {
		List<Community> qlist = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findQnaAll");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Community c = new Community();
				
				c.setCoNo(rset.getInt("co_no"));
				c.setCoTitle(rset.getString("co_title"));
				c.setCoWriter(rset.getString("co_writer"));
//				c.setCoContent(rset.getString("co_content"));
				c.setCoRegdate(rset.getTimestamp("co_reg_date"));
				c.setCoLike(rset.getInt("co_like"));
				c.setCoReadcount(rset.getInt("co_read_count"));
				c.setCoType(rset.getString("co_type"));
				qlist.add(c);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new CommunityException("큐앤에이 목록 조회를 실패했습니다.",e);
		}finally {
			close(rset);
			close(pstmt);
		}
		return qlist;
	}


	public List<Community> findFree(Connection conn) {
		List<Community> flist = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findFreeAll");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Community c = new Community();
				
				c.setCoNo(rset.getInt("co_no"));
				c.setCoTitle(rset.getString("co_title"));
				c.setCoWriter(rset.getString("co_writer"));
//				c.setCoContent(rset.getString("co_content"));
				c.setCoRegdate(rset.getTimestamp("co_reg_date"));
				c.setCoLike(rset.getInt("co_like"));
				c.setCoReadcount(rset.getInt("co_read_count"));
				c.setCoType(rset.getString("co_type"));
				flist.add(c);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new CommunityException("자유글 목록 조회를 실패했습니다.",e);
		}finally {
			close(rset);
			close(pstmt);
		}
		return flist;
	}


	public List<Community> findShare(Connection conn) {
		List<Community> slist = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findShareAll");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Community c = new Community();
				
				c.setCoNo(rset.getInt("co_no"));
				c.setCoTitle(rset.getString("co_title"));
				c.setCoWriter(rset.getString("co_writer"));
//				c.setCoContent(rset.getString("co_content"));
				c.setCoRegdate(rset.getTimestamp("co_reg_date"));
				c.setCoLike(rset.getInt("co_like"));
				c.setCoReadcount(rset.getInt("co_read_count"));
				c.setCoType(rset.getString("co_type"));
				slist.add(c);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new CommunityException("정보공유 목록 조회를 실패했습니다.",e);
		}finally {
			close(rset);
			close(pstmt);
		}
		return slist;
	}


	public int enrollQna(Connection conn, Community commu) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("enrollQna"); //여기서 쓴 물음표들 dao에서 채워주는거임
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, commu.getCoTitle());
			pstmt.setString(2, commu.getCoWriter());
			pstmt.setString(3, commu.getCoContent());
			result = pstmt.executeUpdate();
			
		}catch(SQLException e) {
			throw new CommunityException("게시글 등록 오류!", e);
		}finally {
			close(pstmt);
		}
		
		return result;
	}
	
	//수진코드 시작
	
	//수진코드 끝
}
