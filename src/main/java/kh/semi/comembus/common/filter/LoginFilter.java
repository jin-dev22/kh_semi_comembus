package kh.semi.comembus.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kh.semi.comembus.member.model.dto.Member;

/**
 * Servlet Filter implementation class LoginFilter
 * 
 * @WebFilter#urlPatterns
 * @WebFilter#value (속성명을 생략하고 저장 가능)
 */
@WebFilter({
	"/membus/mypage",
	"/membus/updateMemberPassword",
	"/gathering/projectEnrollView",
	"/gathering/studyEnrollView",
	"/gathering/showApplicants",
	"/gathering/projectUpdateView",
	"/gathering/studyUpdateView",
	"/gathering/apply",
	"/community/communityEnroll",
	"/community/communityUpdate",
	"/alerts"
	})
public class LoginFilter implements Filter {

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest httpReq = (HttpServletRequest) request; 
		HttpServletResponse httpRes = (HttpServletResponse) response; 
		HttpSession session = httpReq.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		if(loginMember == null) {
			session.setAttribute("msg", "로그인 후 이용할 수 있습니다.");
			httpRes.sendRedirect(httpReq.getContextPath() + "/membus/login");
			return;
		}
		
		chain.doFilter(request, response);
	}

}
