<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="kh.semi.comembus.gathering.model.dto.Gathering"%>
<%@page import="kh.semi.comembus.gathering.model.dto.GatheringExt"%>
<%@page import="kh.semi.comembus.member.model.dto.Member"%>
<%@page import="kh.semi.comembus.member.model.dto.MemberExt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
/* Gathering gathering = (Gathering) request.getAttribute("project"); */
GatheringExt gathering = (GatheringExt) request.getAttribute("study");
List<Integer> apldPsNoList = loginMember != null? (List<Integer>) session.getAttribute("apldPsNoList") : null;
%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/gathering/GatheringView.css" />
<div id="container">
<p class="name"><%=gathering.getTitle()%></p>
<!-- 스터디명 -->
<p class="writer">
		<span class="h__profile-badge">
	  		<b><%= gathering.getWriter().charAt(0) %></b>
	  	</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  	<%= gathering.getWriter() %>
	</p>
<br/>
<!--지원자 현황은 글쓴이=로그인한 사용자 일치할 때만 보이게 하기-->
<button id="detail">
	<a href="#">모임 상세</a>
</button>
<%
if (loginMember != null && gathering.getWriter().equals(loginMember.getMemberId())) {
%>
<button id="statue">
	<a
		href="<%=request.getContextPath()%>/gathering/showApplicants?psNo=<%=gathering.getPsNo()%>">지원자 현황</a>
</button>
<%
}
%>
<br>
<hr>
<h3>모집 현황</h3>
<table>
	<tr>
		<td>총 인원</td>
		<td><span id="statue"><%=gathering.getRecruited_cnt()%></span>/<span
			id="total"><%=gathering.getPeople()%></span></td>
	</tr>
	<tr>
	<%
 	String isPrevented = "default";

	if(loginMember == null){
		isPrevented = "guest";
	}
	else if(!apldPsNoList.isEmpty() && apldPsNoList.indexOf(gathering.getPsNo()) > 0){
		isPrevented = "true";
	}
	else if(apldPsNoList.isEmpty() || apldPsNoList.indexOf(gathering.getPsNo()) < 0){
		isPrevented = "false";
	}
 
%>
		<td><input type="button" id="apply" value="지원하기"
			onclick="applyStatus('<%=isPrevented%>')"></td>
	</tr>
</table>
<form name="applFrm" 
	action="<%=request.getContextPath()%>/gathering/apply" method="POST">
	<input type="hidden" name="psNo" value="<%= gathering.getPsNo() %>" /> 
	<input type="hidden" name="aplcntId" value="<%=loginMember != null ? loginMember.getMemberId() : ""%>" />
	<input type="hidden" name="psType" value="<%=gathering.getPsType()%>" />
</form>
<script>
function applyStatus(isPrev) {
	const frm = document.applFrm;
	console.log("isPrev=",isPrev);
	switch(isPrev){
	case "true": alert("이미 지원신청한 모임입니다."); break;
	case "false": if (confirm("지원 하시겠습니까?")) {frm.submit();} break; 
	default: alert("로그인이 필요한 기능입니다.");
	} 
}
</script>


<h3>스터디 주제</h3>
<h5><%=gathering.getTopic()%></h5>

<h3>스터디 진행지역</h3>
<h5><%=gathering.getLocal()%></h5>

<h3>스터디 설명</h3>
<p><%=gathering.getContent()%></p>
<br>
<br>
<br>
<hr>

<br>
<br>
<br>
<br>
<%--찜하기 속성 제출 --%>
<form name="bmFrm"
	action="<%=request.getContextPath()%>/membus/bookmarkAdd"
	method="POST">
	<input type="hidden" name="BmId" /> <input type="hidden" name="psNo"
		value="<%=gathering.getPsNo()%>" />
</form>
<!--로그인 했을 경우+작성자일 경우에만 되도록 설정하기-->
<%
if (loginMember != null && gathering.getWriter().equals(loginMember.getMemberId())) {
%>
<div id="editDel">
<input type="button" value="수정" class="submitEdit" onclick="updateStudy()">
<input type="button" value="삭제" class="submitDel" onclick="deleteStudy()">
</div>
<%
}
%>
</body>
<script>

	const applyStatue = document.querySelector('#statue');
	const applyTotal = document.querySelector('#total');
	if (applyStatue == applyTotal) {
		const target = document.getElementById('apply');
		target.disabled = true;
		//처음부터 지원이 불가능한 경우 작성하기
	}
	
</script>
<%if(loginMember != null && gathering.getWriter().equals(loginMember.getMemberId())){ %>
<form action="<%= request.getContextPath()%>/gathering/studyDelete"
		method="post" name="studyDelFrm">
		<input type="hidden" name="psNo" value="<%= gathering.getPsNo() %>" />
</form>
</div>
<script>
const updateStudy=()=>{
	location.href="<%=request.getContextPath()%>/gathering/studyUpdateView?psNo=<%=gathering.getPsNo()%>";
};
const deleteStudy=()=>{
	if(confirm("정말 스터디를 삭제하시겠습니까?")){
		document.studyDelFrm.submit();
	}
};
</script>
<% } %>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>