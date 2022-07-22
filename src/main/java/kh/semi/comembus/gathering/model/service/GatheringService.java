package kh.semi.comembus.gathering.model.service;

import static kh.semi.comembus.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import kh.semi.comembus.gathering.model.dao.GatheringDao;
import kh.semi.comembus.gathering.model.dto.Gathering;
import kh.semi.comembus.gathering.model.dto.GatheringExt;

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
	
	//수진코드 끝
	
	public List<Gathering> findMemberBookmarkList(String memberId) {
		Connection conn = getConnection();
		List<Gathering> bookmarkList = gatheringDao.findMemberBookmarkList(conn, memberId);
		close(conn);
		return bookmarkList;
	}

	public List<Gathering> findMemberBookmarkFilterList(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Gathering> bookmarkFilterlist = gatheringDao.findMemberBookmarkFilterList(conn, param);
		close(conn);
		return bookmarkFilterlist;
	}

	public int getTotalBookmarkFilter(Map<String, Object> param) {
		Connection conn = getConnection();
		int totalbookmarkFilterContent = gatheringDao.getTotalBookmarkFilter(conn, param);
		close(conn);
		return totalbookmarkFilterContent;
	}

	public List<GatheringExt> getCapacityAll(Map<String, Object> param) {
		Connection conn = getConnection();
		List<GatheringExt> getCapacityAll = gatheringDao.getCapacityAll(conn, param);
		close(conn);
		return getCapacityAll;
	}

}
