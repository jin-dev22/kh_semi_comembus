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
<form
	name="profileFrm"
	enctype="multipart/form-data">
	<table id="tbl-membus-profileview">
		<tbody>
			<tr>
				<th><div class="nickname-badge">닉</div></th>
				<td colspan="3">
					<div>닉네임 : <%=member.getNickName() %></div>
					<div>직무분야 : <%=member.getJobName() %></div>
				</td>
			</tr>
			<tr><th>자기소개</th></tr>
			<tr>
				<td colspan="4" id="summernoteWidth">
					<div>
						<textarea id="summernote" name="editordata" readonly></textarea>
					</div>
				</td>
			</tr>
			<tr><th colspan="4">최근 작성한 게시물</th></tr>
			<tr>
			<%if(communityList != null && !communityList.isEmpty()){
				for(Community co : communityList){
			%>
			<tr class="coBoards">
				<td class="coTitle"><%= co.getCoTitle() %></td>
				<td class="coRegDate"><%= new SimpleDateFormat("yyyy-MM-dd HH:mm").format(co.getCoRegdate()) %></td>
				<td class="coNums coLike"><%= co.getCoLike() %></td>
				<td class="coNums coReadCnt"><%= co.getCoReadcount() %></td>
			</tr>
			<%  }
			}else{
			%>
			<tr>
			<td colspan="4" style="text-align: center; height: 441px; font-size: 25px;">조회된 게시글이 없습니다.</td>
			</tr>
			<%} %>
			</tr>
			<tr>
				<td><%= request.getAttribute("pagebar")%></td>
			</tr>
	    	<tr><th colspan="4">모임 참여현황</th></tr>
	        <tr>
				<td colspan="4">
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
	    	}
	    	%>
				</td>
			</tr>
	    	<tr><th colspan="4">찜한 프로젝트</th></tr>
			<tr>
	            <td colspan="4">
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
	    	}
	    	%>
				</td>
	        </tr>
			<tr><th colspan="4">찜한 스터디</th></tr>
		    <tr>
				<td colspan="4">
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
			<% 
	    			}
	    		}
	    	}
	    	%>
				</td>
			</tr>
		</tbody>
	</table>
</form>
<script>
    $(document).ready(function() {
        var setting = {
			//placeholder: '<strong>1. 프로젝트의 시작 동기</strong> <br> - 이 서비스를 만들고 싶은 이유 <br> (ex. 기존에 존재하는 배달 시스템에 불만이 있어 보다 효율적인 앱을 만들고 싶습니다.) <br> - 어떤 사용자를 목적으로 하는지 써주세요. <br> (ex - 혼자사는 1인가구를 목적으로 하는 배달 어플 서비스) <br><br> <strong> 2. 프로젝트의 진행방식</strong> <br> - 1주일에 며칠 진행할 예정인가요? <br>(ex - 1주일에 1,2회 멤버 모이면 상의 후 결정) <br>- 온/오프라인 회의시 진행 방식과 진행 도구를 말해주세요. <br>(ex - 온라인, 디스코드(화면 공유 얼굴 비침 필수)) <br> <br> <strong>3. 사용기술</strong> <br>(ex - html, css, js, JAVA, Spring, Git)<br><br> <strong>4. 출시 플랫폼</strong><br>(ex - web, Android) <br><br> <strong>5. 기타 자유내용</strong> <br>(ex - 상업적인 부분은 기획자가 담당합니다.)',
			height : 300,
			width : 600,
			lang : 'ko-KR',
			toolbar : toolbar,
			callbacks : { //여기 부분이 이미지를 첨부하는 부분
			/* onImageUpload : function(files, editor,
				welEditable) {
					for (var i = files.length - 1; i >= 0; i--) {
						uploadSummernoteImageFile(files[i], this);
					}
				} */
			}
		};
		$('#summernote').summernote(setting);
		$('#summernote').summernote('insertText', '<%= introduction%>');
		$('#summernote').summernote('disable');
	});
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>