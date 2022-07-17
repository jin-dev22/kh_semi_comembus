package kh.semi.comembus.community.model.dao;


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
		String filename = CommunityDao.class.getResource("/sql/board/community-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	
	public List<Community> findQna (Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Community> qlist = new ArrayList<>();
		String sql = prop.getProperty("findQnaAll");
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Community c = new Community();
				
				c.setCoNo(rset.getInt("co_no"));
				c.setCoWriter(rset.getString("co_writer"));
				c.setCoTitle(rset.getString("co_title"));
				c.setCoContent(rset.getString("co_content"));
				c.setCoReadcount(rset.getInt("co_read_count"));
				c.setCoRegdate(rset.getTimestamp("co_reg_date"));
				c.setCoLike(rset.getInt("co_like"));
				c.setCoType(rset.getString("co_like"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new CommunityException("게시글 조회를 실패했습니다.",e);
		}
		return qlist;
	}

}
