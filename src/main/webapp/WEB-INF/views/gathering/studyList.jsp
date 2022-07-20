<%@page import="kh.semi.comembus.gathering.model.dto.Gathering"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/gathering/gatheringList.css">  
<link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css"/>
<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
<script defer src="<%=request.getContextPath() %>/js/gathering/gathering.js"></script>
<script src="<%= request.getContextPath() %>/js/jquery-3.6.0.js"></script>
<%
	List<Gathering> studyList = (List<Gathering>) request.getAttribute("studyList");
	String type = request.getParameter("searchType");
	String keyword = request.getParameter("searchKeyword");
	System.out.println("type = " + type);
	System.out.println("keyword = " + keyword);
%>

	<section class="gathering">
		<!-- 모임페이지 시작 -->
		<!-- 상단 프로젝트/스터디 구분바 -->
		<section class="gathering-bar">
			<p><a href="<%= request.getContextPath()%>/gathering/projectList">프로젝트</a></p>
			<p><a href="<%= request.getContextPath()%>/gathering/studyList">스터디</a></p>
		</section>
		<section class="ps__header">
			<div class="ps__header__text">
				<p>신규 프로젝트</p>
				<i class="fa-solid fa-laptop-code"></i>
			</div>
			<hr>
			<div class="ps__header__content swiper">
				<div class="swiper-wrapper">
				<%
				if(studyList != null && !studyList.isEmpty()){
					for(int i = 0; i < 3; i++){
						String topic = studyList.get(i).getTopic();
				%>
				<div class="swiper-slide">
					<img src="<%= request.getContextPath() %>/images/<%= topic %>.jpg" class="ps__header__content__img" alt="해당 프로젝트 주제 이미지">
					<ul class="ps__header__content-info">
						<li><p class="bold"><%= "Planning".equals(topic) ? "기획" : ("Design".equals(topic) ? "디자인" : ("Frontend".equals(topic) ? "프론트엔드" : ("Backend".equals(topic) ? "백엔드" : ("Interview".equals(topic) ? "면접" : "코딩테스트")))) %></p></li>
						<li><p class="bold"><%= studyList.get(i).getTitle() %></p></li>
						<li class="ps__header__content-content"><p><%= studyList.get(i).getContent() %></p></li>
						<li class="bold">
							<span class="heart-emoji">&#9829; <%= studyList.get(i).getBookmark() %></span>
							<span>&#128064; <%= studyList.get(i).getViewcount() %></span>
							<span>모집인원 0 / <%= studyList.get(i).getPeople() %></span>
						</li>
					</ul>
				</div>
				<%
					}
				}
				%>
				</div>

				<div class="swiper-button-next"></div>
				<div class="swiper-button-prev"></div>
				<div class="swiper-pagination"></div>
			</div>
		<hr>
		</section>
		<!-- 스터디List -->
		<section class="ps-list-main">
			<h1>전체 스터디</h1>
			<div class="ps-filter-container">
				<form name="searchFrm">
					<select name="searchType" value="local" id="p__local" class="ps-filter" onchange="gatheringFilter()">
						<option value="All">지역 미지정</option>
						<option value="Online">온라인</option>
						<option value="Capital">수도권</option>
						<option value="Chungcheong">충청도</option>
						<option value="Gangwon">강원도</option>
						<option value="Jeolla">전라도</option>
						<option value="Gyeongsang">경상도</option>
						<option value="Jeju">제주</option>
					</select>
				</form>
				<form name="searchFrm">
					<select name="searchType" value="jobcode" id="p__job_code" class="ps-filter" onchange="gatheringFilter()">
						<option value="All">직무 미지정</option>
						<option value="PL">기획</option>
						<option value="DG">디자인</option>
						<option value="FE">프론트</option>
						<option value="BE">백엔드</option>
					</select>
				</form>
				<div class="ps-filter">
					<input type="checkbox" id="s__status" name="searchType">
					<label for="s__status">모집중</label>
				</div>
				<div class="ps-filter">
					<input type="checkbox" id="s__bookmark" name="searchType">
					<label for="s__bookmark">찜한 프로젝트</label>
				</div>
				
				<input type="button" class="ps__enroll btn" onclick="location.href='<%= request.getContextPath()%>/gathering/studyEnrollView'" value="스터디 생성">
			</div>
			<div class="ps-lists">
			<%
			if(studyList != null && !studyList.isEmpty()){
				for(Gathering study : studyList){
			%>
				<div class="ps-pre">
					<!-- a태그로 링크 주소 연결해야함 -->
					<a href="">
						<img src="<%= request.getContextPath() %>/images/<%= study.getTopic() %>.jpg" class="ps-pre__img" alt="해당 프로젝트 주제 이미지">
					</a>
					<p class="bold">
						<%= "Planning".equals(study.getTopic()) ? "기획" : ("Design".equals(study.getTopic()) ? "디자인" : ("Frontend".equals(study.getTopic()) ? "프론트엔드" : ("Backend".equals(study.getTopic()) ? "백엔드" : ("Interview".equals(study.getTopic()) ? "면접" : "코딩테스트")))) %>
					</p>
					<a href="">
						<p class="bold"><%= study.getTitle() %></p>
					</a>
					<ul class="ps-pre__etc">
						<li> 
							<span class="heart-emoji">&#9829;</span><%= study.getBookmark() %></li>
						<li>
							<span>&#128064;</span><%= study.getViewcount() %></li>
						<!-- 나중에 모임 게시물별 모집인원현황 테이블과 연결 -->
						<li>모집인원 0 / <%= study.getPeople() %></li>
					</ul>
					<span class="bookmark bookmark-front">♡</span>
					<span class="bookmark bookmark-back">♥</span>
				</div>
			<%
				}
			}
			%>
			</div>
			<div id="pagebar">
				<%= request.getAttribute("pagebar") %>
			</div>
		
		</section>
	</section>
	
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>