<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 등록하기</title>

<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<!-- summer note -->
<script src="src/main/webapp/js/summernote/summernote-lite.js"></script>
<script src="src/main/webapp/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="src/main/webapp/css/summernote/summernote-lite.css">

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script></head></head>
<body>
<section id="board-container">
<h2>게시판 작성</h2>
<form
	name="projectEnrollFrm"
	action="<%=request.getContextPath() %>/gathering/projectEnroll" 
	method="post"
	enctype="multipart/form-data">
	<table id="tbl-project-enrollview">
        <tbody>
		<tr><th>*프로젝트명</th></tr>
		<tr><td>❗ 프로젝트 제목을 적어주세요</td></tr>
		<tr><td><input type="text" name="title" placeholder="3~20자로 적어주세요" required></td></tr>
		<tr><th>*프로젝트 주제</th></tr>
		<tr><td>❗ 프로젝트 제목을 적어주세요</td></tr>
		<tr>
            <td>
                <input type="radio" name="social">소셜네트워크
                <input type="radio" name="social">게임
                <input type="radio" name="social">여행
                <input type="radio" name="social">금융
                <input type="radio" name="social">이커머스
            </td>
        </tr>
    	<tr><th>*지역</th></tr>
        <tr><td>❗ 지역을 선택해 주세요</td></tr>
		<tr>
            <td>			
                <select name="local" id="local">
                    <option value="online">온라인</option>
                    <option value="sudo">수도권</option>
                    <option value="kangwon">강원도</option>
                    <option value="chungcheong">충청도</option>
                    <option value="junla">전라도</option>
                    <option value="kyungsang">경상도</option>
                    <option value="jeju">제주도</option>
                </select>
            </td>
        </tr>
    	<tr><th>*모집인원</th></tr>
        <tr><td>❗ 3~4명을 추천합니다. (최대 9명까지 가능)</td></tr>
		<tr>
            <td>			
                <select name="job_code" id="job_code">
                    <option value="planning">기획</option>
                    <option value="design">디자인</option>
                    <option value="frontend">프론트엔드</option>
                    <option value="backend">백엔드</option>
                </select>
            </td>
            <td>
                <button id="minus">-</button>
                <button id="count">1</button>
                <button id="plus">+</button>
            </td>
            <td>
                <button id="delete">삭제</button>
                <button id="add">추가</button>
            </td>
        </tr>
	<tr><th>*프로젝트 설명</th></tr>
    <tr><td>❗ 프로젝트에 대한 자세한 설명을 적어주세요. 자세할수록 지원률이 올라갑니다. <br><div><textarea id="summernote" name="editordata"></textarea></div></td></tr>
    <tr></tr>



	<tr>
		<th colspan="2">
			<br><input type="submit" value="등록하기">
		</th>
	</tr>
</tbody>
</table>
</form>
</section>
</body>
<script>
    $(document).ready(function() {
	//여기 아래 부분
	$('#summernote').summernote({
        height: 500,                 // 에디터 높이
		minHeight: 700,             // 최소 높이
	    maxHeight: null,             // 최대 높이
    	focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		lang: "ko-KR",					// 한글 설정
		placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
          
	});
});
$('#summernote').summernote({
    placeholder: '<strong>1. 프로젝트의 시작 동기</strong> <br> - 이 서비스를 만들고 싶은 이유 <br> (ex. 기존에 존재하는 배달 시스템에 불만이 있어 보다 효율적인 앱을 만들고 싶습니다.) <br> - 어떤 사용자를 목적으로 하는지 써주세요. <br> (ex - 혼자사는 1인가구를 목적으로 하는 배달 어플 서비스) <br><br> <strong> 2. 프로젝트의 진행방식</strong> <br> - 1주일에 며칠 진행할 예정인가요? <br>(ex - 1주일에 1,2회 멤버 모이면 상의 후 결정) <br>- 온/오프라인 회의시 진행 방식과 진행 도구를 말해주세요. <br>(ex - 온라인, 디스코드(화면 공유 얼굴 비침 필수)) <br> <br> <strong>3. 사용기술</strong> <br>(ex - html, css, js, JAVA, Spring, Git)<br><br> <strong>4. 출시 플랫폼</strong><br>(ex - web, Android) <br><br> <strong>5. 기타 자유내용</strong> <br>(ex - 상업적인 부분은 기획자가 담당합니다.)',
		  toolbar: [
			    // [groupName, [list of button]]
			    ['fontname', ['fontname']],
			    ['fontsize', ['fontsize']],
			    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			    ['color', ['forecolor','color']],
			    ['table', ['table']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']],
			  ],
			fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
			fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
	  });
</script>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>