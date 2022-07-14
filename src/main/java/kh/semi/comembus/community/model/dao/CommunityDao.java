package kh.semi.comembus.community.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

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
}
