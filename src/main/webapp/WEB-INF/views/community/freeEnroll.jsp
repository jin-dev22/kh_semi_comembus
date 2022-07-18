<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/community.css" />

<div id="commuHeader">
	<p>자유글작성<p>
</div>
<form action="<%=request.getContextPath()%>/community/communityEnroll?co_type=Q"
	method="post" id="communityEnrollFrm">
	
<table id="tbl-board-view">
	<tr>
		<th>제목</th>
	</tr>
	
 	<tr>
		<td><input type="text" name="title" id="enroll_title" placeholder="제목을 작성해주세요" /></td>
	</tr>

	<tr>
		<th>작성자</th>
	</tr>
	
 	<tr>
		<td><input type="text" name="writer" readonly/></td>
	</tr>

	<tr>
		<th>내용</th>
	</tr>
	
	<tr>
		<td><input type="hidden" name="content" value="" id="enroll_summernote"/></td>
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
 //     $("#enroll_summernote").summernote({
 //       height: 500,
  //      focus: true,
  //      disableResizeEditor: true,
  //    });
      
      $(document).ready(function() {
    	    
          var toolbar = [
                  // 글꼴 설정
                  ['fontname', ['fontname']],
                  // 글자 크기 설정
                  ['fontsize', ['fontsize']],
                  // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
                  ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
                  // 글자색
                  ['color', ['forecolor','color']],
                  // 표만들기
                  ['table', ['table']],
                  // 글머리 기호, 번호매기기, 문단정렬
                  ['para', ['ul', 'ol', 'paragraph']],
                  // 줄간격
                  ['height', ['height']]
                ];
          
          var setting = {
        		  width : 1000,
                  height : 500,
                  focus : true,
                  lang : 'ko-KR',
                  toolbar : toolbar,
                  callbacks : { //여기 부분이 이미지를 첨부하는 부분
                  onImageUpload : function(files, editor,
                  welEditable) {
                  for (var i = files.length - 1; i >= 0; i--) {
                  uploadSummernoteImageFile(files[i],
                  this);
                          }
                      }
                  }
               };
      
              $('#enroll_summernote').summernote(setting);
              });
	//submit 처리
      $("#communityEnrollFrm").submit(function(){
    		$("[name=content]").val($("#enroll_summernote").summernote('code'));
			var $title = $("[name=title]").val();
			var $content = $("[name=content]").val();
			
			//제목 유효성 검사
			if(/^.{1,}$/.test($title)==false){
				alert("제목을 입력해주세요!");
				$("[name=title]").focus();
				return false;
			}
			//내용 유효성 검사
			if($content.length==0 || $content=="<p><br></p>"){
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