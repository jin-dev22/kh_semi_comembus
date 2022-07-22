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
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/gathering/ProjectView.css" />
<p class="pjname"><%= gathering.getTitle() %></p><!-- 프로젝트명 -->
<p class="pjwriter"><img src="/멤버 이미지.png" alt="멤버아이디"><%= gathering.getWriter() %></p>
<!--지원자 현황은 글쓴이=로그인한 사용자 일치할 때만 보이게 하기-->
<button id="pjdetail"><a href="/projectDetailView.jsp">프로젝트 상세</a></button><button id="pjstatue"><a href="/gathering/showApplicants?psNo=<%= psNo%>">지원자 현황</a></button>
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
        <td>
        	<form name="aplcntResultFrm<%=psNo %>" action="">
        		<input type="hidden" name="psNum" value="<%= psNo%>"/>
        		<input type="hidden" name="psType" value="<%= psType%>"/>
        		<input type="hidden" name=apldMemberId value="<%= mem.getMemberId()%>" />
        		<input class="applview-btn accept" type="button" value="수락" onclick="apldResult('O');"/>/
        		<input class="applview-btn reject" type="button" value="거절" onclick="apldResult('X');"/>
        	</form>
       	</td>
    </tr>
  <%} %>
</table>

<div id='pagebar'>
	<%= request.getAttribute("pagebar") %>
</div>

<script>
function apldResult(apldResult){
	const frm = document.querySelector('[name="aplcntResultFrm<%=psNo %>"]');
	const psNo = frm.psNum.value;
	const psType = frm.psType.value;
	const apldMemberId = frm.apldMemberId.value;
	console.log(psNo);
	$.ajax({
		type : 'POST',
		url : '<%= request.getContextPath()%>/gathering/showApplicants',
		data : {'psNo' : psNo, 'apldMemberId' : apldMemberId, 'apldResult' : apldResult, 'psType' : psType},
		success(result){
			if(result){
				console.log("지원수락 완료");
				const btns = frm.querySelectorAll(".applview-btn");
				const btnArr = [...btns];
				btnArr.forEach((e)=>{
					e.disabled = true;
				});				
			}			
		},
		error: console.log
	});
};

</script>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>