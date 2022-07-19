<%@page import="kh.semi.comembus.gathering.model.dto.Gathering"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css"/>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/gathering/gatheringList.css">
<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
<script src="<%=request.getContextPath() %>/js/gathering/gathering.js"></script>
<script src="<%= request.getContextPath() %>/js/jquery-3.6.0.js"></script>
<%
	List<Gathering> projectList = (List<Gathering>) request.getAttribute("projectList");
	String type = request.getParameter("searchType");
	String keyword = request.getParameter("searchKeyword");
%>
<script>
const onchangeLocal = () => {
	const selectlocal = document.getElementById("p__local").options[document.getElementById("p__local").selectedIndex].value;
	findLocal(selectlocal);
};
const findLocal = (selectlocal) => {
	console.log("selectlocal = ", selectlocal); // 확인용
	$.ajax({
		url: '<%= request.getContextPath() %>/gathering/searchLocal',
		data: {searchType: 'local', searchKeyword: selectlocal},
		success(projectSelectList){
			console.log(projectSelectList); // 확인용
			const {projectList, searchPagebar} = projectSelectList;
			console.log("projectList = ", projectList); // 확인용
			console.log("searchPagebar = ", searchPagebar); // 확인용
			document.querySelector(".ps-lists").innerHTML =
				projectList.reduce((html, selectList, index) => {
					const {title, viewcount, bookmark, topic, people} = selectList;
					console.log("확인용", title, viewcount, bookmark, topic, people);
					return `\${html}
					<div class="ps-pre">
						<a href="">
							<img src="<%= request.getContextPath() %>/images/\${topic}.jpg" class="ps-pre__img" alt="해당 프로젝트 주제 이미지">
						</a>
						<p class="bold">\${topic === 'social' ? '소셜네트워크' : (topic === 'game' ? '게임' : (topic === 'travel' ? '여행' : (topic === 'finance' ? '금융' : '이커머스')))}</p>
						<p class="bold">\${title}</p>
						<ul class="ps-pre__etc">
							<li>
								<span class="heart-emoji">&#9829;</span>\${bookmark}
							</li>
							<li>
								<span>&#128064;</span>\${viewcount}
							</li>
							<li>모집인원 0 / \${people}</li>
						</ul>
					</div>
					`;
				}, '');
			document.querySelector("#pagebar").innerHTML = `\${searchPagebar}`;
		},
		error: console.log
	});
};

</script>

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
				<%
				if(projectList != null && !projectList.isEmpty()){
					for(int i = 0; i < 3; i++){
						String topic = projectList.get(i).getTopic();

				%>
				<!-- swiper-slide 3개 생성 및 추후 진행 -->
				<div class="swiper-slide">
					<img src="<%= request.getContextPath() %>/images/<%= topic %>.jpg" class="ps__header__content__img" alt="해당 프로젝트 주제 이미지">
					<ul class="ps__header__content-info">
						<li><p class="bold"><%= projectList.get(i).getTopic() %></p></li>
						<li><p class="bold"><%= projectList.get(i).getTitle() %></p></li>
						<li class="ps__header__content-content"><p><%= projectList.get(i).getContent() %></p></li>
						<li class="bold">
							<span><%= projectList.get(i).getBookmark() %></span>
							<span><%= projectList.get(i).getViewcount() %></span>
							<span>모집인원 0 / 10</span>
						</li>
					</ul>
				</div>
				<%
					}
				}
				%>
				<div class="swiper-button-next"></div>
				<div class="swiper-button-prev"></div>
				<div class="swiper-pagination"></div>
			</div>
		<hr>
		</section>
		<!-- 프로젝트List -->
		<section class="ps-list-main">
			<h1>전체 프로젝트</h1>
			<div class="ps-filter-container">
				<form name="searchFrm">
					<select name="searchType" value="local" id="p__local" class="ps-filter" onchange="onchangeLocal()">
						<option value="none" name="searchKeyword" <%= "none".equals(keyword) ? "selected" : "" %>>지역 미지정</option>
						<option value="Online" name="searchKeyword" <%= "Online".equals(keyword) ? "selected" : "" %>>온라인</option>
						<option value="Capital" name="searchKeyword" <%= "Capital".equals(keyword) ? "selected" : "" %>>수도권</option>
						<option value="Chungcheong" name="searchKeyword" <%= "Chungcheong".equals(keyword) ? "selected" : "" %>>충청도</option>
						<option value="Gangwon" name="searchKeyword" <%= "Gangwon".equals(keyword) ? "selected" : "" %>>강원도</option>
						<option value="Jeolla" name="searchKeyword" <%= "Jeolla".equals(keyword) ? "selected" : "" %>>전라도</option>
						<option value="Gyeongsang" name="searchKeyword" <%= "Gyeongsang".equals(keyword) ? "selected" : "" %>>경상도</option>
						<option value="Jeju" name="searchKeyword" <%= "Jeju".equals(keyword) ? "selected" : "" %>>제주</option>
					</select>
				</form>
				<form action="<%= request.getContextPath() %>/gathering/search" method="post">
					<select name="searchType" id="p__job_code" class="ps-filter">
						<option value="none">직무 미지정</option>
						<option value="PL">기획</option>
						<option value="DG">디자인</option>
						<option value="FE">프론트</option>
						<option value="BE">백엔드</option>
					</select>
				</form>
				<div class="ps-filter">
					<input type="checkbox" id="p__status" name="searchType">
					<label for="p__status">모집중</label>
				</div>
				<div class="ps-filter">
					<input type="checkbox" id="p__bookmark" name="searchType">
					<label for="p__bookmark">찜한 프로젝트</label>
				</div>
				
				<input type="button" class="ps__enroll btn" onclick="location.href='<%= request.getContextPath()%>/gathering/projectEnroll;'" value="프로젝트 생성">
			</div>
			<div class="ps-lists">
			<%
			if(projectList != null && !projectList.isEmpty()){
				for(Gathering project : projectList){
			%>
				<div class="ps-pre">
					<!-- a태그로 링크 주소 연결해야함 -->
					<a href="">
						<img src="<%= request.getContextPath() %>/images/<%= project.getTopic() %>.jpg" class="ps-pre__img" alt="해당 프로젝트 주제 이미지">
					</a>
					<p class="bold"><%= "social".equals(project.getTopic()) ? "소셜네트워크" : ("game".equals(project.getTopic()) ? "게임" : ("travel".equals(project.getTopic()) ? "여행" : ("finance".equals(project.getTopic()) ? "금융" : "이커머스"))) %></p>
					<a href="">
						<p class="bold"><%= project.getTitle() %></p>
					</a>
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