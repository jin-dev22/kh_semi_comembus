<%@page import="kh.semi.comembus.common.ComembusUtils"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="kh.semi.comembus.community.model.dto.Community"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/community.css" />
<%
	List<Community> qlist = (List<Community>) request.getAttribute("qlist"); 
	String type = request.getParameter("searchType");
	String kw = request.getParameter("searchKeyword");
%>
	<h2>Q&A 게시판💁‍♀️</h2>
	<h4>질문과 답변을 주고받을 수 있는 게시판 입니다.</h4>
<div id="boardListWrapper">

<!-- 검색 -->
<div id="titleText">
	<form>
		<input type="search" name="keyword" placeholder="제목으로 검색하기"> <button id="btn">검색</button>
	</form>
		
</div>

<br />
<br />

	
	<table id="tbl-board">
		<tr>
			<th>제목</th>
			<th>글쓴이</th>
			<th>작성일</th>
			<th>추천</th>
			<th>조회수</th>
		</tr>
		
	<%if(qlist == null || qlist.isEmpty()){%>
		<tr>
			<td colspan="6" style="text-align: center; height: 441px; font-size: 25px;">조회된 게시글이 없습니다.</td>
		</tr>
		<%}else{ 
			for(Community c:qlist){
			%>
		<tr>
			<td><a href="<%= request.getContextPath() %>/community/communityView?co_type=Q&no=<%= c.getCoNo()%>"><%= ComembusUtils.escapeXml(c.getCoTitle()) %></a></td>
			<td><%= c.getCoWriter() %></td>
			<td><%= new SimpleDateFormat("yyyy-MM-dd HH:mm").format(c.getCoRegdate()) %></td>
			<td><%= c.getCoLike() %></td>
			<td><%= c.getCoReadcount() %></td>
			
		</tr>
			<%
				}
			} 
		%>
</table>
<br />

<% if(loginMember != null) { %>
	<input type="button" value="글쓰기" id="btn-add"
	onclick="location.href='<%= request.getContextPath() %>/community/communityEnroll?co_type=Q';"/>
<% } %>

</div>
		
<div id='pagebar'>
	<%= request.getAttribute("pagebar") %>
</div>


<script>
$(document).ready(function(){
	$("#searchType").change(function(){
		var result = $("#searchType option:selected").val();
		if(result == 'boardWriter'){
			$("#search-boardWriter").css("display", "inline-block");
			$("#search-boardTitle").css("display", "none");
		}
		else if(result == 'boardTitle'){
			$("#search-boardWriter").css("display", "none");
			$("#search-boardTitle").css("display", "inline-block");
		}
	});
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>