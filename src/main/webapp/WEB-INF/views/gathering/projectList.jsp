<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

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
			<div class="ps-filter">
				<select name="local" id="p__local">
					<option value="none">지역 미지정</option>
					<option value="Online">온라인</option>
					<option value="Capital">수도권</option>
					<option value="Chungcheong">충청도</option>
					<option value="Gangwon">강원도</option>
					<option value="Jeolla">전라도</option>
					<option value="Gyeongsang">경상도</option>
					<option value="Jeju">제주</option>
				</select>
				<select name="job_code" id="p__job_code">
					<option value="none">직무 미지정</option>
					<option value="PL">기획</option>
					<option value="DG">디자인</option>
					<option value="FE">프론트</option>
					<option value="BE">백엔드</option>
				</select>
				<input type="checkbox" id="p__status" name="project-status">
				<label for="p__status">모집중</label>
				<input type="checkbox" id="p__bookmark" name="project-bookmark">
				<label for="p__bookmark">찜한 프로젝트</label>
				
				<input type="button" class="p__enroll btn" onclick="location.href='<%= request.getContextPath()%>/gathering/projectEnrollView;'" value="프로젝트 생성">
			</div>
			<div class="ps-lists">
				<!-- 전체 1200px -->
				<div class="ps-pre">
					<!-- div 하나 당 250px -->
					<img src="" alt="해당 프로젝트 주제 이미지">
					<p>프로젝트 주제</p>
					<p>프로젝트명</p>
					<ul>
						<li>찜수</li>
						<li>view수</li>
						<li>모집인원</li>
					</ul>
					<span>♡</span>
					<span>♥</span>
				</div>
			</div>
			<div id="pagebar">
				<a href="#">이전</a>
				<a href="">6</a>
				<a href="">7</a>
				<a href="">8</a>
				<a href="">9</a>
				<a href="">10</a>
				<a href="#">다음</a>
			</div>
		
		</section>
	</section>
	
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>