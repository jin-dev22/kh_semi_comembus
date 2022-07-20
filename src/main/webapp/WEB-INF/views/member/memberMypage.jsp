<%@page import="kh.semi.comembus.member.model.dto.JobCode"%>
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
	String jobCode = member.getJobCode().name();
%>

<section id="membus-profile">
	<form name="profileFrm" enctype="multipart/form-data">
		<div class="profile-row part-1 ">
			<div class="nickname-badge"><%= member.getNickName().charAt(0)%></div>
			<div>
				<div><label for="nickName">닉네임 :</label> &nbsp;&nbsp;&nbsp;<input type="text" name="nickName" value="<%=member.getNickName() %>" readonly/> <input type="button" value="중복검사" onclick="checkNickNameDuplicate();"/> </div>
				<div><label for="search-jobCode">직무분야 : </label> 
					<!-- <select id="search-jobCode" onchange="changeSelected('searchJobcode', this.value)"> -->
					<select id="search-jobCode">
                    <option value="PL" <%= "PL".equals(jobCode)? "selected" : "" %>>기획</option>
                    <option value="DG" <%= "DG".equals(jobCode)? "selected" : "" %>>디자인</option>
                    <option value="FE" <%= "FE".equals(jobCode)? "selected" : "" %>>프론트엔드</option>
                    <option value="BE"  <%= "BE".equals(jobCode)? "selected" : "" %>>백엔드</option>		
                </select>
                <%-- <input type="hidden" name="searchJobcode" value="<%= jobCode != null? jobCode : "ALL"%>"/>	 --%>			
				</div>
			</div>
		</div>
		<div class="profile-row part-2">
			<div class="subtitle">자기소개</div>
			<textarea id="summernote" name="Contents" class="member-introduction"><%=introduction != null? introduction : "작성하신 내용이 없습니다. 자기소개를 작성해주세요!"%></textarea>
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
						<input type="button" value="지원취소하기" class="cancelApld" onclick="cancelApld(<%= gather.getPsNo()%>);"/>
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
	<input type="submit" value="업데이트" />
	<input type="button" value="비밀번호 변경" onclick="updatePassword();"/>
	</form>
</section>
<form name="apldCancelFrm" action="<%= request.getContextPath()%>/gathering/apply/cancel" method="POST">
	<input type="hidden" name="psNo"/>
	<input type="hidden" name="memberId" value="<%= loginMember.getMemberId()%>" />
	
</form>
<a href="">탈퇴하기</a>
<script>
	function cancelApld(psNo){
		if(confirm("지원을 취소하시겠습니까?")){
			const frm = document.apldCancelFrm
			frm.psNo.value = psNo;
			frm.submit();
		}
	}

    <%-- $(document).ready(function() {
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
		
	}); --%>
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>