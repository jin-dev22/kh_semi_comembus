package kh.semi.comembus.community.model.dao;

import static kh.semi.comembus.common.JdbcTemplate.*;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;


import kh.semi.comembus.community.model.dto.CommentLevel;
import kh.semi.comembus.community.model.dto.Community;
import kh.semi.comembus.community.model.dto.CommunityRepl;
import kh.semi.comembus.community.model.exception.CommunityException;
import kh.semi.comembus.member.model.dto.Member;
import kh.semi.comembus.member.model.dto.MemberExt;
import kh.semi.comembus.member.model.exception.MemberException;

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

	
	public List<Community> findQna (Connection conn, Map<String, Object> param) {
		List<Community> qlist = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findQnaAll");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int) param.get("start"));
			pstmt.setInt(2, (int) param.get("end"));
			rset = pstmt.executeQuery();
			
			
			while(rset.next()) {
				Community comm = handleCommunityResultSet(rset);
				qlist.add(comm);
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


	public List<Community> findFree(Connection conn, Map<String, Object> param) {
		List<Community> flist = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findFreeAll");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int) param.get("start"));
			pstmt.setInt(2, (int) param.get("end"));
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Community comm = handleCommunityResultSet(rset);
				flist.add(comm);
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


	public List<Community> findShare(Connection conn, Map<String, Object> param) {
		List<Community> slist = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findShareAll");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int) param.get("start"));
			pstmt.setInt(2, (int) param.get("end"));
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Community comm = handleCommunityResultSet(rset);
				slist.add(comm);
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


	public int insertQna(Connection conn, Community commu) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertQna"); //여기서 쓴 물음표들 dao에서 채워주는거임
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, commu.getCoTitle());
			pstmt.setString(2, commu.getCoWriter());
			pstmt.setString(3, commu.getCoContent());
			result = pstmt.executeUpdate();
			
		}catch(SQLException e) {
			throw new CommunityException("큐앤에이 게시글 등록 오류", e);
		}finally {
			close(pstmt);
		}
		
		return result;
	}
	
	public int insertFree(Connection conn, Community commu) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertFree"); 
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, commu.getCoTitle());
			pstmt.setString(2, commu.getCoWriter());
			pstmt.setString(3, commu.getCoContent());
			result = pstmt.executeUpdate();
			
		}catch(SQLException e) {
			throw new CommunityException("자유 게시글 등록 오류", e);
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	public int insertShare(Connection conn, Community commu) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertShare"); 
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, commu.getCoTitle());
			pstmt.setString(2, commu.getCoWriter());
			pstmt.setString(3, commu.getCoContent());
			result = pstmt.executeUpdate();
			
		}catch(SQLException e) {
			throw new CommunityException("정보공유 게시글 등록 오류", e);
		}finally {
			close(pstmt);
		}
		
		return result;
	}
	
	
	public int getQnaContent(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalContent = 0;
		String sql = prop.getProperty("getQnaContent");

		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if(rset.next())
				totalContent = rset.getInt(1);
		} catch (SQLException e) {
			throw new CommunityException("총 게시물수 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return totalContent;
	}
	
	public int getFreeContent(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalContent = 0;
		String sql = prop.getProperty("getFreeContent");

		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if(rset.next())
				totalContent = rset.getInt(1);
		} catch (SQLException e) {
			throw new CommunityException("총 게시물수 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return totalContent;
	}
	
	public int getShareContent(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalContent = 0;
		String sql = prop.getProperty("getShareContent");

		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if(rset.next())
				totalContent = rset.getInt(1);
		} catch (SQLException e) {
			throw new CommunityException("총 게시물수 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return totalContent;
	}

	public Community findByCommuNo(Connection conn, int no) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findByCommuNo");
		Community qview = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				qview = handleCommunityResultSet(rset);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new CommunityException("게시글 조회를 실패했습니다.",e);
		}
		return qview;
	}


	public int updateCommu(Connection conn, Community commu) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("updateCommu");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, commu.getCoTitle());
			pstmt.setString(2, commu.getCoContent());
			pstmt.setInt(3, commu.getCoNo());
			
			result = pstmt.executeUpdate();
		} 
		catch (SQLException e) {
			throw new CommunityException("게시글 수정 오류!", e);
		}
		finally {
			close(pstmt);
		}
		return result;
	}
	
	public int deleteCommu(Connection conn, int no) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("deleteCommu");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			result = pstmt.executeUpdate();
		} 
		catch (SQLException e) {
			throw new CommunityException("게시글 삭제 오류!", e);
		}
		finally {
			close(pstmt);
		}
		return result;
	}

	public int insertCommuComment(Connection conn, CommunityRepl commuRepl) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertCommuComment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, commuRepl.getReplWriter());
			pstmt.setInt(2, commuRepl.getCoNo());
			pstmt.setString(3, commuRepl.getContent());
			pstmt.setInt(4,commuRepl.getReplLevel().getValue());
			pstmt.setObject(5, commuRepl.getRefReplNo() == 0 ? 
									null : 
										commuRepl.getRefReplNo());
			result = pstmt.executeUpdate();
		} 
		
		catch (SQLException e) {
			throw new CommunityException("댓글/답글 등록 오류!", e);
		}
		finally {
			close(pstmt);
		}
		return result;
		}
	
	public List<CommunityRepl> findCommuCommentcoNo(Connection conn, int coNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<CommunityRepl> replList = new ArrayList<>();
		String sql = prop.getProperty("findCommuCommentcoNo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, coNo);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				replList.add(handleCommuReplResultSet(rset));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new CommunityException("게시글별 댓글 조회를 실패했습니다.",e);
		}finally {
			close(rset);
			close(pstmt);
		}
		return replList;
		
	}


	private CommunityRepl handleCommuReplResultSet(ResultSet rset) throws SQLException {
		int replNo = rset.getInt("repl_no");
		String replWriter = rset.getString("repl_writer");
		int coNo = rset.getInt("co_no");
		Timestamp regDate = rset.getTimestamp("reg_date");
		String content = rset.getString("content");
		CommentLevel replLevel = CommentLevel.valueOf(rset.getInt("repl_level"));
		int refReplNo = rset.getInt("ref_repl_no");
		return new CommunityRepl(replNo, replWriter, coNo, regDate, content, replLevel, refReplNo);
	}

	public int deleteCommuComment(Connection conn, int no) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("deleteCommuComment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			result = pstmt.executeUpdate();
		
		} catch (SQLException e) {
			throw new CommunityException("댓글 삭제에 실패하였습니다", e);
		}finally {
			close(pstmt);
		}

		return result;
		}
	
		public int updateReadCount(Connection conn, int no) {
			PreparedStatement pstmt = null;
			int result = 0;
			String sql = prop.getProperty("updateReadCount");
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, no);
				result = pstmt.executeUpdate();
				
			} catch (SQLException e) {
				throw new CommunityException("조회수 증가 오류");
			}finally {
				close(pstmt);
			}
			return result;
		}

		public List<Community> QnaTitleLike(Connection conn, Map<String, Object> param) {
			PreparedStatement pstmt = null;
			ResultSet rset = null;
			List<Community> qlist = new ArrayList<>();
			String sql = prop.getProperty("QnaTitleLike");
			
			// select * from member where #(member_id, gender..) like ?
			int start = (int)param.get("start");
			int end = (int)param.get("end");
			String col = (String)param.get("searchType");
			String val = (String)param.get("searchKeyword");
			sql = sql.replace("#", col);
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + val + "%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				rset = pstmt.executeQuery();
				while(rset.next())
					qlist.add(handleCommunityResultSet(rset));
			
			} catch (SQLException e) {
				throw new MemberException("검색 오류",e);
			}finally {
				close(rset);
				close(pstmt);
			}
			return qlist;
		}
		public int qnaTotalContentLike(Connection conn, Map<String, Object> param) {
			PreparedStatement pstmt = null;
			ResultSet rset = null;
			int totalContent = 0;
			String sql = prop.getProperty("qnaTotalContentLike");
			String col = (String) param.get("searchType");	
			String val = (String) param.get("searchKeyword");	
			
			sql = sql.replace("#", col);
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + val + "%");
				rset = pstmt.executeQuery();
				if(rset.next()) {
					totalContent = rset.getInt(1);
				}
			} catch (SQLException e) {
				throw new MemberException("검색된 회원수 조회 오류!");
			}finally {
				close(rset);
				close(pstmt);
			}
			return totalContent;
		}
		
		public List<Community> findShareBest(Connection conn) {
			List<Community> best = new ArrayList<>();
			PreparedStatement pstmt = null;
			ResultSet rset = null;
			String sql = prop.getProperty("findShareBest");
			
			try {
				pstmt = conn.prepareStatement(sql);
				rset = pstmt.executeQuery();
				
				while(rset.next()) {
					Community c = new Community();
					c.setCoTitle(rset.getString("co_title"));
					c.setCoWriter(rset.getString("co_writer"));
					c.setCoLike(rset.getInt("co_like"));
					c.setCoReadcount(rset.getInt("co_read_count"));
				
					best.add(c);
				}
			} catch (SQLException e) {
				e.printStackTrace();
				throw new CommunityException("베스트 글 조회를 실패했습니다.",e);
			}finally {
				close(rset);
				close(pstmt);
			}
			return best;
		}

		
	//태연코드 끝
	
	//수진코드 시작
	/**
	 * 회원 작성글 조회(페이지 나눔처리)
	 */
	public List<Community> findAllByMemberId(Connection conn, Map<String, Object> param){
		List<Community> communityList = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findAllByMemberId");
		//1:memberId, 2:start, 3:end
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, (String)param.get("memberId"));
			pstmt.setInt(2, (int)param.get("start"));
			pstmt.setInt(3, (int)param.get("end"));
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Community comm = handleCommunityResultSet(rset);
				communityList.add(comm);
			}
			
		} catch (SQLException e) {
			throw new CommunityException("회원 커뮤니티 작성글 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}				
		return communityList;
	}
	
	public int getTotalMemberCommunityNum(Connection conn, String memberId) {
		int totalCommunityNum = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getTotalMemberCommunityNum");
		//select count(*) from community_board where co_writer = ?
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				totalCommunityNum = rset.getInt(1);
			}
		} catch (SQLException e) {
			throw new CommunityException("회원 커뮤니티 작성글 수 조회 오류",e);
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return totalCommunityNum;
	}
	
	private Community handleCommunityResultSet(ResultSet rset) throws SQLException{
		int coNo = rset.getInt("co_no");
		String coTitle = rset.getString("co_title");
		String coWriter = rset.getString("co_writer");
		String coContent = rset.getString("co_content");
		int coReadCount = rset.getInt("co_read_count");
		Timestamp coRegDate = rset.getTimestamp("co_reg_date");
		int coLike = rset.getInt("co_like");
		String coType = rset.getString("co_type");
		return new Community(coNo, coTitle, coWriter, coContent, coReadCount, coRegDate, coLike, coType);
	}


	//수진코드 끝
}
