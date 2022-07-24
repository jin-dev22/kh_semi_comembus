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
	Community sview = (Community)request.getAttribute("sview");
	List<CommunityRepl> replList = (List<CommunityRepl>) request.getAttribute("replList");
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/community.css" /> 
<section id="commu-container">
<h2>정보공유 게시판</h2>
<br />
<hr style="margin-top:20px;"  />  

	<!-- 게시글제목 -->
	<div id="boardViewDesc">
		<div><h4><%= sview.getCoTitle() %></h4></div>
		<hr style="margin-top:20px;"  />  
		<div><span id="boardViewWriter">글쓴이:&nbsp;&nbsp;<%=sview.getCoWriter() %></span> <br> <span id="boardViewRegDate"><%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(sview.getCoRegdate()) %></span></div>
	</div>
	
	<!-- 게시글내용 -->
	<div id="boardViewContent">
		<%= sview.getCoContent() %>
		<br>
		<% 
			boolean canEdit = loginMember != null && 
						(loginMember.getMemberId().equals(sview.getCoWriter())
								|| loginMember.getMemberRole() == MemberRole.A);
			if(canEdit) { 
		%>
<%-- 해당 게시글 작성자와 관리자만 마지막행 수정/삭제버튼이 보일수 있게 할 것 --%>
			
</div>
		<hr />	
		<div>
			<input id="btn3" type="button" value="수정하기" onclick="updateCommu()">&nbsp;&nbsp;&nbsp;
			<input id="btn4" type="button" value="삭제하기" onclick="deleteCommu()">
		</div>
	<% } %> 
<br /><br />
		<!-- 댓글 -->
    
<div id="boardViewRe">
<hr />
	<!-- 댓글 작성부 -->
	<!-- 로그인 했든안했든 일단 폼은 보여줌 -->
	    <div class="comment-editor">
	        <form
	            action="<%=request.getContextPath()%>/community/communityCommentEnroll?co_type=S" 
	            name="boardCommentFrm"
	            method="post"  >
	              	<input type="hidden" name="coNo" value="<%=sview.getCoNo() %>" /> <%--게시글번호 --%>
	                <input type="hidden" name="writer" value="<%=loginMember != null ? loginMember.getMemberId(): "" %>" />
	                <input type="hidden" name="commentLevel" value="1" /> <%--댓글 1--%>
	                <input type="hidden" name="commentRef" value="0" />  <%--댓글 0 --%>  
	                <textarea name="content" cols="60" rows="3" placeholder="상대방을 존중하는 댓글을 납깁시다"></textarea>
	                <button type="submit" id="btn-insert">등록</button>
	            </form>
	        </div>
	<hr />
	    <%
			if(replList != null && !replList.isEmpty()){ 
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		%>
			
		<table id="tbl-comment">
				
		<%for(CommunityRepl cr : replList){
					boolean canDelete = loginMember != null && 
							(loginMember.getMemberId().equals(cr.getReplWriter())|| loginMember.getMemberRole() == MemberRole.A);
					 if(cr.getReplLevel() == CommentLevel.COMMENT){
		   %> 
		   	<tr class="level1">
				<td>
					<div class="comment-level1">
						<sub class="comment-writer"><%= cr.getReplWriter() %></sub>
						<div class="comment-content"><%= cr.getContent() %></div>
						<sub class="comment-date"><%= sdf.format(cr.getRegDate()) %></sub>
					</div>
				</td>
				<td>
					<button class="btn-reply" value="<%= cr.getReplNo() %>">답글</button>
					<% if(canDelete){ %>
					<button class="btn-delete" value="<%= cr.getReplNo() %>">삭제</button>
					<% } %>
				</td>
			</tr>
			<% }else { %>
				<tr class="level2">
				<td>
					<div class="comment-level2">
						<sub class="comment-writer"><%= cr.getReplWriter() %></sub>
						<div class="comment-content"><%= cr.getContent() %></div>
						<sub class="comment-date"><%= sdf.format(cr.getRegDate()) %></sub>
					</div>
				</td>
				<% if(canDelete){ %>
				<td>
					<button class="btn-delete" value="<%= cr.getReplNo() %>">삭제</button>
				</td>
					
				<% } %>
			</tr>
		<%
				}
			} 
		%>
		</table>
		<% } %>
	</div>
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
	
	$(".btn-reply").click(function(){
		<% if(loginMember == null){ %>
		loginAlert();
		return;
		<% } %>
		
		//대댓글 작성폼 동적 생성
		var html = "<tr>"; 
		html += "<td colspan='2' style='display:none; text-align:left;'>";
		html += '<form action="<%=request.getContextPath()%>/community/communityCommentEnroll?co_type=S"  method="post" name="boardCommentFrm">';
		html += '<input type="hidden" name="coNo" value="<%= sview.getCoNo() %>" />';
		html += '<input type="hidden" name="writer" value="<%= loginMember != null ? loginMember.getMemberId() : "" %>" />';
		html += '<input type="hidden" name="commentLevel" value="2" />';
		html += '<input type="hidden" name="commentRef" value="' + $(this).val() + '" />';    
		html += '<textarea class="btn-insert-reply-textarea" name="content" cols="60" rows="2"></textarea>';
		html += '<button type="submit" class="btn-insert-reply" style="background-color: #92B4EC; color:white;">등록</button>';
		html += '</form>';
		html += "</td>";
		html += "</tr>";
		
		var $trOfBtn = $(this).parent().parent();
		$(html)
			.insertAfter($trOfBtn)
			.children("td")
			.slideDown(800);
		$(this).off("click");
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
	</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>