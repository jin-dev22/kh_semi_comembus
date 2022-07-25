<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/member/memberLogin.css" />

<section id=login-container>

	<h1 class="login-title">로그인</h1>
	<form id="loginFrm" name="loginFrm" action="<%= request.getContextPath() %>/membus/login" method="POST">
	<input type="hidden" id="location" value="<%= location %>" name="location"/>
	<table id="loginTable" class="login-table">
		<tbody>
			<tr>
				<th><label for="loginId" class="login-label">아이디</label></th>
				<td><input type="text" id="memberId" name="memberId" class="login-input"/></td>
			</tr>
			<tr>
				<th><label for="loginPwd" class="login-label">비밀번호</label></th>
           		<td><input type="password" id="password" name="password" class="login-input"/></td>
           		<td><i class="fa-solid fa-eye-slash pwd-show-hide" title="문자 보이기"></i></td>
			</tr>
			</tbody>
     </table>
           	<button id="loginBtn" class="login-btn">로그인</button>
     </form>
    <div class="login-sub"> 
	    <input type="button" value="아이디 찾기" class="login-sub-btn"
			onclick="location.href='<%= request.getContextPath() %>/membus/findMemberId';">
		<input type="button" value="비밀번호 찾기" class="login-sub-btn"
			onclick="location.href='<%= request.getContextPath() %>/membus/findMemberPassword';">
   	</div>
   	<div class="login-sub">
     	<span>아직 회원이 아니신가요?</span>
     	<input type="button" value="회원가입하기" class="login-sub-btn"
			onclick="location.href='<%= request.getContextPath() %>/membus/enroll';">
   	</div>

</section>

<script>
//비밀번호 보기/숨기기 아이콘
const pwdShowHide = document.querySelector(".pwd-show-hide");
pwdShowHide.addEventListener("click", (e) => {
    const pwdInputType = document.querySelector("#password");
    if (pwdInputType.type === "password") {
      pwdInputType.type = "text";
      e.target.classList.remove("fa-eye-slash");
      e.target.classList.add("fa-eye");
      e.target.title="문자 숨기기";
    } else {
      pwdInputType.type = "password";
      e.target.classList.remove("fa-eye");
      e.target.classList.add("fa-eye-slash");
      e.target.title="문자 보이기";
    }
 });
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>