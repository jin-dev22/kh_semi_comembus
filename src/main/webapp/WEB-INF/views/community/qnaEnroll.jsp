<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/community.css" />

<h2>글작성</h2>
<hr style="margin-top:30px;"  /> 
<div id="tbl-board-view" >

<form action="<%=request.getContextPath()%>/community/communityEnroll?co_type=Q"
	method="post" id="boardEnrollFrm">
	<label for="enroll_title">제목</label><br />
	<input type="text" name="co_title" id="enroll_title" placeholder="제목을 작성해주세요"/></td>
<br /><br />
	<label>작성자</label><br />
	<input type="text" name="co_writer" value="<%= loginMember.getMemberId() %>" readonly/>
<br /><br />
	<label for="enroll_summernote">내용</label>
	<input type="hidden" name="co_content" id="enroll_summernote"/>
	<br />
	<input id="btn1" type="submit" value="등록" /> &nbsp;&nbsp;&nbsp;
	<input id="btn2" type="button" value="취소" onclick="cancel()" />
</form>
</div>
<script>
	//게시판 에디터 생성
      $("#enroll_summernote").summernote({
        height: 500,
        width: 700,
	    focus: true,
	    disableResizeEditor: true,
	   });
   
	//submit 처리
      $("#boardEnrollFrm").submit(function(){
    		$("[name=co_content]").val($("#enroll_summernote").summernote('code'));
			var $co_title = $("[name=co_title]").val();
			var $co_content = $("[name=co_content]").val();
			
			//제목 유효성 검사
			if(/^.{1,}$/.test($co_title)==false){
				alert("제목을 입력하세요");
				$("[name=co_title]").focus();
				return false;
			}
			//내용 유효성 검사
			if($co_content.length==0 || $co_content=="<p><br></p>"){
				alert("내용을 입력하세요");
				$("#enroll_summernote").summernote("focus");
				return false;
			}
			
    	if(confirm("게시글을 등록 하시겠습니까?")){
    		return true;
    	}else{
    		return false;
    	}
      });
	
  	//뒤로가기
      function cancel(){
    	  if(confirm("작성하신 내용은 저장되지 않습니다!")){
    		  location.href='<%=request.getContextPath()%>/community/communityList?co_type=Q';
		}
	};
  
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>