<%@page import="kh.semi.comembus.common.ComembusUtils"%>
<%@page import="kh.semi.comembus.community.model.dto.Community"%>
<%@page import="kh.semi.comembus.gathering.model.dto.Gathering"%>
<%@page import="kh.semi.comembus.member.model.dto.MemberExt"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/main.css">
<link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css"/>
<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
<script defer src="<%=request.getContextPath() %>/js/gathering/gathering.js"></script>

<section class="slide">
<%
	List<Gathering> projectList = (List<Gathering>) request.getAttribute("projectList");
	List<Member> memberList = (List<Member>) request.getAttribute("memberList");
	List<Community> flist = (List<Community>) request.getAttribute("flist"); 
	List<Community> slist = (List<Community>) request.getAttribute("slist"); 
	List<Community> qlist = (List<Community>) request.getAttribute("qlist"); 
%>

<div class="main__header__content swiper">
	<div class="swiper-wrapper">
	<%
		for(int i = 1; i <= 3; i++){
	%>
	<div class="swiper-slide">
		<img src="<%= request.getContextPath() %>/images/main_banner_<%= i %>.jpg" class="main__header__content__img" alt="메인 상단 슬라이드_<%= i %>">
	</div>
	<%
		}
	%>
	</div>

	<div class="swiper-button-next"></div>
	<div class="swiper-button-prev"></div>
	<div class="swiper-pagination"></div>
</div>
</section>

<section class="preview">
<div class="preview-container">
	<div class="preview-text">
		<h3 class="container-title">프로젝트 미리보기</h3>
		<p class="move-page"><a href="<%= request.getContextPath()%>/gathering/projectList">전체보기</a></p>
	</div>
	<div class="ps-lists">
	<%
	if(projectList != null && !projectList.isEmpty()){
		for(Gathering project : projectList){
			int psNo = project.getPsNo();
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
				<li>모집인원 0 / <%= project.getPeople() %></li>
			</ul>
			<div class="ps__bookmark">
				<button class="bookmark-front" value="<%= psNo %>">♡</button>
				<!-- <input type="button" value="♡" class="bookmark-front"/> -->
				<button class="bookmark-back" value="<%= psNo %>">♥</button>
				<!-- <input type="button" value="♥" onClick="delBookmark()" class="bookmark-back"/> -->
			</div>
		</div>
	<%
		}
	}
	%>
	</div>
</div>
<div class="preview-container">
	<div class="preview-text">
		<h3 class="container-title">스터디 미리보기</h3>
		<p class="move-page"><a href="<%= request.getContextPath()%>/gathering/studyList">전체보기</a></p>
	</div>
</div>
	
	
<div class="preview-container">
	<div class="preview-text">
		<h3 class="container-title">멤버스 미리보기</h3>
		<p class="move-page"><a href="<%= request.getContextPath()%>/gathering/membus/list">전체보기</a></p>
	</div>
	<div id="membusProfile-container">
	<%
		if(memberList != null && !memberList.isEmpty()){
			for(Member m : memberList){
				MemberExt mem = (MemberExt) m;
				String nickName = mem.getNickName();
				String jobName = mem.getJobName();
				int gatheringCnt = mem.getGetheringCnt();
	%>
		        <div class="profile-box">
		            <div class="profile-row">
		                <span class="profile-badge"><b><%=nickName.charAt(0) %></b></span>
		                <span class="profile-nickName"><%=nickName %></span>
		            </div>
		            <div class="profile-jobName"><%= jobName %></div>
		            <p class="gathringYN">진행중인 모임이 <%= gatheringCnt > 0? gatheringCnt+"개 있습니다.": "없습니다."%></p>
		            <button class="btn-showProfile" onclick="viewMembusProfile('<%= mem.getMemberId()%>')">더보기</button>
		        </div>
		<% }
		}else {
		%>
			<div>검색 결과가 없습니다.</div>
		<%   
		}
		%>
	</div>
</div>

<div class="preview-container">
	<h3 class="container-title">커뮤니티 미리보기</h3>
	<div class="community-s-container">
		<div class="preview-text">
			<span class="container-title-co">정보공유 미리보기</span>
			<p class="move-page"><a href="<%= request.getContextPath()%>/community/communityList?co_type=S">전체보기</a></p>
		</div>
		<div class="co-share-lists">
			<% if(slist == null || slist.isEmpty()){ %>
			<div>조회된 게시글이 없습니다.</div>
			<% }else{ 
				for(Community c:slist){
			%>
				<div class="co-share">
					<div class="co-share-title">
						<a href="<%= request.getContextPath() %>/community/communityView?co_type=S&no=<%= c.getCoNo() %>"><%= ComembusUtils.escapeXml(c.getCoTitle()) %></a>
					</div>
					<!-- <div class="admin-choice">운영자선정</div>  -->
					<div class="co-share-info">
						<span class="co-share-writer"><%= c.getCoWriter() %></span>
						<span class="heart-emoji">&#9829;</span><%= c.getCoLike() %></span>
						<span>&#128064;</span><%= c.getCoReadcount() %></span>
					</div>
				</div>
			<%
					}
				} 
			%>
		</div>
	</div>

	<div class="community-qf-wrapper">
		<div class="community-qf-container">
			<div class="preview-text">
				<span class="container-title-co">QnA 미리보기</span>
				<p class="move-page"><a href="<%= request.getContextPath()%>/community/communityList?co_type=Q">전체보기</a></p>
			</div>
			<% if(qlist == null || qlist.isEmpty()){ %>
				<div>조회된 게시글이 없습니다.</div>
			<% }else{ 
				for(int i = 0; i < qlist.size(); i++){
				%>
				<div class="co-qf-title">
					<a href="<%= request.getContextPath() %>/community/communityView?co_type=Q&no=<%= qlist.get(i).getCoNo() %>"><%= i + 1 %>. <%= ComembusUtils.escapeXml(qlist.get(i).getCoTitle()) %></a>
				</div>
			<%
					}
				} 	
			%>
		</div>
		
		
		<div class="community-qf-container">
			<div class="preview-text">
				<span class="container-title-co">자유주제 미리보기</span>
				<p class="move-page"><a href="<%= request.getContextPath()%>/community/communityList?co_type=F">전체보기</a></p>
			</div>
			<% if(flist == null || flist.isEmpty()){ %>
			<div>조회된 게시글이 없습니다.</div>
			<% }else{ 
				for(int i = 0; i < flist.size(); i++){
				%>
			<div class="co-qf-title">
				<a href="<%= request.getContextPath() %>/community/communityView?co_type=F&no=<%= flist.get(i).getCoNo() %>"><%= i + 1 %>. <%= ComembusUtils.escapeXml(flist.get(i).getCoTitle()) %></a>
			</div> 
			<%
					}
				} 
			%>
		</div>
	</div>
</div>
		

</section>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>