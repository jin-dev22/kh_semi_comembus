package kh.semi.comembus.gathering.model.service;

import static kh.semi.comembus.common.JdbcTemplate.close;
import static kh.semi.comembus.common.JdbcTemplate.commit;
import static kh.semi.comembus.common.JdbcTemplate.getConnection;
import static kh.semi.comembus.common.JdbcTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kh.semi.comembus.gathering.model.dao.GatheringDao;
import kh.semi.comembus.gathering.model.dto.Gathering;
import kh.semi.comembus.gathering.model.dto.GatheringExt;

public class GatheringService {
	static GatheringDao gatheringDao = new GatheringDao();
	
	// 선아 시작
	
	public List<Gathering> findGatheringAll(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Gathering> projectList = gatheringDao.findGatheringAll(conn, param);
		close(conn);
		return projectList;
	}

	public int getProTotalContent() {
		Connection conn = getConnection();
		int totalContent = gatheringDao.getProTotalContent(conn);
		close(conn);
		return totalContent;
	}
	
	public int getStdTotalContent() {
		Connection conn = getConnection();
		int totalContent = gatheringDao.getStdTotalContent(conn);
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
	
	public List<Gathering> findStudyLike(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Gathering> list = gatheringDao.findStudyLike(conn, param);
		close(conn);
		return list;
	}
	
	public int getStdTotalContentLike(Map<String, Object> param) {
		Connection conn = getConnection();
		int totalContent = gatheringDao.getStdTotalContentLike(conn, param);
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

	public List<Gathering> findStdBookmarkFilter(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Gathering> bookmarkFilterlist = gatheringDao.findStdBookmarkFilter(conn, param);
		close(conn);
		return bookmarkFilterlist;
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
	public List<GatheringExt> findAllIngByMemberId(String memberId) {
		Connection conn = getConnection();
		List<GatheringExt> gatheringIngList = gatheringDao.findAllByMemberId(conn, memberId);
		close(conn);
		return gatheringIngList;
	}

	/**
	 * 회원 아이디로 찜하기한 모임 모두 조회
	 */
	public List<GatheringExt> findAllBookmarked(String memberId) {
		Connection conn = getConnection();
		List<GatheringExt> gatheringBookmarkList = gatheringDao.findAllBookmarked(conn, memberId);
		close(conn);
		return gatheringBookmarkList;
	}

	/**
	 * 회원 아이디로 지원한 모임 모두 조회
	 */
	public List<GatheringExt> findAllApldByMemberId(String memberId) {
		Connection conn = getConnection();
		List<GatheringExt> gatheringApldList = gatheringDao.findAllApldByMemberId(conn, memberId);
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
	
	/**
	 * 스터디 지원자 모집인원에 추가해주기
	 */
	public int addStdMemNum(int psNo) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = gatheringDao.addStdMemNum(conn, psNo);
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
	
	public int getRcrtdForStd(int psNo) {
		int capa = 0;
		Connection conn = getConnection();
		capa = gatheringDao.getRcrtdForStd(conn, psNo);
		close(conn);
		
		return capa;
	}
	
	/**
	 * GatheringExt 변수 recruted_cnt추가 이전에 만들어진 코드에 사용하기 위한 메소드입니다.
	 */
	public int attachRctdCntToGather(int psNo) {
		Connection conn = getConnection();
		int rctdCnt = gatheringDao.attachRctdCntToGather(conn, psNo);
		close(conn);
		return rctdCnt;
	}
	//수진코드 끝
	
	//유경 추가
//	public int enrollProject(Gathering project) {
//		Connection conn = getConnection();
//		int result = 0;
//		
//		try {
//			// project_study table에 insert
//			result = gatheringDao.enrollProject(conn, project);
//			
//			// 방금 등록된 프로젝트 no조회
//			int psNo = gatheringDao.getLastProjectNo(conn);
//			System.out.println(">> projectNo = " + psNo);
//			
//			List<ProjectMemberDept> projectDeps = ((GatheringExt) project).getProjectDeps();
//			if(projectDeps != null && !projectDeps.isEmpty()) {
//				for(ProjectMemberDept projectDep : projectDeps) {
//					projectDep.setPsNo(psNo);
//					System.out.println(">> psNo" + psNo);
//					System.out.println(">> 11projectDeps" + projectDeps);
//					System.out.println(">> 11projectDep" + projectDep);
//					result = gatheringDao.enrollProjectDep(conn, projectDep);
//					
//				}
//			}
//			
//			commit(conn);
//		}catch(Exception e) {
//			rollback(conn);
//			throw e;
//		}finally {
//			close(conn);
//		}
//		return result;
//	}
	

	public int enrollProject(Map<Object, Object> parameter) {
		Connection conn = getConnection();
		int result = 0;
		
		try {
			// project_study table에 insert
			Gathering project = (Gathering) parameter.get("project");
			result = gatheringDao.enrollProject(conn, project);
			
			// 방금 등록된 프로젝트 no조회
			int psNo = gatheringDao.getLastProjectNo(conn);
			System.out.println(">> projectNo = " + psNo);
			
			GatheringExt projectDeps = (GatheringExt) parameter.get("parameterDep");
			
			result = gatheringDao.enrollProjectDep(conn, projectDeps);
			
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

	public int updateProject(Gathering project) {
		Connection conn = getConnection();
		int result = 0;
		try {
			// 1. 게시글 수정
			result = gatheringDao.updateProject(conn, project);
			commit(conn);
		} 
		catch (Exception e) {
			rollback(conn);
			throw e;
		}
		finally {
			close(conn);			
		}
		return result;
	}




	
	//유경 끝
	
	
	// 미송 시작
	public int updateStudy(Gathering study) {
		Connection conn = getConnection();
		int result = 0;
		try {
			// 1. 게시글 수정
			result = gatheringDao.updateStudy(conn, study);
			commit(conn);
		} 
		catch (Exception e) {
			rollback(conn);
			throw e;
		}
		finally {
			close(conn);			
		}
		return result;
	}
	// 미송 끝



}
