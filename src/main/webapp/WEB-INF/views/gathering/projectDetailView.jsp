<%@page import="java.util.Map"%>
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
GatheringExt gathering = (GatheringExt) request.getAttribute("project");
List<Integer> apldPsNoList = loginMember != null? (List<Integer>) session.getAttribute("apldPsNoList") : null;
Map<String, Integer> cntsByDept = (Map<String, Integer>) request.getAttribute("cntsByDept");

%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/gathering/GatheringView.css" />
<div id="container">
<p class="name"><%=gathering.getTitle()%></p>
<!-- 프로젝트명 -->
<p class="writer">
		<span class="h__profile-badge">
	  		<b><%= gathering.getWriter().charAt(0) %></b>
	  	</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  	<%= gathering.getWriter() %>
	</p>
<br />
<!--지원자 현황은 글쓴이=로그인한 사용자 일치할 때만 보이게 하기-->
<button id="detail">
	<a href="#">프로젝트 상세</a>
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
		<td>기획</td>
		<td><span id="statue"><%=cntsByDept.containsKey("PL")? cntsByDept.get("PL") : "-" %></span>/<span id="total"><%=gathering.getPlanning_cnt()%></span></td>
	</tr>
	<tr>
		<td>디자인</td>
		<td><span id="statue"><%=cntsByDept.containsKey("DG")? cntsByDept.get("DG") : "-"%></span>/<span id="total"><%=gathering.getDesign_cnt()%></span></td>
	</tr>
	<tr>
		<td>프론트엔드</td>
		<td><span id="statue"><%=cntsByDept.containsKey("FE")? cntsByDept.get("FE") : "-"%></span>/<span id="total"><%=gathering.getFrontend_cnt()%></span></td>
	</tr>
	<tr>
		<td>백엔드</td>
		<td><span id="statue"><%=cntsByDept.containsKey("BE")? cntsByDept.get("BE") : "-"%></span>/<span id="total"><%=gathering.getBackend_cnt()%></span></td>
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
		<td colspan="2"><input type="button" id="apply" value="지원하기"
			onclick="applyStatus('<%=isPrevented%>')"></td>
	</tr>
</table>
<%--지원하기 속성 제출 --%>
<form name="applFrm"
	action="<%=request.getContextPath()%>/gathering/apply" method="POST">
	<%-- <input type="hidden" id="prevented" name="prevented" value="<%= isPrevented%>" /> --%>
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


<h3>프로젝트 주제</h3>
<h5><%=gathering.getTopic()%></h5>

<h3>프로젝트 진행지역</h3>
<h5><%=gathering.getLocal()%></h5>

<h3>프로젝트 설명</h3>
<p><%=gathering.getContent()%></p>
<br>
<br>
<br>
<hr>

<br>
<br>
<br>
<br>

<%
if (loginMember != null && gathering.getWriter().equals(loginMember.getMemberId())) {
%>
<div id="editDel">
<input type="button" class="submitEdit" value="수정" onclick="updateProject()">
<input type="button" class="submitDel" value="삭제" onclick="deleteProject()">
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
		};

</script>
<%if(loginMember != null && gathering.getWriter().equals(loginMember.getMemberId())){ %>
<form action="<%= request.getContextPath()%>/gathering/projectDelete"
		method="post" name="projectDelFrm">
		<input type="hidden" name="psNo" value="<%= gathering.getPsNo() %>" />
</form>
</div>
<script>
const updateProject=()=>{
	location.href="<%=request.getContextPath()%>/gathering/projectUpdateView?psNo=<%=gathering.getPsNo()%>";
};
const deleteProject=()=>{
	if(confirm("정말 프로젝트를 삭제하시겠습니까?")){
		document.projectDelFrm.submit();
	}
};
</script>
<% } %>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>