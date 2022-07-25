<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/member/memberLogin.css" />

<%
	String memberId = (String) request.getAttribute("memberId");
%>

<section id="reset-container">
	<h2 class="reset-title">비밀번호 재설정</h2>
	
	<form id="resetPasswordFrm" name="resetPasswordFrm" method="POST" action="<%= request.getContextPath() %>/membus/resetMemberPassword">
     <input type="hidden" id="memberId" name="memberId" value="<%= memberId %>" />
     <div class="reset-password-input-container">
      <div class="reset-password-label">
        <label for="resetPwd1">비밀번호</label>
      </div>
      <div class="reset-password-input">
        <input type="password" id="resetPwd1" name="resetPwd" placeholder="영문, 숫자, 특수문자 조합 (8~16자)" maxlength="25" />
        <div id="pwd1GuideArea">
          <div id="pwd1GuideLine1">
            <span></span>
            <span></span>
          </div>
          <div id="pwd1GuideLine2">
            <span></span>
            <span></span>
          </div>
        </div>
      </div>
      <i class="fa-solid fa-eye-slash pwd-show-hide" title="문자 보이기"></i>
    </div>

    <div class="reset-password-input-container">
      <div class="reset-password-label">
        <label for="resetPwd2">비밀번호 확인</label>
      </div>
      <div class="reset-password-input">
        <input type="password" id="resetPwd2" placeholder="영문, 숫자, 특수문자 조합 (8~16자)" maxlength="25" />
        <div id="pwd2GuideArea">
          <div id="pwd2GuideLine">
            <span></span>
            <span></span>
          </div>      
        </div>
      </div>
      <i class="fa-solid fa-eye-slash pwd-show-hide" title="문자 보이기"></i>
    </div>
     	<button id="resetPasswordBtn" class="find-btn">비밀번호 재설정</button>
     </form>

</section>
<script>
const resetPwd1 = document.getElementById("resetPwd1");
/**
 * 비번에 아이디가 포함되어있는지 확인하는 함수
 */
const isPwdContainsId = () => {
 if (resetPwd1.value.indexOf("<%= memberId %>") !== -1) {
   showValidationResult(pwd1GuideLine2, "fail", "아이디 사용 제외");
 } else {
   showValidationResult(pwd1GuideLine2, "success", "아이디 사용 제외");
 }
};
</script>
<script src="<%= request.getContextPath() %>/js/member/resetMemberPassword.js"></script>
  
<%@ include file="/WEB-INF/views/common/footer.jsp" %>