package kh.semi.comembus.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.semi.comembus.common.ComembusUtils;
import kh.semi.comembus.member.model.dto.Member;
import kh.semi.comembus.member.model.service.MemberService;

/**
 * Servlet implementation class MembusSearchServlet
 */
@WebServlet("/membus/search")
public class MemberSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//1.사용자입력값처리
			//페이지설정
			int cPage = 1;
			int numPerPage = 10;
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch (NumberFormatException e) {}
			int start = (cPage - 1) * numPerPage + 1;
			int end = cPage * numPerPage;
			
			//사용자 입력 정보확인(직무, 모임참여여부, 닉네임일부)
			String searchJobCode = request.getParameter("searchJobcode");
			String searchGatheringYN = request.getParameter("searchGatheringYN");
			String searchKeyword = request.getParameter("searchKeyword");
			System.out.println("@srchSrv>>"+searchJobCode+", "+searchGatheringYN+", " +searchKeyword);
			
			//입력정보 HashMap으로 관리
			Map<String, Object> param = new HashMap<>();
			param.put("start", start);
			param.put("end", end);
			param.put("searchJobCode", searchJobCode);
			param.put("searchGatheringYN", searchGatheringYN);
			param.put("searchKeyword", searchKeyword);
		
			//2.업무로직
			//회원검색결과목록
			List<Member> memberList = memberService.findMemberLike(param);
			//System.out.println("@Srchservlet>> "+memberList);
			
			//페이지바 영역
			int totalMembusNumlike = memberService.getTotalMembusNumLike(param);
			//?searchJobcode=BE&searchGatheringYN=N&searchKeyword=t
			String url = request.getRequestURI() 
							+ "?searchJobcode="+ searchJobCode 
							+ "&searchGatheringYN=" + searchGatheringYN
							+ "&searchKeyword=" + searchKeyword;
			String pagebar = ComembusUtils.getPagebar(cPage, numPerPage, totalMembusNumlike, url);
			System.out.println("@MemSrch-Pagebar>> "+pagebar);
			
			//3.view단 처리
			request.setAttribute("memberList",memberList);
			request.setAttribute("pagebar", pagebar);
			request.getRequestDispatcher("/WEB-INF/views/member/memberList.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
