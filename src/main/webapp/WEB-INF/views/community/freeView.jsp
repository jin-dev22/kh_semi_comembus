<%@page import="kh.semi.comembus.community.model.dto.CommentLevel"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="kh.semi.comembus.community.model.dto.CommunityRepl"%>
<%@page import="kh.semi.comembus.member.model.dto.MemberRole"%>
<%@page import="kh.semi.comembus.community.model.dto.Community"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	Community fview = (Community)request.getAttribute("fview");
	List<CommunityRepl> replList = (List<CommunityRepl>) request.getAttribute("replList");
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/community.css" /> 
<section id="board-container">
<div id="viewHeader">
	<p>게시글<p>
</div>
<hr style="margin-top:30px;"  />  
	<table id="tbl-board-view">
		
		<tr>
			<th>제목</th>
			<td><%= fview.getCoTitle() %></td>
		</tr>
		
		<tr>
			<th>글쓴이</th>
			<td><%= fview.getCoWriter() %></td>
		</tr>
		
		<tr>
			<th>조회수</th>
			<td><%= fview.getCoReadcount() %></td>
		</tr>
		
		<tr>
			<th>내용</th>
			<td><%= fview.getCoContent() %></td>
		</tr>
		
		<tr>
			<th>작성일</th>
			<td><%= fview.getCoRegdate() %></td>
		</tr>

		<% 
			boolean canEdit = loginMember != null && 
						(loginMember.getMemberId().equals(fview.getCoWriter())
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
		<!-- 댓글 -->
		<hr style="margin-top:30px;" />    
	    
	    <div class="comment-container">
	    
	    <!-- 댓글 작성부 -->
	    <!-- 로그인 했든안했든 일단 폼은 보여줌 -->
	    <div class="comment-editor">
	        <form
	            name="boardCommentFrm"
	            action="<%=request.getContextPath()%>/community/communityCommentEnroll?co_type=F" 
	            method="post" >
	              	<input type="hidden" name="coNo" value="<%=fview.getCoNo() %>" /> <%--게시글번호 --%>
	                <input type="hidden" name="writer" value="<%=loginMember != null ? loginMember.getMemberId(): "" %>" />
	                <input type="hidden" name="commentLevel" value="1" /> <%--댓글 1--%>
	                <input type="hidden" name="commentRef" value="0" />  <%--댓글 0 --%>  
	                <textarea name="content" cols="60" rows="3"></textarea>
	                <button type="submit" id="btn-comment-enroll1">등록</button>
	            </form>
	        </div>
	<br /> <br /><br />

	    <%
			if(replList != null && !replList.isEmpty()){ 
				SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm");
		%>
			
		<table id="tbl-comment">
				
			<%for(CommunityRepl cr : replList){
					boolean canDelete = loginMember != null && 
							(loginMember.getMemberId().equals(cr.getReplWriter())
									|| loginMember.getMemberRole() == MemberRole.A);
		   %>
			<tr class="<%= cr.getReplLevel() == CommentLevel.COMMENT ? "level1" : "level2" %>">
				<td>
					<sub class="comment-writer"><%= cr.getReplWriter() %></sub>
					<sub class="comment-date"><%= sdf.format(cr.getRegDate()) %></sub>
					<div>
						<%= cr.getContent() %>
					</div>
				</td>
				<td>
					<% if(cr.getReplLevel() == CommentLevel.COMMENT){ %>
					<button class="btn-reply" value="<%= cr.getReplNo() %>">답글</button>
					<% } %>
					
					<% if(canDelete){ %>
					<button class="btn-delete" value="<%= cr.getReplNo() %>">삭제</button>
					<% } %>
				</td>
			</tr>
		<%
				}
			}
		%>
		</table>
		</div>
	</section>


<!-- 댓글 삭제 -->
<form 
		action="<%= request.getContextPath() %>/community/communityCommentDelete" 
		method="post"
		name="boardCommentDelFrm">
		<input type="hidden" name="no"  />
</form>

<script>
	document.querySelectorAll(".btn-delete").forEach((btn) => {
		btn.addEventListener('click', (e) => {
			if(confirm("해당 댓글을 정말 삭제하시겠습니까?")) {
				const{value} = e.target;
				const frm = document.boardCommentDelFrm;
				frm.no.value = value;
				frm.submit();
				}
		});
	});
	document.querySelectorAll(".btn-reply").forEach((btn) => {
		btn.addEventListener('click', (e) => {
			<% if(loginMember == null){%>
				loginAlert(); return; 
			<% } %>
			const {value} = e.target;
			console.log(value);
			
			const tr = `
			<tr>
				<td colspan="2" style="text-align:left;">
					<form
			            name="boardCommentFrm"
			            action="<%=request.getContextPath()%>/community/communityCommentEnroll?co_type=F" 
			            method="post" >
			               <input type="hidden" name="coNo" value="<%= fview.getCoNo() %>" />
			               <input type="hidden" name="writer" value="<%=loginMember != null ? loginMember.getMemberId(): "" %>" />
			               <input type="hidden" name="commentLevel" value="2" />
			               <input type="hidden" name="commentRef" value="\${value}" />    
			               <textarea name="content" cols="60" rows="1"></textarea>
			               <button type="submit" class="btn-comment-enroll2">등록</button>
	            	</form>
	            </td>
	         </tr>`;
	            
	            const target = e.target.parentElement.parentElement; //tr
	            target.insertAdjacentHTML('afterend', tr);
		}, {once: true});
	});
	
	document.boardCommentFrm.content.addEventListener('focus',(e) => {
		if(<%= loginMember == null %>){
			loginAlert();
		}
	});
	/**
	 * 부모요소에서 자식 submit 이벤트 핸들링
	 */
	document.addEventListener('submit', (e) => {
		
		//matches(selector) 선택자 일치여부를 반환
		if(e.target.matches("form[name=boardCommentFrm]")){
			if(<%= loginMember == null %>){
				e.preventDefault();
				return;
			}
			
			if(!/^(.|\n)+$/.test(e.target.content.value)){
				alert("내용을 작성해주세요.");
				e.preventDefault();
				return;			
			}
		}
	});
document.addEventListener('submit', (e) => {
	
	//matches(selector) 선택자 일치여부를 반환
	if(e.target.matches("form[name=boardCommentFrm]")){
		if(<%= loginMember == null %>){
			loginAlert();
			e.preventDefault();
			return;
		}
		
		if(!/^(.|\n)+$/.test(e.target.content.value)){
			alert("내용을 작성해주세요.");
			e.preventDefault();
			return;			
		}
	}
});

const loginAlert = () => {
	alert("로그인후 이용할 수 있습니다");
};
</script>
<%--게시글삭제 --%>

<% if(canEdit){ %>
	<form action="<%= request.getContextPath() %>/community/communityDelete?co_type=F"
		  method = "post"
		  name="commuDelFrm">
		  <input type="hidden" name="no" value="<%= fview.getCoNo() %>" />
	</form>
	
	<script>
		const updateCommu = () => {
		location.href = "<%= request.getContextPath() %>/community/communityUpdate?co_type=F&no=<%= fview.getCoNo()%>";
		
		};
		
		const deleteCommu = () => {
			if(confirm("정말 게시글을 삭제하시겠습니까?"))
				document.commuDelFrm.submit();
		};
	
	</script>
	<% } %>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>