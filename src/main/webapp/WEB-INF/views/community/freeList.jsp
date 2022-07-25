<%@page import="kh.semi.comembus.common.ComembusUtils"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="kh.semi.comembus.community.model.dto.Community"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/community.css" />
<%
	List<Community> flist = (List<Community>) request.getAttribute("flist"); 
	String type = request.getParameter("searchType");
	String kw = request.getParameter("searchKeyword");
%>
<style>
div#search-coTitle{
	display: <%= type == null || "co_title".equals(type) ? "inline-block" : "none" %>;
}
div#search-coWriter{
	display: <%= "co_writer".equals(type) ? "inline-block" : "none" %>;
}
</style>
<section id="commu-container">
		<section class="commu-bar">
			<p><a href="<%= request.getContextPath()%>/community/communityList?co_type=Q">Q&A</a></p>
			<p><a href="<%= request.getContextPath()%>/community/communityList?co_type=F">자유주제</a></p>
			<p><a href="<%= request.getContextPath()%>/community/communityList?co_type=S">정보공유</a></p>
		</section>
	<h2>자유 게시판‍📝</h2>
	<h4>자유롭게 글을 작성할 수 있는 게시판 입니다.</h4><br /><br />
<!-- 검색 -->

	<div id="search-container">
		검색타입 : 
			<select id="searchType">
				<option value="co_title" <%= "co_title".equals(type) ? "selected" : "" %>>제목</option>
				<option value="co_writer" <%= "co_writer".equals(type) ? "selected" : "" %>>작성자</option>
			</select>
			<div id="search-coTitle">
				<form action="<%=request.getContextPath()%>/community/commuFinder?co_type=F"
					method="get"
				>
					<input type="hidden" name="searchType" value="co_title">
					<input type="text" class="searchKeyword" name="searchKeyword" placeholder="검색할 제목 입력" value="<%= "co_title".equals(type) ? kw : "" %>">
					<button id="btn" type="submit">검색</button>
				</form>
			</div>
			<div id="search-coWriter">
				<form action="<%=request.getContextPath()%>/community/commuFinder?co_type=F"
					method="get"
				>
					<input type="hidden" name="searchType" value="co_writer">
					<input type="text" class="searchKeyword" name="searchKeyword" placeholder="검색할 작성자 입력" value="<%= "co_writer".equals(type) ? kw : "" %>">
					<button id="btn" type="submit">검색</button>
				</form>
			</div>
	</div>

<br />
<br />
	<table id="tbl-board">
		<tr>
			<th>제목</th>
			<th>글쓴이</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		
	<%if(flist == null || flist.isEmpty()){%>
		<tr>
			<td colspan="6" style="text-align: center; height: 441px; border:none; font-size: 25px;">조회된 게시글이 없습니다.</td>
		</tr>
		<%}else{ 
			for(Community c:flist){
			%>
		<tr>
			<td><a href="<%= request.getContextPath() %>/community/communityView?co_type=F&no=<%= c.getCoNo()%>"><%= ComembusUtils.escapeXml(c.getCoTitle()) %></a></td>
			<td><%= c.getCoWriter() %></td>
			<td><%= new SimpleDateFormat("yyyy-MM-dd HH:mm").format(c.getCoRegdate()) %></td>
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
	onclick="location.href='<%= request.getContextPath() %>/community/communityEnroll?co_type=F';"/>
<% } %>

</div>
		
<div id='pagebar'>
	<%= request.getAttribute("pagebar") %>
</div>


<script>
$(document).ready(function(){
	$("#searchType").change(function(){
		let result = $("#searchType option:selected").val();
		if(result == 'co_writer'){
			$("#search-coWriter").css("display", "inline-block");
			$("#search-coTitle").css("display", "none");
		}
		else if(result == 'co_title'){
			$("#search-coWriter").css("display", "none");
			$("#search-coTitle").css("display", "inline-block");
		}
	});
});
</script>
</section>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>