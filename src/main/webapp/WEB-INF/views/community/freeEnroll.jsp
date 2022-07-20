<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/community.css" />

<div id="commuHeader">
	<p>글작성<p>
</div>
<form action="<%=request.getContextPath()%>/community/communityEnroll?co_type=F"
	method="post" id="communityEnrollFrm">
	
<table id="tbl-board-view">
	<tr>
		<th>제목</th>
	</tr>
	
 	<tr>
		<td><input type="text" name="co_title" id="enroll_title" placeholder="제목을 작성해주세요" /></td>
	</tr>

	<tr>
		<th>작성자</th>
	</tr>
	
 	<tr>
		<td><input type="text" name="co_writer" value="<%= loginMember.getMemberId() %>" readonly/></td>
	</tr>

	<tr>
		<th>내용</th>
	</tr>
	
	<tr>
		<td><input type="hidden" name="co_content" id="enroll_summernote"/></td>
	</tr>
	
	<tr>
		<td>
			<input type="submit" value="등록" /> 
		</td>
	</tr>
	
</table>
</form>

<script>
	//게시판 에디터 생성
      $("#enroll_summernote").summernote({
        height: 500,
	    focus: true,
	    disableResizeEditor: true,
	   });
   
	//submit 처리
      $("#communityEnrollFrm").submit(function(){
    		$("[name=co_content]").val($("#enroll_summernote").summernote('code'));
			var $co_title = $("[name=co_title]").val();
			var $co_content = $("[name=co_content]").val();
			
			//제목 유효성 검사
			if(/^.{1,}$/.test($co_title)==false){
				alert("제목을 입력해주세요!");
				$("[name=co_title]").focus();
				return false;
			}
			//내용 유효성 검사
			if($co_content.length==0 || $co_content=="<p><br></p>"){
				alert("내용을 입력해주세요!");
				$("#enroll_summernote").summernote("focus");
				return false;
			}
			
    	if(confirm("게시글을 등록 하시겠습니까?")){
    		return true;
    	}else{
    		return false;
    	}
      });
  
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>