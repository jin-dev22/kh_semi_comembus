<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
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
	<table id="loginTable">
		<tbody>
			<tr>
				<th><label for="loginId" class="login-id-label">아이디</label></th>
				<td><input type="text" id="loginId" name="loginId"/></td>
			</tr>
			<tr>
				<th><label for="loginPwd" class="login-pwd-label">비밀번호</label></th>
           		<td><input type="password" id="loginPwd" name="loginPwd"/></td>
			</tr>
			<tr>	
				<th colspan="2">
	            	<button id="login">로그인</button>
	         	</th>
			</tr>
        </tbody>
     </table>
     </form>

</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>