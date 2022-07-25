<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/member/memberLogin.css" />

<section id=find-container>
	<h2>비밀번호 재설정</h2>
	<div class="find-content">
		<p>비밀번호는 암호화 저장되므로 분실 시 찾아드릴 수 없는 정보입니다.</p>
		<p>본인 확인을 통해 비밀번호를 재설정 하실 수 있습니다.</p>
	</div>
	
	<!-- 본인확인 입력값 전송 -->
	<form id="findPasswordFrm" name="findPasswordFrm" action="<%= request.getContextPath() %>/membus/resetMemberPassword">
	<table id="findPasswordTable" class="find-table">
		<tbody>
			<tr> 
				<th><label for="name" class="find-label">이름</label></th>
				<td><input type="text" id="name" name="name" class="find-input"/></td>
			</tr>
			<tr>
				<th><label for="phone" class="find-label">핸드폰 번호</label></th>
           		<td><input type="text" id="phone" name="phone" class="find-input"/></td>
			</tr>
			<tr> 
				<th><label for="id" class="find-label">아이디</label></th>
				<td><input type="text" id="id" name="id" class="find-input"/></td>
			</tr>
        </tbody>
     </table>
     	<button id="resetPasswordBtn" class="find-btn">본인 확인</button>
     </form>
     
     <script>
	 // 본인 확인 폼 제출 전 유효성 검사
     document.findPasswordFrm.onsubmit = (e) => {
    	const nameVal = document.querySelector("#name").value;
    	const phoneVal= document.querySelector("#phone").value;
    	const idVal= document.querySelector("#id").value;
    	
    	const regExp1 = /^[가-힣]{2,}$/;
    	const regExp2 = /^(010){1}[0-9]{7,8}$/;
    	const regExp3 = /^[a-z\d]{6,12}$/;
    	
    	if(nameVal === "" || phoneVal === "" || idVal === ""){
    		alert("3가지 항목을 모두 입력하셔야 비밀번호 재설정이 가능합니다.");
    		return false;
    	}
    	else if(!regExp1.test(nameVal) || !regExp2.test(phoneVal) || !regExp3.test(idVal)){
    		alert('3가지 항목 모두 올바른 형식으로 입력해주세요.');
    		return false;
   		}
     };
     </script>

</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>