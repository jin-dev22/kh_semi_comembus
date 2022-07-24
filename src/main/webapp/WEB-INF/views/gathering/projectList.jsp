<%@page import="kh.semi.comembus.gathering.model.dto.GatheringExt"%>
<%@page import="kh.semi.comembus.gathering.model.dto.Gathering"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/gathering/gatheringList.css">  
<link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css"/>
<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
<script defer src="<%=request.getContextPath() %>/js/gathering/gathering.js"></script>
<script src="<%= request.getContextPath() %>/js/jquery-3.6.0.js"></script>
<%
	List<Gathering> projectList = (List<Gathering>) request.getAttribute("projectList");
	List<Gathering> bookmarkList = (List<Gathering>) request.getAttribute("bookmarkList");
	List<Gathering> projectSlideList = (List<Gathering>) request.getAttribute("projectSlideList");
	String type = request.getParameter("searchType");
	String keyword = request.getParameter("searchKeyword");
%>
<script>

const bookmarkFilter = (num) => {
	$("#p__local").val("All").prop("selected", true);
	$("#p__job_code").val("All").prop("selected", true);
	$("#p__status").prop("checked", false);
	
	const bookmarkYN = $("#p__bookmark").is(':checked') ? "Y" : "All";
	let memberId = "";
	<% if(loginMember == null){ %>
		alert("로그인 후 이용해주세요");
		$("#p__bookmark").prop('checked', false);
		return;
	<%	} %>
	<% if(loginMember != null){ %>
		memberId = '<%= loginMember.getMemberId() %>';
	<%
		}	
	%>
	let cPage = num;
	const numPerPage = 12;
	let totalPages = 0;
	
	$.ajax({
		url: '<%= request.getContextPath() %>/gathering/searchProBookmark',
		data: {
			cPage: cPage,
			bookmarkYN: bookmarkYN,
			memberId: memberId
			},
		success(bookmarkFilterLists){
			const {bookmarkList, projectList, totalContent, cPage} = bookmarkFilterLists;
 				
				if(bookmarkList == null){
					alert("찜한 프로젝트가 존재하지 않습니다.");
					location.reload();
					return;
				}
				if(projectList == ""){
					document.querySelector(".ps-lists").innerHTML =
						bookmarkList.reduce((html, bookmarkPro, index) => {
							const {psNo, title, viewcount, bookmark, topic, recruited_cnt, people} = bookmarkPro;
							const bookmarkCnt = bookmark < 0 ? 0 : bookmark;
							
							return `\${html}
							<div class="ps-pre">
								<a href="<%= request.getContextPath()%>/gathering/projectView?psNo=\${psNo}">
									<img src="<%= request.getContextPath() %>/images/\${topic}.jpg" class="ps-pre__img" alt="해당 프로젝트 주제 이미지">
								</a>
								<p class="bold">\${topic === 'social' ? '소셜네트워크' : (topic === 'game' ? '게임' : (topic === 'travel' ? '여행' : (topic === 'finance' ? '금융' : '이커머스')))}</p>
								<p class="bold ps-title">\${title}</p>
								<ul class="ps-pre__etc">
									<li>
										<span class="heart-emoji">&#9829;</span>\${bookmarkCnt}
									</li>
									<li>모집인원 \${recruited_cnt} / \${people}</li>
								</ul>
								<div class="ps__bookmark">
									<button class='bookmark-back' value='\${psNo}'>♥</button>
									<button style='display:none' class='bookmark-front' value='\${psNo}'>♡</button>
								</div>
							</div>
							`;
						}, "");
				}
				else {
					document.querySelector(".ps-lists").innerHTML =
						projectList.reduce((html, projectListAll, index) => {
							const {psNo, title, viewcount, bookmark, topic, recruited_cnt, people} = projectListAll;
							const bookmarkCnt = bookmark < 0 ? 0 : bookmark;
							
							
							let tagFront = "";
							let tagBack = "";
							outer:
							for(let i = 0; i < bookmarkList.length; i++){
								if(psNo == bookmarkList[i].psNo){
									tagBack = `<button class='bookmark-back' value='\${psNo}'>♥</button>`;
									tagFront = `<button style='display:none' class='bookmark-front' value='\${psNo}'>♡</button>`;
									break outer;
								} else {
									tagBack = `<button style='display:none' class='bookmark-back' value='\${psNo}'>♥</button>`;
									tagFront = `<button class='bookmark-front' value='\${psNo}'>♡</button>`;
								}
							};
							
							return `\${html}
							<div class="ps-pre">
								<a href="<%= request.getContextPath()%>/gathering/projectView?psNo=\${psNo}">
									<img src="<%= request.getContextPath() %>/images/\${topic}.jpg" class="ps-pre__img" alt="해당 프로젝트 주제 이미지">
								</a>
								<p class="bold">\${topic === 'social' ? '소셜네트워크' : (topic === 'game' ? '게임' : (topic === 'travel' ? '여행' : (topic === 'finance' ? '금융' : '이커머스')))}</p>
								<p class="bold ps-title">\${title}</p>
								<ul class="ps-pre__etc">
									<li>
										<span class="heart-emoji">&#9829;</span>\${bookmarkCnt}
									</li>
									<li>모집인원 \${recruited_cnt} / \${people}</li>
								</ul>
								<div class="ps__bookmark">
									\${tagBack}
									\${tagFront}
								</div>
							</div>
							`;
						}, "");
				}
			
			if(totalContent != 0){
				totalPages = Math.ceil(totalContent / numPerPage);
				// pageLink(현재페이지, 전체페이지, 호출할 함수 이름)
				let htmlStr = pageLink(cPage, totalPages, "bookmarkFilter");
				$("#pagebar").html("");
				$("#pagebar").html(htmlStr);
			} else {
				
			}
		},
		error: console.log
	});
}; 

const gatheringFilter = (num) => {
	$("#p__bookmark").prop('checked', false);
	
	const localAll = $("#p__local").val();
	const jobAll = $("#p__job_code").val();
	const statusYN = $("#p__status").is(':checked') ? "N" : "All";
	let memberId = "";
<% if(loginMember != null){ %>
	memberId = '<%= loginMember.getMemberId() %>';
<%
	}
%>
	let cPage = num;
	const numPerPage = 12;
	let totalPages = 0;
	
	console.log(">> localAll ", localAll);
	console.log(">> jobAll ", jobAll);
	console.log(">> statusYN ", statusYN);
	
	let searchLocal = 'local';
	let searchJobcode = 'jobcode';
	let selectLocalKeyword = localAll;
	let selectJobKeyword = jobAll;

	$.ajax({
		url: '<%= request.getContextPath() %>/gathering/searchProFilter',
		data: {
			cPage: cPage,
			searchLocal: searchLocal,
			searchJobcode: searchJobcode,
			selectLocalKeyword: selectLocalKeyword,
			selectJobKeyword: selectJobKeyword,
			statusYN : statusYN,
			memberId: memberId
			},
		success(projectSelectLists){
			const {projectList, totalContent, cPage, bookmarkList} = projectSelectLists;
			
			document.querySelector(".ps-lists").innerHTML =
				// 프로젝트 필터링
				projectList.reduce((html, selectList, index) => {
					const {psNo, title, viewcount, bookmark, topic, recruited_cnt, people} = selectList;
					const bookmarkCnt = bookmark < 0 ? 0 : bookmark;
					let tagFront = "";
					let tagBack = "";
					
					outer:
	 				for(let i = 0; i < bookmarkList.length; i++){
	 					if(psNo == bookmarkList[i].psNo){
	 						tagBack = `<button class='bookmark-back' value='\${psNo}'>♥</button>`;
	 						tagFront = `<button style='display:none' class='bookmark-front' value='\${psNo}'>♡</button>`;
	 						break outer;
	 					} else {
	 						tagBack = `<button style='display:none' class='bookmark-back' value='\${psNo}'>♥</button>`;
	 						tagFront = `<button class='bookmark-front' value='\${psNo}'>♡</button>`;
	 					}
					};
					return `\${html}
					<div class="ps-pre">
						<a href="<%= request.getContextPath()%>/gathering/projectView?psNo=\${psNo}">
							<img src="<%= request.getContextPath() %>/images/\${topic}.jpg" class="ps-pre__img" alt="해당 프로젝트 주제 이미지">
						</a>
						<p class="bold">\${topic === 'social' ? '소셜네트워크' : (topic === 'game' ? '게임' : (topic === 'travel' ? '여행' : (topic === 'finance' ? '금융' : '이커머스')))}</p>
						<p class="bold ps-title">\${title}</p>
						<ul class="ps-pre__etc">
							<li>
								<span class="heart-emoji">&#9829;</span>\${bookmarkCnt}
							</li>
							<li>모집인원 \${recruited_cnt} / \${people}</li>
						</ul>
						<div class="ps__bookmark">
						<% if(loginMember == null){ %>
							<button class="bookmark-front" value="\${psNo}">♡</button>
						<% } %>
						<% if(loginMember != null){ %>
							\${tagBack}
							\${tagFront}
						<%
						}
						%>
						</div>
					</div>
					`;
				}, '');

			if(totalContent != 0){
				totalPages = Math.ceil(totalContent / numPerPage);
				// pageLink(현재페이지, 전체페이지, 호출할 함수 이름)
				let htmlStr = pageLink(cPage, totalPages, "gatheringFilter");
				$("#pagebar").html("");
				$("#pagebar").html(htmlStr);
			} else {
				alert("해당 프로젝트가 존재하지 않습니다.");
			}
		},
		error: console.log
	});
};

function pageLink(cPage, totalPages, funName){
	cPage = Number(cPage);
	totalPages = Number(totalPages);
	let pagebarTag = "";
	const pagebarSize = 5;
	let pagebarStart = (Math.floor((cPage - 1) / pagebarSize) * pagebarSize) + 1;
	let pagebarEnd = pagebarStart + pagebarSize - 1;
	let pageNo = pagebarStart;
	
	// 이전영역
	if(pageNo == 1) {
		
	}
	else {
		pagebarTag += "<a href='javascript:" + funName + "(" + (pageNo - 1) + ");'>이전</a>\n";
	}
	// pageNo영역
	while(pageNo <= pagebarEnd && pageNo <= totalPages) {
		// 현재페이지
		if(pageNo == cPage) {
			pagebarTag += "<span class='cPage'>" + pageNo + "</span>\n";
		}
		// 현재페이지가 아닌 경우
		else {
			pagebarTag += "<a href='javascript:" + funName + "(" + pageNo + ");'>" + pageNo + "</a>\n";
		}
		pageNo++;
	}
	// 다음영역
	if(pageNo > totalPages) {}
	else {
		pagebarTag += "<a href='javascript:" + funName + "(" + pageNo + ")'>다음</a>\n";
	}
	return pagebarTag;
};
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
				<p> 신규 프로젝트 👨‍💻</p>
			</div>
			<hr>
			<div class="ps__header__content swiper">
				<div class="swiper-wrapper">
				<%
				if(projectSlideList != null && !projectSlideList.isEmpty()){
					for(Gathering _proslide : projectSlideList){
						GatheringExt proslide = (GatheringExt) _proslide;
						String topic = proslide.getTopic();
				%>
				<div class="swiper-slide">
					<a href="<%= request.getContextPath()%>/gathering/projectView?psNo=<%= proslide.getPsNo()%>">
						<img src="<%= request.getContextPath() %>/images/<%= topic %>.jpg" class="ps__header__content__img" alt="해당 프로젝트 주제 이미지">
					</a>
					<ul class="ps__header__content-info">
						<li><p class="bold"><%= "social".equals(topic) ? "소셜네트워크" : ("game".equals(topic) ? "게임" : ("travel".equals(topic) ? "여행" : ("finance".equals(topic) ? "금융" : "이커머스"))) %></p></li>
						<li><a href="<%= request.getContextPath()%>/gathering/projectView?psNo=<%= proslide.getPsNo()%>" class="bold"><%= proslide.getTitle() %></a></li>
						<li class="ps__header__content-content"><p><%= proslide.getContent() %></p></li>
						<li class="bold">
							<span class="heart-emoji">&#9829; <%= proslide.getBookmark() < 0 ? 0 : proslide.getBookmark() %></span>
							<span>모집인원 <%= proslide.getRecruited_cnt() %> / <%= proslide.getPeople() %></span>
						</li>
					</ul>
				</div>
				<%
					}
				}
				%>
				</div>

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
					<select name="searchType" value="local" id="p__local" class="ps-filter" onchange="gatheringFilter()">
						<option value="All">지역 미지정</option>
						<option value="Online">온라인</option>
						<option value="Capital">수도권</option>
						<option value="Chungcheong">충청도</option>
						<option value="Gangwon">강원도</option>
						<option value="Jeolla">전라도</option>
						<option value="Gyeongsang">경상도</option>
						<option value="Jeju">제주</option>
					</select>
				</form>
				<form name="searchFrm">
					<select name="searchType" value="jobcode" id="p__job_code" class="ps-filter" onchange="gatheringFilter()">
						<option value="All">직무 미지정</option>
						<option value="PL">기획</option>
						<option value="DG">디자인</option>
						<option value="FE">프론트</option>
						<option value="BE">백엔드</option>
					</select>
				</form>
				<div class="ps-filter">
					<input type="checkbox" id="p__status" name="searchType" onchange="gatheringFilter()">
					<label for="p__status">모집중</label>
				</div>
				<div class="ps-filter">
					<input type="checkbox" id="p__bookmark" name="searchType" onchange="bookmarkFilter()">
					<label for="p__bookmark">찜한 프로젝트</label>
				</div>
				
				<input type="button" class="ps__enroll btn" onclick="projectEnroll();" value="프로젝트 생성">
				<script>
				const projectEnroll = () => {
					if(<%= loginMember == null %>){
						alert('프로젝트 생성은 로그인 후 이용 가능합니다.');	
					}
					else{
						location.href='<%= request.getContextPath()%>/gathering/projectEnrollView';						
					}
				}
				</script>
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
							<span class="heart-emoji">&#9829;</span><%= project.getBookmark() < 0 ? 0 : project.getBookmark() %>
						</li>
						<li class="hoverList">
							<span>모집인원 <%= project.getRecruited_cnt() %> / <%= project.getPeople() %></span>
						</li>
					</ul>
					<div class="ps__bookmark">
					<% if(loginMember == null) { %>
						<button "disabled" class="bookmark-front">♡</button>
					<%
					} else {
						String tagBack = "<button style='display:none' class='bookmark-back' value='" + projectNo + "'>♥</button>";
						String tagFront = "<button class='bookmark-front' value='" + projectNo + "'>♡</button>";
						
						if(bookmarkList != null && !bookmarkList.isEmpty()){
							outer:
							for(int i = 0; i < bookmarkList.size(); i++){
								int bookPsNo = bookmarkList.get(i).getPsNo();
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
			</div>
			<div id="pagebar">
				<%= request.getAttribute("pagebar") %>
			</div>
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
		</section>
	</section>
<script>

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
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>