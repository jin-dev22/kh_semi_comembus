package kh.semi.comembus.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.semi.comembus.common.ComembusUtils;
import kh.semi.comembus.community.model.dto.Community;
import kh.semi.comembus.community.model.service.CommunityService;
import kh.semi.comembus.gathering.model.dto.Gathering;
import kh.semi.comembus.gathering.model.service.GatheringService;
import kh.semi.comembus.member.model.dto.Member;
import kh.semi.comembus.member.model.dto.MemberExt;
import kh.semi.comembus.member.model.service.MemberService;

/**
 * Servlet implementation class MemberProfileViewServlet
 */
@WebServlet("/membus/profile")
public class MemberProfileViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	private CommunityService communityService = new CommunityService();
	private GatheringService gatheringService = new GatheringService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//멤버 아이디값 받아서 조회
			String memberId = request.getParameter("memberId");		
			MemberExt member = (MemberExt) memberService.findById(memberId);
			member.setJobName(memberService.getJobName(member.getJobCode()));
			
			//커뮤니티 게시글 페이지바 설정및 입력값 map담기
			int cPage = 1;
			int numPerPage = 5;
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch (NumberFormatException e) {}
			int start = (cPage - 1) * numPerPage + 1;
			int end = cPage * numPerPage;
			Map<String, Object> param = new HashMap<>();
			param.put("start", start);
			param.put("end", end);
			param.put("memberId", memberId);
			
			//작성한 커뮤니티 게시글 조회
			List<Community> communityList = communityService.findAllByMemberId(param);
			
			//커뮤니티 게시글 페이지바 영역 처리
			int totalCommunityNum = communityService.getTotalMemberCommunityNum(memberId);
			//?memberId=test
			String url = request.getRequestURI() + "?memberId=" + memberId;
			String pagebar = ComembusUtils.getPagebar(cPage, numPerPage, end, url);
			
			//프로젝트/스터디 참여중인 게시글 목록
			List<Gathering> gatheringIngList = gatheringService.findAllByMemberId(memberId);
			
			//찜한 프로젝트 ,스터디 목록
			List<Gathering> gatheringBookmarkList = gatheringService.findAllBookmarked(memberId);			
			
			//view단 처리
			request.setAttribute("member", member);
			request.setAttribute("communityList", communityList);
			request.setAttribute("pagebar", pagebar);
			request.setAttribute("gatheringIngList", gatheringIngList);
			request.setAttribute("gatheringBookmarkList",gatheringBookmarkList);
			request.getRequestDispatcher("/WEB-INF/views/member/memberProfile.jsp").forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
