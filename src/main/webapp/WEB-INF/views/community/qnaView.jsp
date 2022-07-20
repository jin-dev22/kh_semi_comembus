<%@page import="kh.semi.comembus.member.model.dto.MemberRole"%>
<%@page import="kh.semi.comembus.community.model.dto.Community"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	Community qview = (Community)request.getAttribute("qview");
%>
<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/css/community.css" /> --%>
<section id="board-container">
	<h2>게시판</h2>
	<table id="tbl-board-view">
		
		<tr>
			<th>제목</th>
			<td><%= qview.getCoTitle() %></td>
		</tr>
		
		<tr>
			<th>글쓴이</th>
			<td><%= qview.getCoWriter() %></td>
		</tr>
		
		<tr>
			<th>조회수</th>
			<td><%= qview.getCoReadcount() %></td>
		</tr>
		
		<tr>
			<th>내용</th>
			<td><%= qview.getCoContent() %></td>
		</tr>
		
		<tr>
			<th>작성일</th>
			<td><%= qview.getCoRegdate() %></td>
		</tr>

		<% 
			boolean canEdit = loginMember != null && 
						(loginMember.getMemberId().equals(qview.getCoWriter())
								|| loginMember.getMemberRole() == MemberRole.A);
			if(canEdit) { 
		%>

		<tr>
			<%-- 해당 게시글 작성자와 관리자만 마지막행 수정/삭제버튼이 보일수 있게 할 것 --%>
			<th colspan="2">
				<input type="button" value="수정하기" onclick="updateCommu()">
				<input type="button" value="삭제하기" onclick="deleteCommu()">
			</th>
		</tr>
	
	<% } %> 
	</table>
	
<% if(canEdit){ %>
	<form action="<%= request.getContextPath() %>/community/communityDelete?co_type=Q"
		  method = "post"
		  name="commuDelFrm">
		  <input type="hidden" name="no" value="<%= qview.getCoNo() %>" />
	</form>
	
	<script>
		const updateCommu = () => {
		location.href = "<%= request.getContextPath() %>/community/communityUpdate?co_type=Q&no=<%= qview.getCoNo()%>";
		
		};
		
		const deleteCommu = () => {
			if(confirm("정말 게시글을 삭제하시겠습니까?"))
				document.commuDelFrm.submit();
		};
	
	</script>
	<% } %>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>