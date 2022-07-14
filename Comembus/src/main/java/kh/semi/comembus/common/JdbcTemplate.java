package kh.semi.comembus.common;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

/**
 * 
 * jdbc api를 사용하면서 중복된 코드를 static메소드로 작성
 *
 */
public class JdbcTemplate {
	
	static String driverClass;
	static String url;
	static String user;
	static String password;
	
	static {
		// datasource.propreties의 내용을 Properties객체로 불러오기
		Properties prop = new Properties();
		try {
			// buildpath(/WEB-INF/classes) 하위에 있는 datasource.properties의 절대경로
			// getResource메소드에 전달된 path의 /는 /WEB-INF/classes를 의미한다.
			String filename = JdbcTemplate.class.getResource("/datasource.properties").getPath();
			// System.out.println("filename@JdbcTemplate = " + filename);
			prop.load(new FileReader(filename));
			driverClass = prop.getProperty("driverClass");
			url = prop.getProperty("url");
			user = prop.getProperty("user");
			password = prop.getProperty("password");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// driver class 등록 - application실행시 최초 1회만!
		try {
			Class.forName(driverClass);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Connnection객체 생성.
	 * setAutoCommit(false) - 트랜잭션을 직접 관리
	 * @return
	 */
	public static Connection getConnection() {
		Connection conn = null;
		try {
			conn =  DriverManager.getConnection(url, user, password);
			conn.setAutoCommit(false);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	public static void close(Connection conn) {
		try {
			if(conn != null && !conn.isClosed())
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void close(PreparedStatement pstmt) {
		try {
			if(pstmt != null && !pstmt.isClosed())
				pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void close(ResultSet rset) {
		try {
			if(rset != null && !rset.isClosed())
				rset.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void commit(Connection conn) {
		try {
			if(conn != null && !conn.isClosed())
				conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void rollback(Connection conn) {
		try {
			if(conn != null && !conn.isClosed())
				conn.rollback();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
}
