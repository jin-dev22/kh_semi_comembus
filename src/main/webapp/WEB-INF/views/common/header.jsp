<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!-- 폰트 -->
  <!-- 220713(선) 엘리스폰트 코딩용 -> 웹폰트로 수정 -->
  <link href="https://font.elice.io/EliceDigitalBaeum.css" rel="stylesheet">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/style.css">
  
  <link rel="icon" href="favicon.ico" />
  <title>CO;MEMBUS</title>
</head>
<body>
  <header>
    <div class="menubar">
      <div class="h__logo">
        <a href="#"><img src="<%= request.getContextPath() %>/images/logo_w.png" alt="logo이미지"></a>
      </div>
  
      <ul class="h__menu__main">
        <li><a href="<%= request.getContextPath() %>/membus/list">멤버스</a></li>
        <li>
          <a href="javascript:void(0)">모임</a>
          <ul class="h__menu__sub">
            <li><a href="javascript:void(0)">프로젝트</a></li>
            <li><a href="javascript:void(0)">스터디</a></li>
          </ul>
        </li>
        <li>
          <a href="javascript:void(0)">커뮤니티</a>
          <ul class="h__menu__sub">
            <li><a href="<%= request.getContextPath() %>/community/communityList">QnA</a></li>
            <li><a href="javascript:void(0)">자유주제</a></li>
            <li><a href="javascript:void(0)">정보공유</a></li>
          </ul>
        </li>
        <li><a href="javascript:void(0)">공지사항</a></li>
        <!-- 관리자로그인시 노출 -->
        <li><a href="javascript:void(0)">회원관리</a></li>
        <li><a href="javascript:void(0)">통계관리</a></li>
      </ul>
  
      <ul class="h__loginSignup">
        <li><a href="<%= request.getContextPath() %>/member/login">회원가입/로그인</a></li>
      </ul>
    </div>
  </header>
  <!-- 메인 시작 -->
  <section>