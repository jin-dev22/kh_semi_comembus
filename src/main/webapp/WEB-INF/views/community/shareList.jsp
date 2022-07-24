<%@page import="kh.semi.comembus.common.ComembusUtils"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="kh.semi.comembus.community.model.dto.Community"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/community.css" />
<%
	List<Community> slist = (List<Community>) request.getAttribute("slist"); 
	List<Community> best = (List<Community>) request.getAttribute("best"); 
	
%>
<section id="commu-container">
	<h2>정보공유 게시판‍💻</h2>
	<h4>다양한 정보를 공유하는 게시판 입니다.</h4><br /><br />
	
<div class="community-s-container">
	
		<div class="co-share-lists">
			<% if(best == null || best.isEmpty()){ %>
			<div>조회된 게시글이 없습니다.</div>
			<% }else{ 
				for(Community c:best){
			%>
				<div class="co-share">
				<div class="co-share-title">
						<a href="<%= request.getContextPath() %>/community/communityView?co_type=S&no=<%= c.getCoNo() %>"><%= ComembusUtils.escapeXml(c.getCoTitle()) %></a>
					</div>
					<div class="co-share-info">
						<span class="co-share-writer"><%= c.getCoWriter() %></span>
						<span class="heart-emoji">&#9829;</span><%= c.getCoLike() %></span>
						<span>&#128064;</span><%= c.getCoReadcount() %></span>
					</div>
				</div>
			<%
					}
				} 
			%>
		</div>
	<br />
	<hr />
	<table id="tbl-board">
		<tr>
			<th>제목</th>
			<th>글쓴이</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		
	<%if(slist == null || slist.isEmpty()){%>
		<tr>
			<td colspan="6" style="text-align: center; height: 441px; border:none; font-size: 25px;">조회된 게시글이 없습니다.</td>
		</tr>
		<%}else{ 
			for(Community c:slist){
			%>
		<tr>
			<td><a href="<%= request.getContextPath() %>/community/communityView?co_type=S&no=<%= c.getCoNo()%>"><%= ComembusUtils.escapeXml(c.getCoTitle()) %></a></td>
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
	onclick="location.href='<%= request.getContextPath() %>/community/communityEnroll?co_type=S';"/>
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