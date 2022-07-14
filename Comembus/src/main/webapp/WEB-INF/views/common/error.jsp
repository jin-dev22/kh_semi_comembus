<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<%
	// page지시어 isErrorPage="true"로 지정한 경우
	// 발생한 예외객체에 선언없이 접근가능하다.
	String msg = exception.getMessage();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오류</title>
<style>
body {text-align:center;}
h1 {font-size : 500px; margin : 0;}
.err-msg {color : red;}

</style>
</head>
<body>
	<h1>헉</h1>
	<p class="err-msg"><%= msg %></p>
	<hr />
	<a href="<%= request.getContextPath() %>">홈으로</a>
</body>
</html>