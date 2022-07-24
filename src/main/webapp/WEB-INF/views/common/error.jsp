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
body {text-align:center; }
h2 {margin : 0;}
.err-msg {color : red;}
.error_img{
    width: 300px;
    position: absolute;
    top: 250;
}
#error-background{
    width: 400px;
    height: 400px;
    background-color: #FFE69A;
    border-radius: 30%;
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 100px auto 10px;
}
h1{
    margin: 0;
    width: 400px;
    margin: auto;
}
</style>
</head>
<body>
    <div id="error-background">
		<img src="<%= request.getContextPath() %>/images/errorImage.png" class="ps-pre__img" alt="에러페이지 이미지">
    </div>
         <h1>앗 잠시만요!</h1>
        <p class="err-msg"><%= msg %></p>
        <a href="<%= request.getContextPath() %>">메인화면으로 이동하기</a>
</body>
</html>
