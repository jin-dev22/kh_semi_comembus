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
	GatheringExt gathering = (GatheringExt) request.getAttribute("project");
	List<MemberExt> apldMemberList = (List<MemberExt>) request.getAttribute("memberList");
	
	int psNo = gathering.getPsNo();
	
%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/gathering/ProjectView.css" />
<p class="pjname"><%= gathering.getTitle() %></p><!-- 프로젝트명 -->
<p class="pjwriter"><img src="/멤버 이미지.png" alt="멤버아이디"><%= gathering.getWriter() %></p>
<!--지원자 현황은 글쓴이=로그인한 사용자 일치할 때만 보이게 하기-->
<button id="pjdetail"><a href="/projectDetailView.jsp">프로젝트 상세</a></button><button id="pjstatue"><a href="/gathering/showApplicants?psNo=<%= gathering.getPsNo()%>">지원자 현황</a></button>
<br>
<hr>
<h3>지원자 현황</h3>
<p>한 번 수락/거절한 멤버는 변경할 수 없습니다. 신중하게 결정해주세요!</p>
<table>
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
        <td><button class="applview-btn accept" onclick="accept('<%= mem.getMemberId()%>');">수락</button>/<button class="applview-btn reject" onclick="reject('<%= mem.getMemberId()%>');">거절</button></td>
    </tr>
  <%} %>
</table>

<script>
function accept(apldMemberId){
	$.ajax({
		type : 'POST',
		url : '<%= request.getContextPath()%>/gathering/apldResult',
		data : {'psNo' : }
		
	});
};

function reject(){
	
};
</script>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>