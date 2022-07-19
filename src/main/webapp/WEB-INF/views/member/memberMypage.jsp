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

<form name="profileFrm" enctype="multipart/form-data">
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
	<button>업데이트</button>
	<button>비밀번호 변경</button>
<a href="">탈퇴하기</a>
<script>
    $(document).ready(function() {
        var setting = {
			placeholder: '<strong>1. 프로젝트의 시작 동기</strong> <br> - 이 서비스를 만들고 싶은 이유 <br> (ex. 기존에 존재하는 배달 시스템에 불만이 있어 보다 효율적인 앱을 만들고 싶습니다.) <br> - 어떤 사용자를 목적으로 하는지 써주세요. <br> (ex - 혼자사는 1인가구를 목적으로 하는 배달 어플 서비스) <br><br> <strong> 2. 프로젝트의 진행방식</strong> <br> - 1주일에 며칠 진행할 예정인가요? <br>(ex - 1주일에 1,2회 멤버 모이면 상의 후 결정) <br>- 온/오프라인 회의시 진행 방식과 진행 도구를 말해주세요. <br>(ex - 온라인, 디스코드(화면 공유 얼굴 비침 필수)) <br> <br> <strong>3. 사용기술</strong> <br>(ex - html, css, js, JAVA, Spring, Git)<br><br> <strong>4. 출시 플랫폼</strong><br>(ex - web, Android) <br><br> <strong>5. 기타 자유내용</strong> <br>(ex - 상업적인 부분은 기획자가 담당합니다.)',
			height : 300,
			width : 600,
			lang : 'ko-KR',
			toolbar : toolbar,
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
		$('#summernote').summernote('insertText', <%=member.getIntroduction() %>); 
	});
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>