<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<%
	// page지시어 isErrorPage="true"로 지정한 경우
	// 발생한 예외객체에 선언없이 접근가능하다.
	// error code로 넘어온 경우 exception객체는 null이다.
	// String msg = exception.getMessage();
	int statusCode = response.getStatus(); // 404
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오류</title>

</head>
<body>
	<h1>텅</h1>
	<p class="err-msg">찾으시는 페이지가 없습니다.</p>
	<hr />
	<a href="<%= request.getContextPath() %>">홈으로</a>
	<br />
	<a href="javascript:history.back()">뒤로가기</a>
</body>
</html>