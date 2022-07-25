<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String memberId = (String) request.getAttribute("memberId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디찾기</title>
<style>
.popup-content{
	text-align: center;
	padding: 60px 0;
}

.popup-content button{
  background-color: #92B4EC;
  border-color: #92B4EC;
  border-style: none;
  border-radius: 3px;
  width: fit-content;
  height: 30px;
  color: white;
}

.popup-content button:hover{
  cursor: pointer;
  background-color: #77a0e2;
  color: black;
}
</style>
</head>
<body>
<% if(memberId != null) { %>
	<%-- 입력한 값에 해당하는 아이디가 존재하는 경우 --%>
	<div class = "popup-content">
		<p>회원님의 아이디는 <%= memberId.substring(0, memberId.length() - 3) %>*** 입니다.</p>
		<button type="button" onclick="toLogin();">로그인하러가기</button>
		<button type="button" onclick="toFindMemberPassword();">비밀번호 찾기</button>
		<button type="button" onclick="closePopup();">닫기</button>
	</div>
<% } else { %>
	<%-- 입력한 값에 해당하는 아이디가 존재하지 않는 경우 --%>
	<div class = "popup-content">
		<p>입력하신 정보에 해당하는 회원이 존재하지 않습니다.</p>
		<p>정보를 다시 확인하신 후 시도해주세요.</p>
		<button type="button" onclick="closePopup();">닫기</button>
	</div>
<% } %>

<script>
const toLogin = () => {
	opener.location.href = '<%= request.getContextPath() %>/membus/login';
	self.close();
};

const toFindMemberPassword = () => {
	opener.location.href = '<%= request.getContextPath() %>/membus/findMemberPassword';
	self.close();
}

const closePopup = () => {		
	self.close();
};
</script>
</body>
</html>