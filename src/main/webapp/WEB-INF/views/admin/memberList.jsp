<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<Member> memberList = (List<Member>) request.getAttribute("memberList");
	String type = request.getParameter("searchType");
	String kw = request.getParameter("searchKeyword");
%>
<!-- 관리자용 admin.css link -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css" />
<style>


div#search-memberId{
	display: <%= type == null || "member_id".equals(type) ? "inline-block" : "none" %>;
}
div#search-memberNickname{
	display: <%= "member_nickname".equals(type) ? "inline-block" : "none" %>;
}
</style>
<script>
window.addEventListener('load', (e) => {
	document.querySelector("select#searchType").onchange = (e) => {
		document.querySelectorAll(".search-type").forEach((div, index) => {
			div.style.display = "none";
		});
		let id;
		switch(e.target.value){
		case "member_id" : id = "memberId"; break;
		case "member_nickname" : id = "memberNickname"; break;
		}
		
		document.querySelector(`#search-\${id}`).style.display = "inline-block";
	}
});
</script>
<section id="memberList-container">
	<h2>회원관리</h2>
	
    <div id="search-container">
        <select id="searchType">
            <option value="member_id" <%= "member_id".equals(type) ? "selected" : "" %>>아이디</option>        
            <option value="member_nickname" <%= "member_nickname".equals(type) ? "selected" : "" %>>닉네임</option>
        </select>
        <div id="search-memberId" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/memberFinder">
                <input type="hidden" name="searchType" value="member_id"/>
                <input type="text" name="searchKeyword" size="25" placeholder="검색할 아이디를 입력하세요." 
                	value="<%= "member_id".equals(type) ? kw : "" %>"/>
                <button type="submit">검색</button>            
            </form>    
        </div>
        <div id="search-memberNickname" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/memberFinder">
                <input type="hidden" name="searchType" value="member_nickname"/>
                <input type="text" name="searchKeyword" size="25" placeholder="검색할 닉네임을 입력하세요."
                	value="<%= "member_nickname".equals(type) ? kw : "" %>"/>
                <button type="submit">검색</button>            
            </form>    
        </div>
    </div>
	<table id="tbl-member">
		<thead>
			<tr>
				<th>아이디</th>
				<th>닉네임</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>가입일</th>
				<th>회원권한</th>
				<th>강퇴</th>
			</tr>
		</thead>
		<tbody>
		<%
			if(memberList == null || memberList.isEmpty()){
		%>
			<tr>
				<td colspan="10" align="center"> 검색 결과가 없습니다. </td>
			</tr>
		<%
			} 
			else {
				for(Member m : memberList){
		%>
			<tr>
				<td><%= m.getMemberId() %></td>
				<td><%= m.getNickName() %></td>
				<td><%= m.getMemberName() %></td>
				<td><%= m.getPhone() %></td>
				<td><%= new SimpleDateFormat("yyyy-MM-dd").format(m.getEnrollDate()) %></td>
				<td>
					<select class="member-role" data-member-id="<%= m.getMemberId() %>">
						<option value="A" <%= MemberRole.A == m.getMemberRole() ? "selected" : "" %>>관리자</option>
						<option value="M" <%= MemberRole.M == m.getMemberRole() ? "selected" : "" %>>일반</option>
					</select>	
				</td>
				<td>
					<input type="button" data-member-id="<%= m.getMemberId() %>" name="quit_member" id="quitMember" value="강퇴하기"/>
				</td>
		
			</tr>		
		<%		} 
			}
		%>
			</tbody>

	</table>

	
	<div id="pagebar">
		<%= request.getAttribute("pagebar") %>
	</div>
</section>

<form 
	action="<%= request.getContextPath() %>/admin/memberRoleUpdate"
	method="POST"
	name="memberRoleUpdateFrm">
	<input type="hidden" name="memberId"/>
	<input type="hidden" name="memberRole"/>
</form>

<script>
// 회원 강퇴처리
document.querySelectorAll("#quitMember").forEach((btn, index) => {
	btn.onclick = (e) => {
		const memberId = e.target.dataset.memberId;
		
		if(confirm(`아이디: \${memberId} 회원을 정말로 강퇴하시겠습니까?`)){	
		
			$.ajax({
				url: '<%= request.getContextPath() %>/admin/memberQuit',
				method: "POST",
				data: {memberId},
				success(result){
					if(result){
						alert('회원 강퇴처리가 완료되었습니다.');
						location.reload();
					}
					else{
						alert('회원 강퇴처리에 실패하였습니다.');
					}
				},
				error: console.log
			});
		}
	};
});

// 회원권한 변경
document.querySelectorAll(".member-role").forEach((select, index) => {
	select.onchange = (e) => {
		console.log(e.target.dataset.memberId, e.target.value);
		
		let role;
		role = e.target.value === 'M' ? '일반' : '관리자';
		
		if(confirm(`해당 회원의 권한을 \${role}(으)로 변경하시겠습니까?`)){
			const frm = document.memberRoleUpdateFrm;
			frm.memberId.value = e.target.dataset.memberId;
			frm.memberRole.value = e.target.value;
			frm.submit();
		}
		else {
			// 원상복구 코드
			e.target.querySelector("[selected]").selected = true;
			console.log(e.target.dataset.memberId);
		}
	};
});

</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
