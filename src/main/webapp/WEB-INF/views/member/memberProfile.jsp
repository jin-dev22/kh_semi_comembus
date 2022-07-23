<%@page import="kh.semi.comembus.gathering.model.dto.GatheringExt"%>
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
	List<GatheringExt> gatheringIngList = (List<GatheringExt>) request.getAttribute("gatheringIngList");
	List<GatheringExt> gatheringBookmarkList = (List<GatheringExt>) request.getAttribute("gatheringBookmarkList");
	String introduction = member.getIntroduction();
%>
<form name="profileFrm">
	<section id="membus-profile">
		<div class="profile-row part-1 ">
			<div class="nickname-badge"><%= member.getNickName().charAt(0)%></div>
			<div>
				<div><span class="mypage-span-like-label">닉네임 : </span><%=member.getNickName() %></div>
				<div><span class="mypage-span-like-label">직무분야 : </span><%=member.getJobName() %></div>
			</div>
		</div>
		<div class="profile-row part-2">
			<div class="subtitle">자기소개</div>
			<p class="member-introduction"><%=introduction != null? introduction : "작성한 자기소개가 없습니다." %></p>
		</div>
		<div class="profile-row part-3">
			<div class="subtitle">최근 작성한 게시물</div>
			<div class="coBoard-list">
				<%if(communityList != null && !communityList.isEmpty()){
					for(Community co : communityList){
				%>
				<div class="coBoard">
					<a href="<%= request.getContextPath()%>/community/communityView?co_type=<%=co.getCoType()%>&no=<%=co.getCoNo()%>">
						<span class="coTitle"><%= co.getCoTitle() %></span>
						<span class="coRegDate"><%= new SimpleDateFormat("yyyy-MM-dd").format(co.getCoRegdate()) %></span>
						<span class="coNums coLike"><%= co.getCoLike() %></span>
						<span class="coNums coReadCnt"><%= co.getCoReadcount() %></span>
					</a>
				</div>
				<%  }%>
				<div class="pagebar"><%= request.getAttribute("pagebar")%></div>
				<%}else{
				%>
				<div class="empty-content">조회된 게시글이 없습니다.</div>
				<%} %>
			</div>
		</div>
		<div class="profile-row part-4">
			<div class="subtitle">모임 참여이력</div>
			<div class="gathering-align">
				<%if(gatheringIngList != null && !gatheringIngList.isEmpty()){
					for(GatheringExt gather : gatheringIngList){
						String putUrl = gather.getPsType() == GatheringType.P ? "/gathering/projectView?psNo=" : "/gathering/studyView?psNo="; 									
						int psNo = gather.getPsNo();
						String topic = "";
						switch(gather.getTopic()){
						case "social" : topic ="소셜네트워크"; break;
						case "game" : topic = "게임"; break;
						case "travel": topic = "여행"; break;
						case "finance": topic = "금융"; break;
						case "ecommerce": topic = "이커머스"; break;
						case "Planning": topic = "기획"; break;
						case "Design": topic = "디자인"; break;
						case "Frontend": topic = "프론트엔드"; break;
						case "Backend": topic = "백엔드"; break;
						case "Interview": topic = "면접"; break;
						case "Codingtest": topic = "코딩테스트"; break;
						}
				%>	
					<div class="ps-pre"><!-- /studyView?psNo=107 -->
						<a href="<%= request.getContextPath()%><%=putUrl %><%= psNo%>">
							<img src="<%= request.getContextPath() %>/images/<%= gather.getTopic() %>.jpg" class="ps-pre__img" alt="해당 프로젝트 주제 이미지">
						</a>
						<p class="bold"><%= topic%>
						</p>
						<p class="bold"><%= gather.getTitle() %></p>
						<ul class="ps-pre__etc">
							<li> 
								<span class="heart-emoji">&#9829;</span><%= gather.getBookmark() %></li>
							<li>
								<span>&#128064;</span><%= gather.getViewcount() %></li>
							<li>모집인원 <%= gather.getRecruited_cnt() %> / <%= gather.getPeople() %></li>
						</ul>
					</div>
				</div>				
				<% 
					}
				}else{
				%>
					<div>참여한 모임이 없습니다.</div>
				<%}%>
			</div>
		</div>
		<div class="profile-row part-5">
			<div class="subtitle">찜한 프로젝트</div>
			<div class="gathering-align">
				<%if(gatheringBookmarkList != null && !gatheringBookmarkList.isEmpty()){
					for(GatheringExt gather : gatheringBookmarkList){	
						String topic = "";
						switch(gather.getTopic()){
						case "social" : topic ="소셜네트워크"; break;
						case "game" : topic = "게임"; break;
						case "travel": topic = "여행"; break;
						case "finance": topic = "금융"; break;
						case "ecommerce": topic = "이커머스"; break;
						}
						if(gather.getPsType() == GatheringType.P){
					%>	    	
						<div class="ps-pre">
						<a href="<%= request.getContextPath()%>/gathering/projectView?psNo=<%= gather.getPsNo() %>">
							<img src="<%= request.getContextPath() %>/images/<%= gather.getTopic() %>.jpg" class="ps-pre__img" alt="해당 프로젝트 주제 이미지">
						</a>
							<p class="bold"><%= topic %></p>
							<p class="bold"><%= gather.getTitle() %></p>
							<ul class="ps-pre__etc">
								<li> 
									<span class="heart-emoji">&#9829;</span><%= gather.getBookmark() %></li>
								<li>
									<span>&#128064;</span><%= gather.getViewcount() %></li>
								<li>모집인원 <%= gather.getRecruited_cnt() %> / <%= gather.getPeople() %></li>
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
						for(GatheringExt gather : gatheringBookmarkList){
							String topic = "";
							switch(gather.getTopic()){
							case "Planning": topic = "기획"; break;
							case "Design": topic = "디자인"; break;
							case "Frontend": topic = "프론트엔드"; break;
							case "Backend": topic = "백엔드"; break;
							case "Interview": topic = "면접"; break;
							case "Codingtest": topic = "코딩테스트"; break;
							}
							if(gather.getPsType() == GatheringType.S){
						%>	 
						<div class="ps-pre">
							<a href="<%= request.getContextPath()%>/gathering/studyView?psNo=<%= gather.getPsNo() %>">
								<img src="<%= request.getContextPath() %>/images/<%= gather.getTopic() %>.jpg" class="ps-pre__img" alt="해당 프로젝트 주제 이미지">
							</a>
							<p class="bold"><%= topic %></p>
							<p class="bold"><%= gather.getTitle() %></p>
							<ul class="ps-pre__etc">
								<li> 
									<span class="heart-emoji">&#9829;</span><%= gather.getBookmark() %></li>
								<li>
									<span>&#128064;</span><%= gather.getViewcount() %></li>
								<li>모집인원 <%= gather.getRecruited_cnt() %> / <%= gather.getPeople() %></li>
							</ul>							
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
<% if(loginMember != null){ %>
<form
	action="<%= request.getContextPath() %>/membus/bookmarkAdd" id="tt" method="POST" name="addBookmarkFrm">
	<input type="hidden" name="psNo" id="addBookMark"/>
	<input type="hidden" name="member_id" value="<%= loginMember.getMemberId() %>" />
</form>
<form
	action="<%= request.getContextPath() %>/membus/bookmarkDel" method="POST" name="delBookmarkFrm">
	<input type="hidden" name="psNo" id="delBookmark"/>
	<input type="hidden" name="member_id" value="<%= loginMember.getMemberId() %>" />
</form>
<%
}
%>
<script>
document.querySelectorAll(".ps__bookmark").forEach((bookmark) => {
	bookmark.addEventListener('click', (e) => {
		let mark = e.target;
		const frmAdd = document.addBookmarkFrm;
		const frmDel = document.delBookmarkFrm;
		let psnum = mark.value;
		// console.log(psnum); // 확인용

		if(mark.classList.contains("bookmark-front")) {
			mark.style.display = 'none';
			console.log(mark.nextElementSibling);
			mark.nextElementSibling.style.display = 'block';
			
			const addBookPs = document.querySelector("#addBookPs");
			addBookPs.value = psnum;
			frmAdd.submit();			
		} else {
			mark.style.display = 'none';
			mark.nextElementSibling.style.display = 'block';
			const delBookPs = document.querySelector("#delBookPs");
			delBookPs.value = psnum;
			frmDel.submit();
		}
	})
});

</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>