<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	String location = (String) request.getAttribute("location");
%>
<style>
#login-container{
	width: 400px;
	text-align: center;
	margin:100px auto;
	border: 3px solid var(--btn-color);
	padding: 50px 0;
}
#loginTable{
	margin:0 auto;
}
</style>

<section id=login-container>
	<h1>회원가입/로그인</h1>
	<form id="loginFrm" name="loginFrm" action="<%= request.getContextPath() %>/member/login" method="POST">
	<input type="hidden" id="location" value="<%= location %>" name="location"/>
	<table id="loginTable">
		<tbody>
			<tr>
				<th><label for="loginId" class="login-id-label">아이디</label></th>
				<td><input type="text" id="memberId" name="memberId"/></td>
			</tr>
			<tr>
				<th><label for="loginPwd" class="login-pwd-label">비밀번호</label></th>
           		<td><input type="password" id="password" name="password"/></td>
			</tr>
			<tr>	
				<th colspan="2">
	            	<button id="login">로그인</button>
	         	</th>
			</tr>
        </tbody>
     </table>
     </form>
    <div>
	    <input type="button" value="아이디 찾기"
			onclick="location.href='<%= request.getContextPath() %>/member/findMemberId';">
		<input type="button" value="비밀번호 찾기"
			onclick="location.href='<%= request.getContextPath() %>/member/resetMemberPassword';">
   	</div>
   	<div>
     	<span>아직 회원이 아니신가요?</span>
     	<input type="button" value="회원가입하기"
			onclick="location.href='<%= request.getContextPath() %>/member/memberEnroll';">
   	</div>
   	
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>