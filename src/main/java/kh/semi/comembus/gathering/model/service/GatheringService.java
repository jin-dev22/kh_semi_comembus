package kh.semi.comembus.gathering.model.service;

import static kh.semi.comembus.common.JdbcTemplate.close;
import static kh.semi.comembus.common.JdbcTemplate.commit;
import static kh.semi.comembus.common.JdbcTemplate.getConnection;
import static kh.semi.comembus.common.JdbcTemplate.rollback;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import kh.semi.comembus.gathering.model.dao.GatheringDao;
import kh.semi.comembus.gathering.model.dto.Gathering;
import kh.semi.comembus.gathering.model.dto.GatheringExt;
import kh.semi.comembus.member.model.dto.MemberExt;

public class GatheringService {
	static GatheringDao gatheringDao = new GatheringDao();
	
	// 선아 시작
	
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

	public List<Gathering> findProjectLike(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Gathering> list = gatheringDao.findProjectLike(conn, param);
		close(conn);
		return list;
	}

	public int getProTotalContentLike(Map<String, Object> param) {
		Connection conn = getConnection();
		int totalContent = gatheringDao.getProTotalContentLike(conn, param);
		close(conn);
		return totalContent;
	}

	public List<Gathering> findProBookmarkFilter(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Gathering> bookmarkFilterlist = gatheringDao.findProBookmarkFilter(conn, param);
		close(conn);
		return bookmarkFilterlist;
	}

	public int getTotalBookmarkFilter(Map<String, Object> param) {
		Connection conn = getConnection();
		int totalbookmarkFilterContent = gatheringDao.getTotalBookmarkFilter(conn, param);
		close(conn);
		return totalbookmarkFilterContent;
	}

	public List<Gathering> findAllProBookmarked(Map<String, Object> bmParam) {
		Connection conn = getConnection();
		List<Gathering> proBookmarkList = gatheringDao.findAllProBookmarked(conn, bmParam);
		close(conn);
		return proBookmarkList;
	}
	
	public List<Gathering> findAllStdBookmarked(Map<String, Object> bmParam) {
		Connection conn = getConnection();
		List<Gathering> stdBookmarkList = gatheringDao.findAllStdBookmarked(conn, bmParam);
		close(conn);
		return stdBookmarkList;
	}
	
	// 선아 끝

	//수진코드 시작
	/**
	 * 멤버스 프로필, 마이페이지: 회원 참가중인 모임 게시글 조회
	 */
	public List<Gathering> findAllIngByMemberId(String memberId) {
		Connection conn = getConnection();
		List<Gathering> gatheringIngList = gatheringDao.findAllByMemberId(conn, memberId);
		close(conn);
		return gatheringIngList;
	}

	/**
	 * 회원 아이디로 찜하기한 모임 모두 조회
	 */
	public List<Gathering> findAllBookmarked(String memberId) {
		Connection conn = getConnection();
		List<Gathering> gatheringBookmarkList = gatheringDao.findAllBookmarked(conn, memberId);
		close(conn);
		return gatheringBookmarkList;
	}

	/**
	 * 회원 아이디로 지원한 모임 모두 조회
	 */
	public List<Gathering> findAllApldByMemberId(String memberId) {
		Connection conn = getConnection();
		List<Gathering> gatheringApldList = gatheringDao.findAllApldByMemberId(conn, memberId);
		close(conn);
		return gatheringApldList;
	}

	/**
	 * 지원신청 취소하기
	 */
	public int cancelApld(Map<String, Object> param) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = gatheringDao.cancelApld(conn, param);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		}
		finally {
			close(conn);
		}
		return result;
	}
	
	/**
	 * 모임 게시글 번호로 조회하기
	 * - 지원신청 취소시 해당 게시글 정보 확인을 위해 작성했습니다. 
	 */
	public Gathering findByNo(int psNo) {
		Connection conn = getConnection();
		Gathering gather = gatheringDao.findByNo(conn, psNo);
		close(conn);
		return gather;
	}
	
	/**
	 * 모임게시글상세>지원자현황페이지: 직무별 모집정원 조회 
	 */
	public Map<String, Integer> getCapacitiesByDept(int psNo) {
		Connection conn = getConnection();
		Map<String, Integer> capacitiesByDept = gatheringDao.getCapacitiesByDept(conn, psNo);
		close(conn);
		return capacitiesByDept;
	}
	
	/**
	 * 모임게시글상세>지원자현황페이지: 직무별 모집인원 테이블 업데이트, ajax 처리를 위해 boolean값 반환
	 */
	public int addPSMemNumByDept(Map<String, Object> param) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = gatheringDao.addPSMemNumByDept(conn, param);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		}
		finally {
			close(conn);
		}
		return result;
	}
	
	/**
	 * 멤버별 모임지원현황 결과 컬럼 업데이트
	 */
	public int updateApldResult(Map<String, Object> param) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = gatheringDao.updateApldResult(conn, param);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		}
		finally {
			close(conn);
		}
		
		return result;
	}
	
	//수진코드 끝
	
	//유경 추가
	public int enrollProject(Gathering project) {
		Connection conn=getConnection();
		int result = 0;
		try {
			//gathering table에 insert
			result = gatheringDao.enrollProject(conn,project);
			
			//방금 등록된 Gathering.no조회
			int psNo = gatheringDao.getLastProjectNo(conn);
			System.out.println("projectNo = "+psNo);
			commit(conn);
		}catch(Exception e) {
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}
		return result;
	}


	public Gathering findByNo(int psNo, boolean hasRead) {
		Connection conn = getConnection();
		Gathering project = null;
		try {
			if(!hasRead) {
				int result = gatheringDao.updateReadCount(conn,psNo);
				project=gatheringDao.findByNo(conn,psNo);
				
				commit(conn);
			}
		}catch(Exception e) {
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}
		return project;
	}

	public int enrollStudy(Gathering study) {
		Connection conn=getConnection();
		int result = 0;
		try {
			//gathering table에 insert
			result = gatheringDao.enrollStudy(conn,study);
			
			//방금 등록된 Gathering.no조회
			int psNo = gatheringDao.getLastStudyNo(conn);
			System.out.println("studyNo = "+psNo);
			commit(conn);
		}catch(Exception e) {
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}
		return result;
	}
	
	//유경 끝



}
