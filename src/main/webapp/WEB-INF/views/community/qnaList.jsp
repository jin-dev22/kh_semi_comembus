<%@page import="java.text.SimpleDateFormat"%>
<%@page import="kh.semi.comembus.community.model.dto.Community"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board.css" />
<%
	List<Community> list = (List<Community>) request.getAttribute("list"); 
%>
<section id="qna-container">
<title>Q&A 목록</title>

	<input 
		type="button" value="글쓰기" id="btn-add"
		onclick="location.href='<%= request.getContextPath() %>/qna/qnaEnroll';"/>
	
	<table id="tbl-commu">
		<tr>
			<th>제목</th>
			<th>글쓴이</th>
			<th>작성일</th>
			<th>추천수</th>
			<th>조회수</th>
		</tr>
		
		<% 
			if(list != null && !list.isEmpty()){ 
				for(Community _commu : list){
					Community commu = _commu; 
					
		%>
			<tr>
				<td><%= commu.getCoTitle() %></td>
				<td><%= commu.getCoWriter() %></td>
				<td><%= new SimpleDateFormat("yyyy-MM-dd HH:mm").format(commu.getCoRegdate()) %></td>
				<td><%= commu.getCoLike() %></td>
				<td><%= commu.getCoReadcount() %></td>
			
			</tr>
			<%
				}
			} 
			else { 
		%>
		<tr>
			<td colspan="6">조회된 게시글이 없습니다.</td>
		</tr>
		<% } %>
		
</table>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>