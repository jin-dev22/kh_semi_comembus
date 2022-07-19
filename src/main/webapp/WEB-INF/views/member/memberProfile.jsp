<%@page import="kh.semi.comembus.gathering.model.dto.GatheringType"%>
<%@page import="kh.semi.comembus.gathering.model.dto.Gathering"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="kh.semi.comembus.community.model.dto.Community"%>
<%@page import="java.util.List"%>
<%@page import="kh.semi.comembus.member.model.dto.MemberExt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/membusPage.css">
<%
	MemberExt member = (MemberExt) request.getAttribute("member");
	List<Community> communityList = (List<Community>) request.getAttribute("communityList");
	List<Gathering> gatheringIngList = (List<Gathering>) request.getAttribute("gatheringIngList");
	List<Gathering> gatheringBookmarkList = (List<Gathering>) request.getAttribute("gatheringBookmarkList");
	String introduction = member.getIntroduction();
%>
<form name="profileFrm">
	<section id="membus-profile">
		<div class="profile-row part-1 ">
			<div class="nickname-badge"><%= member.getNickName().charAt(0)%></div>
			<div>
				<div>닉네임 : <%=member.getNickName() %></div>
				<div>직무분야 : <%=member.getJobName() %></div>
			</div>
		</div>
		<div class="profile-row part-2">
			<div class="subtitle">자기소개</div>
			<p class="member-introduction"><%=member.getIntroduction() %></div>
		</div>
		<div class="profile-row part-3">
			<div class="subtitle">최근 작성한 게시물</div>
			<div class="coBoard-list">
				<%if(communityList != null && !communityList.isEmpty()){
					for(Community co : communityList){
				%>
				<div class="coBoard">
					<span class="coTitle"><%= co.getCoTitle() %></span>
					<span class="coRegDate"><%= new SimpleDateFormat("yyyy-MM-dd").format(co.getCoRegdate()) %></span>
					<span class="coNums coLike"><%= co.getCoLike() %></span>
					<span class="coNums coReadCnt"><%= co.getCoReadcount() %></span>
				</div>
				<%  }%>
				<div class="pagebar"><%= request.getAttribute("pagebar")%></div>
				<%}else{
				%>
				<div>조회된 게시글이 없습니다.</div>
				<%} %>
			</div>
		</div>
		<div class="profile-row part-4">
			<div class="subtitle">모임 참여현황</div>
			<div class="gathering-align">
				<%if(gatheringIngList != null && !gatheringIngList.isEmpty()){
					for(Gathering gather : gatheringIngList){	  
				%>	
				<div class="ps-pre">
					<!-- 추후에 a태그로 링크걸어야함 -->
						<img src="<%= request.getContextPath() %>/images/<%= gather.getTopic() %>.jpg" class="ps-pre__img" alt="해당 프로젝트 주제 이미지">
						<p class="bold"><%= "social".equals(gather.getTopic()) ? "소셜네트워크" : ("game".equals(gather.getTopic()) ? "게임" : ("travel".equals(gather.getTopic()) ? "여행" : ("finance".equals(gather.getTopic()) ? "금융" : "이커머스"))) %></p>
						<p class="bold"><%= gather.getTitle() %></p>
						<ul class="ps-pre__etc">
							<li> 
								<span class="heart-emoji">&#9829;</span><%= gather.getBookmark() %></li>
							<li>
								<span>&#128064;</span><%= gather.getViewcount() %></li>
							<!-- 나중에 모임 게시물별 모집인원현황 테이블과 연결 -->
							<li>모집인원 0 / 10</li>
						</ul>
						<span class="bookmark bookmark-front">♡</span>
						<span class="bookmark bookmark-back">♥</span>
					</div>				
				<% 
					}
				}else{
				%>
					<div>참여중인 모임이 없습니다.</div>
				<%}%>
			</div>
		</div>
		<div class="profile-row part-5">
			<div class="subtitle">찜한 프로젝트</div>
			<div class="gathering-align">
				<%if(gatheringBookmarkList != null && !gatheringBookmarkList.isEmpty()){
					for(Gathering gather : gatheringBookmarkList){	  
						if(gather.getPsType() == GatheringType.P){
					%>	    	
							<div class="ps-pre">
							<!-- 추후에 a태그로 링크걸어야함 -->
								<img src="<%= request.getContextPath() %>/images/<%= gather.getTopic() %>.jpg" class="ps-pre__img" alt="해당 프로젝트 주제 이미지">
								<p class="bold"><%= "social".equals(gather.getTopic()) ? "소셜네트워크" : ("game".equals(gather.getTopic()) ? "게임" : ("travel".equals(gather.getTopic()) ? "여행" : ("finance".equals(gather.getTopic()) ? "금융" : "이커머스"))) %></p>
								<p class="bold"><%= gather.getTitle() %></p>
								<ul class="ps-pre__etc">
									<li> 
										<span class="heart-emoji">&#9829;</span><%= gather.getBookmark() %></li>
									<li>
										<span>&#128064;</span><%= gather.getViewcount() %></li>
									<!-- 나중에 모임 게시물별 모집인원현황 테이블과 연결 -->
									<li>모집인원 0 / 10</li>
								</ul>
								<span class="bookmark bookmark-front">♡</span>
								<span class="bookmark bookmark-back">♥</span>
							</div>				
				<% 
						}
					}
				}else{%>
						<div>찜한 프로젝트가 없습니다.</div>
				<%}%>
			</div>
		</div>
		<div class="profile-row part-6">
			<div class="subtitle">찜한 스터디</div>
				<div class="gathering-align">
					<%if(gatheringBookmarkList != null && !gatheringBookmarkList.isEmpty()){
						for(Gathering gather : gatheringBookmarkList){	  
							if(gather.getPsType() == GatheringType.S){
						%>	 
						<div class="ps-pre">
							<!-- 추후에 a태그로 링크걸어야함 -->
							<img src="<%= request.getContextPath() %>/images/<%= gather.getTopic() %>.jpg" class="ps-pre__img" alt="해당 프로젝트 주제 이미지">
							<p class="bold"><%= "social".equals(gather.getTopic()) ? "소셜네트워크" : ("game".equals(gather.getTopic()) ? "게임" : ("travel".equals(gather.getTopic()) ? "여행" : ("finance".equals(gather.getTopic()) ? "금융" : "이커머스"))) %></p>
							<p class="bold"><%= gather.getTitle() %></p>
							<ul class="ps-pre__etc">
								<li> 
									<span class="heart-emoji">&#9829;</span><%= gather.getBookmark() %></li>
								<li>
									<span>&#128064;</span><%= gather.getViewcount() %></li>
								<!-- 나중에 모임 게시물별 모집인원현황 테이블과 연결 -->
								<li>모집인원 0 / 10</li>
							</ul>
							<span class="bookmark bookmark-front">♡</span>
							<span class="bookmark bookmark-back">♥</span>
						</div>				
					<% 		}
						}
					}else{%>
						<div>찜한 스터디가 없습니다.</div>
				<%}%>   	
			</div>
		</div>
	</section>
</form>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>