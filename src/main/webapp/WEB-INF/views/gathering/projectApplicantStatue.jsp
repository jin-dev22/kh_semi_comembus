<%@page import="kh.semi.comembus.gathering.model.dto.GatheringType"%>
<%@page import="java.util.Map"%>
<%@page import="kh.semi.comembus.member.model.dto.MemberExt"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="kh.semi.comembus.gathering.model.dto.Gathering"%>
<%@page import="kh.semi.comembus.gathering.model.dto.GatheringExt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	/* Gathering gathering = (Gathering) request.getAttribute("project"); */
	GatheringExt gathering = (GatheringExt) request.getAttribute("gathering");
	List<MemberExt> apldMemberList = (List<MemberExt>) request.getAttribute("memberList");
	int psNo = gathering.getPsNo();
	String psType = gathering.getPsType().name();
%>
<%-- <link rel="stylesheet" href="<%=request.getContextPath() %>/css/gathering/ProjectView.css" /> --%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/gathering/GatheringView.css" />
<div id="container">
<p class="name"><%= gathering.getTitle() %></p><!-- 프로젝트명 -->
<p class="writer">
	<span class="h__profile-badge">
	  		<b><%= gathering.getWriter().charAt(0) %></b>
	 </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<%= gathering.getWriter() %>
</p>
<!--지원자 현황은 글쓴이=로그인한 사용자 일치할 때만 보이게 하기-->
<%String putUrl = gathering.getPsType() == GatheringType.P ? "/gathering/projectView?psNo=" : "/gathering/studyView?psNo="; %>
<button id="statue"><a href="<%= request.getContextPath()%><%=putUrl %><%= psNo%>">모임 상세</a></button>
<button id="detail"><a href="#">지원자 현황</a></button>
<br>
<hr>
<h3>지원자 현황</h3>
<p>한 번 수락/거절한 멤버는 변경할 수 없습니다. 신중하게 결정해주세요!</p>
<table id="aplcntList">
<!-- memberExt로 가져와서 보여주기.  -->
	<tr>
		<th>닉네임</th>
		<th>직무분야</th>
		<th>수락/거절하기</th>
	</tr>
<% for(MemberExt mem : apldMemberList){ %>
    <tr>
        <td><%= mem.getNickName() %></td>
        <td><%= mem.getJobName() %></td>
        <td>
			<input class="applview-btn btn-accept" type="button" value="수락" onclick="apldResult('O', '<%=mem.getMemberId()%>', '<%=mem.getJobCode()%>');"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input class="applview-btn btn-reject" type="button" value="거절" onclick="apldResult('X', '<%=mem.getMemberId()%>','<%=mem.getJobCode()%>');"/>
       	</td>
    </tr>
  <%} %>
</table>
<form name="aplcntResultFrm" action="<%=request.getContextPath()%>/gathering/showApplicants" method="POST">
	<input type="hidden" name="psNum" value="<%= psNo%>" />
	<input type="hidden" name="psType" value="<%= psType%>"/>
	<input type="hidden" name="apldResult" />
	<input type="hidden" name=apldMemberId />
	<input type="hidden" name="apldMemberJobCode"/>
</form>
</div>
<div id='pagebar'>
	<%= request.getAttribute("pagebar") %>
</div>

<script>
function apldResult(apldResult, memberId, jobCode){
	const frm = document.aplcntResultFrm;
	const psNo = frm.psNum.value;
	const psType = frm.psType.value;
	frm.apldResult.value = apldResult;
	frm.apldMemberId.value = memberId;
	frm.apldMemberJobCode.value = jobCode;
	
	frm.submit();
};

</script>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>