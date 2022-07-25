<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/member/memberLogin.css" />

<section id=find-container>
	<h2>아이디 찾기</h2>
	<div class="find-content">
		<p>회원가입 시 기입한 이름과 핸드폰 번호를 입력해주세요.</p>
	</div>
	
	<form id="findIdFrm" name="findIdFrm" action="<%= request.getContextPath() %>/membus/showMemberId">
	<table id="findIdTable" class="find-table">
		<tbody>
			<tr>  
				<th><label for="name" class="find-label">이름</label></th>
				<td><input type="text" id="name" name="name" class="find-input"/></td>
			</tr>
			<tr>
				<th><label for="phone" class="find-label">핸드폰 번호</label></th>
           		<td><input type="text" id="phone" name="phone" class="find-input"/></td>
			</tr>	
        </tbody>
     </table>
			<button type="button" id="findIdBtn" class="find-btn">본인 확인</button>
     </form>
     
     <script>
     document.querySelector("#findIdBtn").addEventListener('click', (e) => {
    	const nameVal = document.querySelector("#name").value;
    	const phoneVal= document.querySelector("#phone").value;
    	
		const regExp1 = /^[가-힣]{2,}$/;
		const regExp2 = /^(010){1}[0-9]{7,8}$/;

    	if(nameVal === "" || phoneVal === ""){
     		alert("이름과 핸드폰 번호를 모두 입력하셔야 아이디 찾기가 가능합니다.");
     		return false;
     	}
     	else if(!regExp1.test(nameVal) || !regExp2.test(phoneVal)){
     		alert('이름과 핸드폰 번호를 모두 올바른 형식으로 입력해주세요.');
     		return false;
   		}
   
   		// popup제어
   		const title = "findIdPopup";
   		const spec = "width=480px, height=300px";
   		const popup = open("", title, spec);
   		
   		// form제어
   		const frm = document.findIdFrm;
   		frm.target = title;
   		frm.submit();
     });
     </script>

</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>