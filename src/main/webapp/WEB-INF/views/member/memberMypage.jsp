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
	List<Gathering> gatheringApldList = (List<Gathering>) request.getAttribute("gatheringApldList");
	String introduction = member.getIntroduction();
%>

<form name="profileFrm" enctype="multipart/form-data">
	<section id="membus-profile">
		<div class="profile-row part-1 ">
			<div class="nickname-badge"><%= member.getNickName().charAt(0)%></div>
			<div>
				<div>닉네임 : <input type="text" value="<%=member.getNickName() %>" readonly/> <input type="button" value="중복검사" onclick="checkNickNameDuplicate();"/> </div>
				<div>직무분야 : <%=member.getJobName() %></div>
			</div>
		</div>
		<div class="profile-row part-2">
			<div class="subtitle">자기소개</div>
			<textarea id="summernote" name="editordata" class="member-introduction"></textarea>
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
			<div class="subtitle">모임 참여이력</div>
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
					<div>참여한 모임이 없습니다.</div>
				<%}%>
			</div>
		</div>
		<div class="profile-row part-7">
			<div class="subtitle">모임 지원현황</div>
			<div class="gathering-align">
				<%if(gatheringApldList != null && !gatheringApldList.isEmpty()){
					for(Gathering gather : gatheringApldList){	  
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
					<div>지원결과 대기중인 모임이 없습니다.</div>
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
	<button>업데이트</button>
	<button>비밀번호 변경</button>
	</section>
</form>

<a href="">탈퇴하기</a>
<script>
	function checkNickNameDuplicate(){
		const 
	};
	
	
    $(document).ready(function() {
        var setting = {
			placeholder: '관심분야: <br>사용가능한 기술/언어: <br>자세한 소개: <br>',
			height : 300,
			width : 600,
			lang : 'ko-KR',
			toolbar : toolbar,//지우면 툴바가 화면에 표시됨. 그대로 둘 것
			callbacks : { //여기 부분이 이미지를 첨부하는 부분
			onImageUpload : function(files, editor,
				welEditable) {
					for (var i = files.length - 1; i >= 0; i--) {
						uploadSummernoteImageFile(files[i], this);
					}
				}
			}
		};
		$('#summernote').summernote(setting);
		$('#summernote').summernote('insertText', '<%=introduction %>'); 
		 function saveContent(){
	        var summernoteContent = $('#summernote').summernote('code');        //썸머노트(설명)
	        console.log("summernoteContent : "+summernoteContent);
	    }
		
	});
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>