<%@page import="java.text.SimpleDateFormat"%>
<%@page import="kh.semi.comembus.community.model.dto.Community"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/community.css" />
<%
	List<Community> qlist = (List<Community>) request.getAttribute("qlist"); 
%>
<div id="commuHeader">
	<p>Q&A 게시판<p>
</div>

<div id="commuListWrapper">
<div>
		<form id="titleText">
			<input type="text" name="keyword" placeholder="제목으로 검색하기"> <button id="btn">검색</button>
		</form>
		
</div>
	<table id="tbl-commu">
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
				<td><%= c.getCoTitle() %></td>
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
		<input type="button" value="글쓰기" id="btn-add"
		onclick="location.href='<%= request.getContextPath() %>/community/communityEnroll?co_type=Q';"/>
		
<%@ include file="/WEB-INF/views/common/footer.jsp"%>