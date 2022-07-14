<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"
	rel="stylesheet" />
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

<!-- include summernote css/js-->
<link
	href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css"
	rel="stylesheet" />
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/community.css" />

<section id="commu-container">
<h2>글작성</h2>
<form action="<%=request.getContextPath()%>/community/communityEnroll"
	method="post" id="communityEnrollFrm">

        <table id="tbl-board-view">
        <tr>
            <td>제목</td>
        </tr>

        <tr>
            <td><input type="text" name="title" placeholder="제목을 입력하세요" required></td>
        </tr>

        <tr>
            <td>작성자</td>
        </tr>
        <tr>
            <td><input type="text" name="writer" readonly/></td>
        </tr>
  
    
        <tr>
            <td>내용</td>
        </tr>
        <tr>
            <td><textarea id="summernote" rows="5" cols="40" name="summernote" ></textarea></td>
        </tr>
                <tr class="btn"> 
                <td><input type="submit" value="등록"></td> 
        </tr>
    </table>
</form>
</section>
<script>
	//게시판 에디터 생성
        $(document).ready(function() {
            $('#summernote').summernote({
                height: 300
            });
        });
      
document.commuEnrollFrm.onsubmit = (e) => {
		const frm = e.target;
		//제목을 작성하지 않은 경우
		if(!/^.+$/.test(frm.title.value)){
			alert("제목을 작성해주세요.");
			frm.title.focus();
			return false;
		}
		
		//내용을 작성하지 않은 경우
		if(!/^(.|\n)+$/.test(frm.summernote.value)){
			alert("내용을 작성해주세요.");
			frm.summernote.focus();	
			return false;
		}

		return true;
	}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>