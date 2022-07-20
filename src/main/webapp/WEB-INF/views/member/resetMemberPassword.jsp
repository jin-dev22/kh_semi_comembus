<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/member/memberLogin.css" />

<%
	String memberId = (String) session.getAttribute("memberId");
%>

<section id=find-container>
	<h2>비밀번호 재설정</h2>
	<div class="find-content">
		<p>비밀번호는 암호화 저장되므로 분실 시 찾아드릴 수 없는 정보입니다.</p>
		<p>본인 확인을 통해 비밀번호를 재설정 하실 수 있습니다.</p>
	</div>
	
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
<script src="<%= request.getContextPath() %>/js/member/resetMemberPassword.js"></script>
  
<%@ include file="/WEB-INF/views/common/footer.jsp" %>