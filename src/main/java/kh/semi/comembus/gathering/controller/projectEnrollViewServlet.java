package kh.semi.comembus.gathering.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import kh.semi.comembus.common.ComembusFileRenamePolicy;
import kh.semi.comembus.gathering.model.dto.Attachment;
import kh.semi.comembus.gathering.model.dto.GatheringExt;
import kh.semi.comembus.gathering.model.dto.GatheringType;
import kh.semi.comembus.gathering.model.dto.Status;
import kh.semi.comembus.gathering.model.service.ProjectService;

/**
 * Servlet implementation class projectEnrollViewServlet
 */
@WebServlet("/gathering/projectEnroll")
public class projectEnrollViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ProjectService projectService = new ProjectService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
		request.getRequestDispatcher("/WEB-INF/views/gathering/projectEnrollView.jsp")
		.forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * POST db insert 요청
	 * 
	 * 첨부파일이 포함된 게시글 등록
	 * - 1. 서버컴퓨터에 파일저장 - cos.jar
	 * 		- MultipartRequest객체 생성
	 * 			- HttpServletRequest
	 * 			- saveDirecotory
	 * 			- maxPostSize
	 * 			- encoding
	 * 			- FileRenamePolicy객체 - DefaultFileRenamePolicy(기본)
	 * 		*기존 request객체가 아닌 MultipartRequest객체에서 모든 사용자입력값을 가져와야 한다.
	 * - 2. 저장된 파일정보 attachment 레코드로 등록
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//0. 첨부파일처리
			ServletContext application = getServletContext();
			String saveDirectory = application.getRealPath("/gathering/projectEnroll");
			System.out.println("saveDirectory = "+saveDirectory);
			int maxPostSize = 1024*1024*20;//20MB
			String encoding = "utf-8";
			FileRenamePolicy policy = new ComembusFileRenamePolicy();
			
			MultipartRequest multiReq = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
			
			//1. 사용자 입력값 처리
			int psNo= Integer.parseInt(multiReq.getParameter("psNo"));
			String writer = multiReq.getParameter("writer");
			String _psType=multiReq.getParameter("psType");
			String title = multiReq.getParameter("title");
			String _regDate = multiReq.getParameter("regDate");
			String content = multiReq.getParameter("content");
			int viewcount = Integer.parseInt(multiReq.getParameter("viewcount"));
			int bookmark=Integer.parseInt(multiReq.getParameter("bookmark"));
			String topic = multiReq.getParameter("topic");
			String local = multiReq.getParameter("local");
			int people = Integer.parseInt(multiReq.getParameter("people"));
			String _status = multiReq.getParameter("status");
			
			GatheringType psType = _psType != null ? GatheringType.valueOf(_psType) : null;
			Date regDate = (_regDate != null && !"".equals(_regDate))?Date.valueOf(_regDate):null;
			Status status = _status != null ? Status.valueOf(_status):null;
			
			GatheringExt project = new GatheringExt(psNo,writer,psType,title,null,content,0,bookmark,topic,local,people,status);
			
			Enumeration<String> filenames = multiReq.getFileNames();
			while(filenames.hasMoreElements()) {
				String filename = filenames.nextElement();
				File upFile = multiReq.getFile(filename);
				if(upFile!=null) {
					Attachment attach = new Attachment();
					attach.setOriginalFilename(multiReq.getOriginalFileName(filename));
					attach.setRenamedFilename(multiReq.getFilesystemName(filename));
					project.addAttachment(attach);
				}
			}
			System.out.println("project = "+project);
			
			//2. 업무로직
			int result = projectService.enrollProject(project);
			
			//3. redirect
			request.getSession().setAttribute("msg", "프로젝트를 성공적으로 등록했습니다.");
			response.sendRedirect(request.getContentLength()+"/gathering/projectList");
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
