package kh.semi.comembus.gathering.model.service;

import java.sql.Connection;
import java.util.List;

import static kh.semi.comembus.common.JdbcTemplate.close;
import static kh.semi.comembus.common.JdbcTemplate.commit;
import static kh.semi.comembus.common.JdbcTemplate.getConnection;
import static kh.semi.comembus.common.JdbcTemplate.rollback;

import kh.semi.comembus.gathering.model.dao.ProjectDao;
import kh.semi.comembus.gathering.model.dto.Attachment;
import kh.semi.comembus.gathering.model.dto.Gathering;
import kh.semi.comembus.gathering.model.dto.GatheringExt;

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
			
			//attachment테이블 insert
			List<Attachment> attachments = ((GatheringExt) project).getAttachments();
			if(attachments != null && !attachments.isEmpty()) {
				for(Attachment attach : attachments) {
					attach.setpsNo(psNo);
					result = ProjectDao.insertAttachment(conn,attach);
				}
			}
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
			List<Attachment> attachments = ProjectDao.findAttachmentByGatheringNo(conn,psNo);
			((GatheringExt)project).setAttachments(attachments);
			
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
