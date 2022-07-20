<%@page import="kh.semi.comembus.member.model.dto.MemberRole"%>
<%@page import="kh.semi.comembus.community.model.dto.Community"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	Community sview = (Community)request.getAttribute("sview");
%>
<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/css/community.css" /> --%>
<section id="board-container">
	<h2>게시판</h2>
	<table id="tbl-board-view">
		
		<tr>
			<th>제목</th>
			<td><%= sview.getCoTitle() %></td>
		</tr>
		
		<tr>
			<th>글쓴이</th>
			<td><%= sview.getCoWriter() %></td>
		</tr>
		
		<tr>
			<th>조회수</th>
			<td><%= sview.getCoReadcount() %></td>
		</tr>
		
		<tr>
			<th>내용</th>
			<td><%= sview.getCoContent() %></td>
		</tr>
		
		<tr>
			<th>작성일</th>
			<td><%= sview.getCoRegdate() %></td>
		</tr>
		
		<% 
			boolean canEdit = loginMember != null && 
						(loginMember.getMemberId().equals(sview.getCoWriter())
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
	<form action="<%= request.getContextPath() %>/community/communityDelete?co_type=S"
		  method = "post"
		  name="commuDelFrm">
		  <input type="hidden" name="no" value="<%= sview.getCoNo() %>" />
	</form>
	
	<script>
		const updateCommu = () => {
		location.href = "<%= request.getContextPath() %>/community/communityUpdate?co_type=S&no=<%= sview.getCoNo()%>";
		
		};
		
		const deleteCommu = () => {
			if(confirm("정말 게시글을 삭제하시겠습니까?"))
				document.commuDelFrm.submit();
		};
	
	</script>
	<% } %>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>