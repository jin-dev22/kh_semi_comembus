<%@page import="kh.semi.comembus.gathering.model.dto.Gathering"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<Gathering> projectList = (List<Gathering>) request.getAttribute("projectList");

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
				<!-- swiper-slide 3개 생성 및 추후 진행 -->
				<div class="swiper-slide">
					<img src="<%= request.getContextPath() %>/images/ecommerce.jpg" class="ps__header__content__img" alt="해당 프로젝트 주제 이미지">
					<!-- 연결 후 아래코드로 진행 -->
					<%-- <img src="<%= request.getContextPath() %>/images/\${topic}" class="ps__header__content__img" alt="해당 프로젝트 주제 이미지"> --%>
					<ul class="ps__header__content-info">
						<li><p class="bold">프로젝트 분야</p></li>
						<li><p class="bold">프로젝트명</p></li>
						<li class="ps__header__content-content"><p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Perferendis ipsam modi, magnam temporibus ut iure asperiores aliquid dolore maiores, corporis aut unde cumque eum molestias. Officia enim beatae magnam saepe.</p></li>
						<li class="bold">
							<span>찜수</span>
							<span>view수</span>
							<span>모집인원</span>
						</li>
					</ul>
				</div>
		
				<div class="swiper-pagination"></div>
			</div>
		<hr>
		</section>
		<!-- 프로젝트List -->
		<section class="ps-list-main">
			<h1>전체 프로젝트</h1>
			<div class="ps-filter-container">
				<select name="local" id="p__local" class="ps-filter">
					<option value="none">지역 미지정</option>
					<option value="Online">온라인</option>
					<option value="Capital">수도권</option>
					<option value="Chungcheong">충청도</option>
					<option value="Gangwon">강원도</option>
					<option value="Jeolla">전라도</option>
					<option value="Gyeongsang">경상도</option>
					<option value="Jeju">제주</option>
				</select>
				<select name="job_code" id="p__job_code" class="ps-filter">
					<option value="none">직무 미지정</option>
					<option value="PL">기획</option>
					<option value="DG">디자인</option>
					<option value="FE">프론트</option>
					<option value="BE">백엔드</option>
				</select>
				<div class="ps-filter">
					<input type="checkbox" id="p__status" name="project-status">
					<label for="p__status">모집중</label>
				</div>
				<div class="ps-filter">
					<input type="checkbox" id="p__bookmark" name="project-bookmark">
					<label for="p__bookmark">찜한 프로젝트</label>
				</div>
				
				<input type="button" class="ps__enroll btn" onclick="location.href='<%= request.getContextPath()%>/gathering/projectEnrollView;'" value="프로젝트 생성">
			</div>
			<div class="ps-lists">
			<%
			if(projectList != null && !projectList.isEmpty()){
				for(Gathering project : projectList){
			%>
				<div class="ps-pre">
				<!-- 추후에 a태그로 링크걸어야함 -->
					<img src="<%= request.getContextPath() %>/images/<%= project.getTopic() %>.jpg" class="ps-pre__img" alt="해당 프로젝트 주제 이미지">
					<p class="bold"><%= "social".equals(project.getTopic()) ? "소셜네트워크" : ("game".equals(project.getTopic()) ? "게임" : ("travel".equals(project.getTopic()) ? "여행" : ("finance".equals(project.getTopic()) ? "금융" : "이커머스"))) %></p>
					<p class="bold"><%= project.getTitle() %></p>
					<ul class="ps-pre__etc">
						<li> 
							<span class="heart-emoji">&#9829;</span><%= project.getBookmark() %></li>
						<li>
							<span>&#128064;</span><%= project.getViewcount() %></li>
						<!-- 나중에 모임 게시물별 모집인원현황 테이블과 연결 -->
						<li>모집인원 0 / 10</li>
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