<%@page import="kh.semi.comembus.gathering.model.dto.GatheringExt"%>
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
	List<Gathering> proBookmarkList = (List<Gathering>) request.getAttribute("proBookmarkList");
	List<Gathering> studyList = (List<Gathering>) request.getAttribute("studyList");
	List<Gathering> stdBookmarkList = (List<Gathering>) request.getAttribute("stdBookmarkList");
	List<Member> memberList = (List<Member>) request.getAttribute("memberList");
	List<Community> sBest = (List<Community>) request.getAttribute("sBest"); 
	List<Community> flist = (List<Community>) request.getAttribute("flist"); 
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
		for(Gathering _project : projectList){
			GatheringExt project = (GatheringExt) _project;
			int projectNo = project.getPsNo();
	%>
		<div class="ps-pre">
			<a href="<%= request.getContextPath()%>/gathering/projectView?psNo=<%= projectNo %>">
				<img src="<%= request.getContextPath() %>/images/<%= project.getTopic() %>.jpg" class="ps-pre__img" alt="해당 프로젝트 주제 이미지">
			</a>
			<p class="bold"><%= "social".equals(project.getTopic()) ? "소셜네트워크" : ("game".equals(project.getTopic()) ? "게임" : ("travel".equals(project.getTopic()) ? "여행" : ("finance".equals(project.getTopic()) ? "금융" : "이커머스"))) %></p>
			<a href="<%= request.getContextPath()%>/gathering/projectView?psNo=<%= projectNo %>">
				<p class="bold ps-title"><%= project.getTitle() %></p>
			</a>
			<ul class="ps-pre__etc">
				<li> 
					<span class="heart-emoji">&#9829;</span><%= project.getBookmark() %></li>
				<li>모집인원 <%= project.getRecruited_cnt() %> / <%= project.getPeople() %></li>
			</ul>
				<div class="ps__bookmark">
				<% if(loginMember == null) { %>
					<button "disabled" class="bookmark-front" onclick="alert('로그인 후 이용해주세요');">♡</button>
				<%
				} else {
					String tagBack = "<button style='display:none' class='bookmark-back' value='" + projectNo + "'>♥</button>";
					String tagFront = "<button class='bookmark-front' value='" + projectNo + "'>♡</button>";
					
					if(proBookmarkList != null && !proBookmarkList.isEmpty()){
						outer:
						for(int i = 0; i < proBookmarkList.size(); i++){
							int bookPsNo = proBookmarkList.get(i).getPsNo();
							if(projectNo == bookPsNo){
								tagBack = "";
								tagFront = "";
								tagBack = "<button class='bookmark-back' value='" + projectNo + "'>♥</button>";
								tagFront = "<button style='display:none' class='bookmark-front' value='" + projectNo + "'>♡</button>";
								break outer;
							} else {
								tagBack = "";
								tagFront = "";
								tagBack = "<button style='display:none' class='bookmark-back' value='" + projectNo + "'>♥</button>";
								tagFront = "<button class='bookmark-front' value='" + projectNo + "'>♡</button>";
							}
						}
					}
				%>
					<%= tagBack %>
					<%= tagFront %>
				<%
				}
				%>
				</div>
		</div>
<%
	}
}
%>

<% if(loginMember != null){ %>
<form
	action="<%= request.getContextPath() %>/membus/bookmarkAdd" id="tt" method="POST" name="addBookmarkFrm">
	<input type="hidden" name="psNo" id="addBookPs"/>
	<input type="hidden" name="member_id" value="<%= loginMember.getMemberId() %>" />
</form>
<form
	action="<%= request.getContextPath() %>/membus/bookmarkDel" method="POST" name="delBookmarkFrm">
	<input type="hidden" name="psNo" id="delBookPs"/>
	<input type="hidden" name="member_id" value="<%= loginMember.getMemberId() %>" />
</form>
<%
}
%>
	</div>
</div>

<div class="preview-container">
	<div class="preview-text">
		<h3 class="container-title">스터디 미리보기</h3>
		<p class="move-page"><a href="<%= request.getContextPath()%>/gathering/studyList">전체보기</a></p>
	</div>
	
	<div class="ps-lists">
	<%
	if(studyList != null && !studyList.isEmpty()){
		for(Gathering _study : studyList){
			GatheringExt study = (GatheringExt) _study;
			int studyNo = study.getPsNo();
	%>
		<div class="ps-pre">
			<a href="<%= request.getContextPath()%>/gathering/studyView?psNo=<%= studyNo %>">
				<img src="<%= request.getContextPath() %>/images/<%= study.getTopic() %>.jpg" class="ps-pre__img" alt="해당 스터디 주제 이미지">
			</a>
			<p class="bold">
				<%= "Planning".equals(study.getTopic()) ? "기획" : ("Design".equals(study.getTopic()) ? "디자인" : ("Frontend".equals(study.getTopic()) ? "프론트엔드" : ("Backend".equals(study.getTopic()) ? "백엔드" : ("Interview".equals(study.getTopic()) ? "면접" : "코딩테스트")))) %>
			</p>
			<a href="<%= request.getContextPath()%>/gathering/studyView?psNo=<%= studyNo %>">
				<p class="bold"><%= study.getTitle() %></p>
			</a>
			<ul class="ps-pre__etc">
				<li> 
					<span class="heart-emoji">&#9829;</span><%= study.getBookmark() %></li>
				<li>모집인원 <%= study.getRecruited_cnt() %> / <%= study.getPeople() %></li>
			</ul>
				<div class="ps__bookmark">
				<% if(loginMember == null) { %>
					<button "disabled" class="bookmark-front" onclick="alert('로그인 후 이용해주세요');">♡</button>
				<%
				} else {
					String tagBack = "<button style='display:none' class='bookmark-back' value='" + studyNo + "'>♥</button>";
					String tagFront = "<button class='bookmark-front' value='" + studyNo + "'>♡</button>";
					
					if(stdBookmarkList != null && !stdBookmarkList.isEmpty()){
						outer:
						for(int i = 0; i < stdBookmarkList.size(); i++){
							int bookPsNo = stdBookmarkList.get(i).getPsNo();
							if(studyNo == bookPsNo){
								tagBack = "";
								tagFront = "";
								tagBack = "<button class='bookmark-back' value='" + studyNo + "'>♥</button>";
								tagFront = "<button style='display:none' class='bookmark-front' value='" + studyNo + "'>♡</button>";
								break outer;
							} else {
								tagBack = "";
								tagFront = "";
								tagBack = "<button style='display:none' class='bookmark-back' value='" + studyNo + "'>♥</button>";
								tagFront = "<button class='bookmark-front' value='" + studyNo + "'>♡</button>";
							}
						}
					}
				%>
					<%= tagBack %>
					<%= tagFront %>
				<%
				}
				%>
				</div>
		</div>
	<%
		}
	}
	%>
	</div>	
</div>

<script>
<% if(loginMember != null){ %>
$(document).on('click', '.bookmark-front', function(e){
	let mark = e.target;
	const frmAdd = document.addBookmarkFrm;
	let psnum = mark.value;
	mark.style.display = 'none';
	mark.previousElementSibling.style.display = 'block';
	const addBookPs = document.querySelector("#addBookPs");
	addBookPs.value = psnum;
	frmAdd.submit();
});
$(document).on('click', '.bookmark-back', function(e){
	let mark = e.target;
	const frmDel = document.delBookmarkFrm;
	let psnum = mark.value;
	mark.style.display = 'none';
	mark.nextElementSibling.style.display = 'block';
	const delBookPs = document.querySelector("#delBookPs");
	delBookPs.value = psnum;
	frmDel.submit();
});
<% } %>


<% if(loginMember != null){ %>
document.querySelectorAll(".ps__bookmark").forEach((bookmark) => {
	bookmark.addEventListener('click', (e) => {
		let mark = e.target;
		const frmAdd = document.addBookmarkFrm;
		const frmDel = document.delBookmarkFrm;
		let psnum = mark.value;

		if(mark.classList.contains("bookmark-front")) {
			mark.style.display = 'none';
			mark.previousElementSibling.style.display = 'block';
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
<% } %>

</script>

	
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
		            <div class="profile-nickNames">
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
			<% if(sBest == null || sBest.isEmpty()){ %>
			<div>조회된 게시글이 없습니다.</div>
			<% }else{ 
				for(Community c:sBest){
			%>
				<div class="co-share">
					<div class="co-share-title">
						<a href="<%= request.getContextPath() %>/community/communityView?co_type=S&no=<%= c.getCoNo() %>"><%= ComembusUtils.escapeXml(c.getCoTitle()) %></a>
					</div>
					<div class="share-best">조회수 TOP 4</div>
					<div class="co-share-info">
						<span class="co-share-writer"><%= c.getCoWriter() %></span>
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