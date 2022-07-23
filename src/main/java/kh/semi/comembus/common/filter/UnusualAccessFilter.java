package kh.semi.comembus.common.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kh.semi.comembus.member.model.dto.Member;
import kh.semi.comembus.member.model.dto.MemberRole;

/**
 * Servlet Filter implementation class UnusualAccessFilter
 */
@WebFilter({
	"/membus/showMemberId",
	"/membus/resetMemberPassword",
	"/membus/checkNicknameDuplicate",
	"/membus/checkMemberPassword"
	})
public class UnusualAccessFilter implements Filter {

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpReq = (HttpServletRequest) request;
		HttpServletResponse httpRes = (HttpServletResponse) response;
		HttpSession session = httpReq.getSession();
		
		String memberName = request.getParameter("name");
		System.out.println("[UnusualAccessFilter@memberName] = " + memberName);
		
		if(memberName == null) {
			session.setAttribute("msg", "비정상적인 접근입니다.");
			httpRes.sendRedirect(httpReq.getContextPath() + "/main");
			return;
		}
		chain.doFilter(request, response);
	}

}
