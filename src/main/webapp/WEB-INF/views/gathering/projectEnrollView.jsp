<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<form
	name="projectEnrollFrm"
	action="<%=request.getContextPath() %>/gathering/projectEnrollView" 
	method="post"
	enctype="multipart/form-data">
	<table id="tbl-project-enrollview">
        <tbody>
			<tr><th>*프로젝트명</th></tr>
			<tr><td colspan="3">❗ 프로젝트 제목을 적어주세요</td></tr>
			<tr><td><input type="text" name="title" id="projectName" placeholder="3~20자로 적어주세요" required></td></tr>
	        <tr></tr>
			<tr><th>*프로젝트 주제</th></tr>
			<tr><td colspan="3">❗ 프로젝트 제목을 적어주세요</td></tr>
			<tr>
	            <td colspan="3" id="topic">
	                <input type="radio" name="social">소셜네트워크
	                <input type="radio" name="game">게임
	                <input type="radio" name="travel">여행
	                <input type="radio" name="finance">금융
	                <input type="radio" name="ecommerce">이커머스
	            </td>
	        </tr>
	        <tr></tr>
	    	<tr><th>*지역</th></tr>
	        <tr><td colspan="3">❗ 지역을 선택해 주세요</td></tr>
			<tr>
	            <td>			
	                <select name="local" id="local">
	                    <option value="Online">온라인</option>
	                    <option value="Capital">수도권</option>
	                    <option value="Gangwon">강원도</option>
	                    <option value="Chungcheong">충청도</option>
	                    <option value="Jeolla">전라도</option>
	                    <option value="Gyeongsang">경상도</option>
	                    <option value="Jeju">제주도</option>
	                </select>
	            </td>
	        </tr>
	        <tr></tr>
	    	<tr><th>*모집인원</th></tr>
	        <tr><td colspan="3">❗ 3~4명을 추천합니다. (최대 9명까지 가능)</td></tr>
			<tr>
	            <td width="150px;">			
	                <select name="job_code" id="job_code">
	                    <option value="PL">기획</option>
	                    <option value="DG">디자인</option>
	                    <option value="FE">프론트엔드</option>
	                    <option value="BE">백엔드</option>
	                </select>
	            </td>
	            <td width="140px">
	                <div id="container">
	                    <button class="count" id="plus">+</button>
	                    <span id="count">1</span>
	                    <button class="count" id="minus">-</button>
	                
	                </div>
	            </td>
	            <td>
	                <input type="button" id="delete" value="삭제"></input>
	                <input type="button" id="add" value="추가" onclick="addRow()"/>
	            </td>
	            <td id="plus"></td>
	        </tr>
	        <tr></tr>
			<tr><th>*프로젝트 설명</th></tr>
		    <tr><td colspan="3" id="summernoteWidth">❗ 프로젝트에 대한 자세한 설명을 적어주세요. 자세할수록 지원률이 올라갑니다. <br><div><textarea id="summernote" name="editordata"></textarea></div></td></tr>
		    <tr></tr>
			<tr>
				<th colspan="2">
					<br><input type="submit" value="등록하기">
				</th>
			</tr>
		</tbody>
	</table>
</form>
<script>
    let container = document.querySelector('#container');
    const plusBtn = container.querySelector('#plus');
    const minusBtn = container.querySelector('#minus');
    const number = container.querySelector('span');

    plusBtn.addEventListener('click',function(){
	    let count = Number(number.textContent)
	        if(number.textContent<9){
	        count = count + 1;
	        number.textContent = count;}
    });
    minusBtn.addEventListener('click',function(){
	    let count = Number(number.textContent)
	        if(number.textContent>1){
	        count = count - 1;
	        number.textContent = count;}
    });
    let addRowNum=1;
    function addRow(){
        if(addRowNum<=3){
        //querySelectorAll은 껍데기를 한번 벗겨줘야함!
        const table=document.getElementById('tbl-project-enrollview');
        const newRow=table.insertRow(15);
        const newCell1=newRow.insertCell(0);
        const newCell2=newRow.insertCell(1);
        const newCell3=newRow.insertCell(2);

        newCell1.innerHTML='<td width="150px;"><select name="job_code" id="job_code"><option value="planning">기획</option><option value="design">디자인</option><option value="frontend">프론트엔드</option><option value="backend">백엔드</option></select></td>'
        newCell2.innerHTML='<div id="container"><button class="count" id="plus">+</button><span id="count">1</span><button class="count" id="minus">-</button></div>'
        newCell3.innerHTML='<td><input type="button" id="delete" value="삭제"></input><input type="button" id="add" value="추가" onclick="addRow()"/></td>'

        addRowNum+=1;
        }
    }
    

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
			placeholder: '<strong>1. 프로젝트의 시작 동기</strong> <br> - 이 서비스를 만들고 싶은 이유 <br> (ex. 기존에 존재하는 배달 시스템에 불만이 있어 보다 효율적인 앱을 만들고 싶습니다.) <br> - 어떤 사용자를 목적으로 하는지 써주세요. <br> (ex - 혼자사는 1인가구를 목적으로 하는 배달 어플 서비스) <br><br> <strong> 2. 프로젝트의 진행방식</strong> <br> - 1주일에 며칠 진행할 예정인가요? <br>(ex - 1주일에 1,2회 멤버 모이면 상의 후 결정) <br>- 온/오프라인 회의시 진행 방식과 진행 도구를 말해주세요. <br>(ex - 온라인, 디스코드(화면 공유 얼굴 비침 필수)) <br> <br> <strong>3. 사용기술</strong> <br>(ex - html, css, js, JAVA, Spring, Git)<br><br> <strong>4. 출시 플랫폼</strong><br>(ex - web, Android) <br><br> <strong>5. 기타 자유내용</strong> <br>(ex - 상업적인 부분은 기획자가 담당합니다.)',
			height : 500,
			focus : true,
			lang : 'ko-KR',
			toolbar : toolbar,
			callbacks : { //여기 부분이 이미지를 첨부하는 부분
			onImageUpload : function(files, editor,
				welEditable) {
					for (var i = files.length - 1; i >= 0; i--) {
						uploadSummernoteImageFile(files[i], this);
					}
				}
			}
		};
		$('#summernote').summernote(setting);
	});
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>