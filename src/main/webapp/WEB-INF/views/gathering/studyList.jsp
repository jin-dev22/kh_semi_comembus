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
	List<Gathering> studyList = (List<Gathering>) request.getAttribute("studyList");
	List<Gathering> bookmarkList = (List<Gathering>) request.getAttribute("bookmarkList");
	String type = request.getParameter("searchType");
	String keyword = request.getParameter("searchKeyword");
%>
<script>
const bookmarkFilter = (num) => {
	// 체크 시 다른 필터 체크 해제처리해야함
	$("#s__local").prop('checked', false);
	$("#s__topic").prop('checked', false);
	$("#s__status").prop('checked', false);
	
	const bookmarkYN = $("#s__bookmark").is(':checked') ? "Y" : "All";
	let memberId = "";
	<% if(loginMember == null){ %>
		alert("로그인 후 이용해주세요");
		$("#s__bookmark").prop('checked', false);
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
		url: '<%= request.getContextPath() %>/gathering/searchStdBookmark',
		data: {
			cPage: cPage,
			bookmarkYN: bookmarkYN,
			memberId: memberId
			},
		success(bookmarkFilterLists){
			const {bookmarkList, studyList, totalContent, cPage} = bookmarkFilterLists;
 				console.log(">> bookmarkList = ", bookmarkList);
 				console.log(">> studyList = ", studyList);
 				console.log(">> totalContent = ", totalContent);
 				
				if(bookmarkList == null){
					alert("찜한 스터디가 존재하지 않습니다.");
					location.reload();
					return;
				}
				if(studyList == ""){
					document.querySelector(".ps-lists").innerHTML =
						bookmarkList.reduce((html, bookmarkStd, index) => {
							const {psNo, title, viewcount, bookmark, topic, recruited_cnt, people} = bookmarkStd;
							console.log("@@@bookmarkStd ", bookmarkStd);
							// console.log("html ", html);
							console.log(">>@@ 확인용", psNo, title, viewcount, bookmark, topic, recruited_cnt, people); // 확인용
							
							return `\${html}
							<div class="ps-pre">
								<a href="">
									<img src="<%= request.getContextPath() %>/images/\${topic}.jpg" class="ps-pre__img" alt="해당 스터디 주제 이미지">
								</a>
								<p class="bold">\${topic === 'Planning' ? '기획' : (topic === 'Design' ? '디자인' : (topic === 'Frontend' ? '프론트엔드' : (topic === 'Backend' ? '백엔드' : (topic === 'Interview' ? '면접' : '코딩테스트'))))}</p>
								<p class="bold ps-title">\${title}</p>
								<ul class="ps-pre__etc">
									<li>
										<span class="heart-emoji">&#9829;</span>\${bookmark}
									</li>
									<li>
										<span>&#128064;</span>\${viewcount}
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
						studyList.reduce((html, studyListAll, index) => {
							const {psNo, title, viewcount, bookmark, topic, recruited_cnt, people} = studyListAll;
							console.log("@@@bookmarkStd ", studyListAll);
							console.log(">>@@ 확인용", psNo, title, viewcount, bookmark, topic, recruited_cnt, people); // 확인용
							
							let tagFront = "";
							let tagBack = "";
							outer:
							for(let i = 0; i < bookmarkList.length; i++){
								if(psNo == bookmarkList[i].psNo){
									tagBack = "<button class='bookmark-back' value='\${psNo}'>♥</button>";
									tagFront = "<button style='display:none' class='bookmark-front' value='\${psNo}'>♡</button>";
									break outer;
								} else {
									tagBack = "<button style='display:none' class='bookmark-back' value='\${psNo}'>♥</button>";
									tagFront = "<button class='bookmark-front' value='\${psNo}'>♡</button>";
								}
							};
							
							return `\${html}
							<div class="ps-pre">
								<a href="">
									<img src="<%= request.getContextPath() %>/images/\${topic}.jpg" class="ps-pre__img" alt="해당 스터디 주제 이미지">
								</a>
								<p class="bold">\${topic === 'Planning' ? '기획' : (topic === 'Design' ? '디자인' : (topic === 'Frontend' ? '프론트엔드' : (topic === 'Backend' ? '백엔드' : (topic === 'Interview' ? '면접' : '코딩테스트'))))}</p>
								<p class="bold ps-title">\${title}</p>
								<ul class="ps-pre__etc">
									<li>
										<span class="heart-emoji">&#9829;</span>\${bookmark}
									</li>
									<li>
										<span>&#128064;</span>\${viewcount}
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
	$("#s__bookmark").prop('checked', false);
	
	const localAll = $("#s__local").val();
	const topicAll = $("#s__topic").val();
	const statusYN = $("#s__status").is(':checked') ? "N" : "All";
	let memberId = "";
<% if(loginMember != null){ %>
	memberId = '<%= loginMember.getMemberId() %>';
<%
	}
%>
	let cPage = num;
	const numPerPage = 12;
	let totalPages = 0;
	
	let searchLocal = 'local';
	let searchTopic = 'topic';
	let selectLocalKeyword = localAll;
	let selectTopicKeyword = topicAll;
	
	console.log("topicAll = ", topicAll)
	console.log("statusYN = ", statusYN); // 확인용
	console.log("memberId = ", memberId) // 확인용
	$.ajax({
		url: '<%= request.getContextPath() %>/gathering/searchStdFilter',
		data: {
			cPage: cPage,
			searchLocal: searchLocal,
			searchTopic: searchTopic,
			selectLocalKeyword: selectLocalKeyword,
			selectTopicKeyword: selectTopicKeyword,
			statusYN : statusYN,
			memberId: memberId
			},
		success(studySelectLists){
			console.log(">>> studySelectLists", studySelectLists); // 확인용
			const {studyList, totalContent, cPage, bookmarkList} = studySelectLists;
			
			document.querySelector(".ps-lists").innerHTML =
				// 스터디 필터링
				studyList.reduce((html, selectList, index) => {
					const {psNo, title, viewcount, bookmark, topic, recruited_cnt, people} = selectList;
					// bookmark 개수 쿼리문 다시 작성해야함
					console.log(">>> 확인용 ", psNo, title, viewcount, bookmark, topic, recruited_cnt, people); // 확인용
					console.log(">>> #bookmarkList", bookmarkList);
					let tagFront = "";
					let tagBack = "";
					
					outer:
	 				for(let i = 0; i < bookmarkList.length; i++){
	 					console.log(bookmarkList[i].psNo);
	 					console.log(psNo);
	 					if(psNo == bookmarkList[i].psNo){
	 						tagBack = "<button class='bookmark-back' value='\${psNo}'>♥</button>";
	 						tagFront = "<button style='display:none' class='bookmark-front' value='\${psNo}'>♡</button>";
	 						break outer;
	 					} else {
	 						tagBack = "<button style='display:none' class='bookmark-back' value='\${psNo}'>♥</button>";
	 						tagFront = "<button class='bookmark-front' value='\${psNo}'>♡</button>";
	 					}
					};
					return `\${html}
					<div class="ps-pre">
						<a href="">
							<img src="<%= request.getContextPath() %>/images/\${topic}.jpg" class="ps-pre__img" alt="해당 스터디 주제 이미지">
						</a>
						<p class="bold">\${topic === 'Planning' ? '기획' : (topic === 'Design' ? '디자인' : (topic === 'Frontend' ? '프론트엔드' : (topic === 'Backend' ? '백엔드' : (topic === 'Interview' ? '면접' : '코딩테스트'))))}</p>
						<p class="bold ps-title">\${title}</p>
						<ul class="ps-pre__etc">
							<li>
								<span class="heart-emoji">&#9829;</span>\${bookmark}
							</li>
							<li>
								<span>&#128064;</span>\${viewcount}
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
				alert("해당 스터디가 존재하지 않습니다.");
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
	console.log("cPage, totalPages, funName = ", cPage, totalPages, funName); // 확인용
	console.log("pagebarStart, pagebarEnd, pageNo = ", pagebarStart, pagebarEnd, pageNo); // 확인용
	
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
	console.log(pagebarTag);
	return pagebarTag;
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
				<p>신규 스터디</p>
				<i class="fa-solid fa-laptop-code"></i>
			</div>
			<hr>
			<div class="ps__header__content swiper">
				<div class="swiper-wrapper">
				<%
				if(studyList != null && !studyList.isEmpty()){
					for(int i = 0; i < 3; i++){
						Gathering _study = studyList.get(i);
						GatheringExt study = (GatheringExt) _study;
						String topic = study.getTopic();
				%>
				<div class="swiper-slide">
					<a href="<%= request.getContextPath()%>/gathering/studyView?psNo=<%= study.getPsNo()%>">
						<img src="<%= request.getContextPath() %>/images/<%= topic %>.jpg" class="ps__header__content__img" alt="해당 스터디 주제 이미지">
					</a>
					<ul class="ps__header__content-info">
						<li><p class="bold"><%= "Planning".equals(topic) ? "기획" : ("Design".equals(topic) ? "디자인" : ("Frontend".equals(topic) ? "프론트엔드" : ("Backend".equals(topic) ? "백엔드" : ("Interview".equals(topic) ? "면접" : "코딩테스트")))) %></p></li>
						<li><p class="bold"><%= study.getTitle() %></p></li>
						<li class="ps__header__content-content"><p><%= study.getContent() %></p></li>
						<li class="bold">
							<span class="heart-emoji">&#9829; <%= study.getBookmark() %></span>
							<span>&#128064; <%= study.getViewcount() %></span>
							<span>모집인원 <%= study.getRecruited_cnt() %> / <%= study.getPeople() %></span>
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
		<!-- 스터디List -->
		<section class="ps-list-main">
			<h1>전체 스터디</h1>
			<div class="ps-filter-container">
				<form name="searchFrm">
					<select name="searchType" value="local" id="s__local" class="ps-filter" onchange="gatheringFilter()">
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
					<select name="searchType" value="topic" id="s__topic" class="ps-filter" onchange="gatheringFilter()">
						<option value="All">직무 미지정</option>
						<option value="Planning">기획</option>
						<option value="Design">디자인</option>
						<option value="Frontend">프론트</option>
						<option value="Backend">백엔드</option>
						<option value="Interview">면접</option>
						<option value="Codingtest">코딩테스트</option>
					</select>
				</form>
				<div class="ps-filter">
					<input type="checkbox" id="s__status" name="searchType" onchange="gatheringFilter()">
					<label for="s__status">모집중</label>
				</div>
				<div class="ps-filter">
					<input type="checkbox" id="s__bookmark" name="searchType" onchange="bookmarkFilter()">
					<label for="s__bookmark">찜한 스터디</label>
				</div>
				
				<input type="button" class="ps__enroll btn" onclick="location.href='<%= request.getContextPath()%>/gathering/studyEnrollView'" value="스터디 생성">
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
						<li>
							<span>&#128064;</span><%= study.getViewcount() %></li>
						<li>모집인원 <%= study.getRecruited_cnt() %> / <%= study.getPeople() %></li>
					</ul>
					<div class="ps__bookmark">
					<% if(loginMember == null) { %>
						<button "disabled" class="bookmark-front">♡</button>
					<%
					} else {
						String tagBack = "";
						String tagFront = "";
						if(bookmarkList != null && !bookmarkList.isEmpty()){
							outer:
							for(int i = 0; i < bookmarkList.size(); i++){
								int bookPsNo = bookmarkList.get(i).getPsNo();
								if(studyNo == bookPsNo){
									tagBack = "<button class='bookmark-back' value='" + studyNo + "'>♥</button>";
									tagFront = "<button style='display:none' class='bookmark-front' value='" + studyNo + "'>♡</button>";
									break outer;
								} else {
									tagBack = "<button style='display:none' class='bookmark-back' value='" + studyNo + "'>♥</button>";
									tagFront = "<button class='bookmark-front' value='" + studyNo + "'>♡</button>";
								}
							}
					%>
							<%= tagBack %>
							<%= tagFront %>
					<%
						}
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
				action="<%= request.getContextPath() %>/membus/bookmarkAdd" method="POST" name="addBookmarkFrm">
				<input type="hidden" name="psNo" id="addBookStd"/>
				<input type="hidden" name="member_id" value="<%= loginMember.getMemberId() %>" />
			</form>
			<form
				action="<%= request.getContextPath() %>/membus/bookmarkDel" method="POST" name="delBookmarkFrm">
				<input type="hidden" name="psNo" id="delBookStd"/>
				<input type="hidden" name="member_id" value="<%= loginMember.getMemberId() %>" />
			</form>
			<%
			}
			%>
		</section>
	</section>
<script>

document.querySelectorAll(".ps__bookmark").forEach((bookmark) => {
	bookmark.addEventListener('click', (e) => {
		let mark = e.target;
		const frmAdd = document.addBookmarkFrm;
		const frmDel = document.delBookmarkFrm;
		let psnum = mark.value;

		if(mark.classList.contains("bookmark-front")) {
			mark.style.display = 'none';
			mark.previousElementSibling.style.display = 'block';
			const addBookPs = document.querySelector("#addBookStd");
			addBookPs.value = psnum;
			frmAdd.submit();			
		} else {
			mark.style.display = 'none';
			mark.nextElementSibling.style.display = 'block';
			const delBookPs = document.querySelector("#delBookStd");
			delBookPs.value = psnum;
			frmDel.submit();
		}
	})
});

</script>
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>