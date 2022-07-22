<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/member/memberLogin.css" />

<%
	String memberId = loginMember.getMemberId();
%>

<section id=find-container>
	<h2>비밀번호 변경</h2>
	<div class="find-content">
		<p>기존 비밀번호 확인 후 재설정 하실 수 있습니다.</p>
	</div>
	
	<form id="resetPasswordFrm" name="resetPasswordFrm" method="POST" action="<%= request.getContextPath() %>/membus/updateMemberPassword">
	    <%-- css적용을 위해 클래스명은 비밀번호 찾기폼의 클래스명을 가져옴 --%>
        <input type="hidden" id="memberId" name="memberId" value="<%= memberId %>" />	    
	    <div class="reset-password-input-container chekPwBox">
	    
		     <div class="reset-password-label">
		       <label for="oldPassword">비밀번호</label>
		     </div>
		     <div class="reset-password-input">
		       <input type="password" id="oldPassword" name="oldPassword" placeholder="기존 비밀번호를 입력해주세요." maxlength="25" />
		     </div>
		     <i class="fa-solid fa-eye-slash pwd-show-hide" title="문자 보이기"></i>
		     <input type="button"  class="find-btn" value="비밀번호 확인" onclick="checkPassword()"/>
	    </div>
	    
	    
	    
	    <div class="updatePwBox" style="display: none;">
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
	    </div>    
     </form>

</section>
<script>
	
	function checkPassword(){
		const frm = document.resetPasswordFrm;
		const oldPw = frm.oldPassword;
		$.ajax({
			type : 'POST',
			url: '<%= request.getContextPath() %>/membus/checkMemberPassword',
			data : {"oldPw" : oldPw.value},
			success(result){
				if(result){				
					console.log("비밀번호 일치");
					const chekPwBox = frm.querySelector(".chekPwBox");
					chekPwBox.style.display = 'none';
					
					const updatePwBox = frm.querySelector(".updatePwBox");
					updatePwBox.style.display = 'block';
				}
				else{
					alert("비밀번호가 일치하지 않습니다.");
					oldPw.focus();
				}				
			},
			error: console.log
		});
	}
</script>
<script src="<%= request.getContextPath() %>/js/member/resetMemberPassword.js"></script>
  
<%@ include file="/WEB-INF/views/common/footer.jsp" %>