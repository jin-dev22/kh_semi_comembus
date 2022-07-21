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
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/member/memberEnroll.css" />
<%
	MemberExt member = (MemberExt) loginMember;
	String introduction = member.getIntroduction();
	String jobCode = member.getJobCode().name();
	List<Community> communityList = (List<Community>) request.getAttribute("communityList");
	List<Gathering> gatheringIngList = (List<Gathering>) request.getAttribute("gatheringIngList");
	List<Gathering> gatheringBookmarkList = (List<Gathering>) request.getAttribute("gatheringBookmarkList");
	List<Gathering> gatheringApldList = (List<Gathering>) request.getAttribute("gatheringApldList");
%>

<section id="membus-profile">
	<form name="profileFrm" action="<%=request.getContextPath()%>/membus/mypage/update" method="POST">
		<div class="profile-row part-1 ">
			<div class="nickname-badge"><%= member.getNickName().charAt(0)%></div>
			<div>
				<div>
				 <span class="memberName">이름 : </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=member.getMemberName() %>
				</div>
				<div>
					<label for="nickName">닉네임 :</label> &nbsp;&nbsp;
					<input type="text" name="nickName" value="<%=member.getNickName() %>" maxlength="15" required/>
					<input type="hidden" name="nickNameVal" />
				</div>
		        <div id="nicknameGuideArea">
         			<div id="nicknameGuideLine">
			            <span></span>
			            <span></span>
	          		</div>
		        </div>
			        <div id="nicknameCheckArea">
			          <div id="nicknameCheck">
			            <span></span>
			            <span></span>
		          	</div>
		        </div>
				<div><label for="jobCode">직무분야 : </label> 
					<!-- <select id="search-jobCode" onchange="changeSelected('searchJobcode', this.value)"> -->
					<select id="jobCode" name="jobCode">
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
			<textarea name="introduction" class="member-introduction"><%=introduction != null? introduction : "작성하신 내용이 없습니다. 자기소개를 작성해주세요!"%></textarea>
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
	<input type="submit" value="업데이트"/>
	<input type="button" value="비밀번호 변경" onclick="updatePassword();"/>
	<input type="button" onclick="deleteMember();" value="탈퇴"/>
</form>
</section>
<!-- 지원신청 취소 폼 -->
<form name="apldCancelFrm" action="<%= request.getContextPath()%>/gathering/apply/cancel" method="POST">
	<input type="hidden" name="psNo"/>
	<input type="hidden" name="memberId" value="<%= loginMember.getMemberId()%>" />
	<input type="hidden" name="nickName" value="<%= loginMember.getNickName()%>"/>
</form>
<!-- 탈퇴 폼 -->
<form action="memberQuitFrm" action="<%= request.getContextPath()%>/membus/quit">
	<input type="hidden" name="memberId" value="<%= loginMember.getMemberId()%>" />
</form>
<script>
	/**
	* 엔터키 폼 제출방지하기
	*/
	document.addEventListener('keydown', function(event) {
	  if (event.keyCode === 13) {
	    event.preventDefault();
	  };
	}, true);
	
	function deleteMember(){
		if(confirm("정말 탈퇴하시겠습니까?")){
			document.memberQuitFrm.submit();
		}	
	}
	
	function cancelApld(psNo){
		if(confirm("지원취소된 모임은 다시 지원하실 수 없습니다. 지원을 취소하시겠습니까?")){
			const frm = document.apldCancelFrm
			frm.psNo.value = psNo;
			frm.submit();
		}
	}
	
	//닉네임 유효성 검사
	document.profileFrm.nickName.addEventListener("input", (e) => {
		  nicknameGuideArea.className = "";
		  nicknameCheckArea.className = "hide";

		  const val = e.target.value;
		  const regExp1 = /^[가-힣\d]{3,10}$/;
		  const regExp2 = /[가-힣]+/;
		  const regExp3 = /[\d]*/;

		  if (!(regExp1.test(val) && regExp2.test(val) && regExp3.test(val))) {
		    showValidationResult(
		      nicknameGuideLine,
		      "fail",
		      "한글(필수), 숫자(선택) 조합 (3~10자). 특수문자 사용 불가"
		    );
		    inputStyle(e.target, "red");
		  } else {
		    showValidationResult(
		      nicknameGuideLine,
		      "success",
		      "한글(필수), 숫자(선택) 조합 (3~10자). 특수문자 사용 불가"
		    );
		    inputStyle(e.target, "blue");
		  }

		});
	// 닉네임 중복검사
	document.profileFrm.nickName.addEventListener('blur', (e) => {
		// 닉네임 유효성검사가 완료된 후, 닉네임 중복 여부 확인
		const nicknameGuideLine = document.getElementById("nicknameGuideLine");
		
		if (nicknameGuideLine.className === "success") {
			nicknameGuideArea.className = "hide"; // 유효성검사 가이드 숨기기
			const nickname = e.target.value;

			$.ajax({
				url: '<%= request.getContextPath() %>/membus/checkNicknameDuplicate',
				data: {nickname},
				success(available){
					if(available){
						// console.log("not중복닉네임");
						nicknameCheckArea.className = "";
						showValidationResult(nicknameCheck, "success", "사용 가능한 닉네임입니다.");
						inputStyle(e.target, "blue");
					}
					else{
						// console.log("중복닉네임");
						nicknameCheckArea.className = "";
						showValidationResult(nicknameCheck, "fail", "이미 존재하는 닉네임입니다.");
						inputStyle(e.target, "red");
					}
				},
				error: console.log
			});
		}	
	});
	
	/**
	 * 유효성 검사 결과 출력하는 함수
	 */
	const showValidationResult = (input, result, msg) => {
	  if (result === "fail") {
	    input.firstElementChild.innerHTML = "&#10060";
	  } else {
	    input.firstElementChild.innerHTML = "&#9989";
	  }
	  input.className = result;
	  input.lastElementChild.innerHTML = msg;
	  input.style.fontSize="13px";
	};
	
	/**
	 * 유효성 검사 통과 여부에 따라 input태그 색상 변경하는 함수
	 */
	const inputStyle = (input, color) => {
	  input.style.borderBottom = `2px solid ${color}`;  
	};
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>