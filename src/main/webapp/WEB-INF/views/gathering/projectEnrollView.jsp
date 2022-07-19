<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/gathering/Enroll.css">

<form name="projectEnrollFrm"
	action="<%=request.getContextPath()%>/gathering/projectEnrollView"
	method="post" enctype="multipart/form-data">
	<table id="tbl-project-enrollview">
		<tbody>
			<tr>
				<th>*프로젝트명</th>
			</tr>
			<tr>
				<td colspan="3">❗ 프로젝트 제목을 적어주세요</td>
			</tr>
			<tr>
				<td><input type="text" name="title" id="name"
					placeholder="3~20자로 적어주세요" required></td>
			</tr>
			<tr></tr>
			<tr>
				<th>*프로젝트 주제</th>
			</tr>
			<tr>
				<td colspan="3">❗ 프로젝트 제목을 적어주세요</td>
			</tr>
			<tr>
				<td colspan="3"><input type="radio" name="social">소셜네트워크
					<input type="radio" name="social">게임 <input type="radio"
					name="social">여행 <input type="radio" name="social">금융
					<input type="radio" name="social">이커머스</td>
			</tr>
			<tr></tr>
			<tr>
				<th>*지역</th>
			</tr>
			<tr>
				<td colspan="3">❗ 지역을 선택해 주세요</td>
			</tr>
			<tr>
				<td><select name="local" id="local">
						<option value="online">온라인</option>
						<option value="sudo">수도권</option>
						<option value="kangwon">강원도</option>
						<option value="chungcheong">충청도</option>
						<option value="junla">전라도</option>
						<option value="kyungsang">경상도</option>
						<option value="jeju">제주도</option>
				</select></td>
			</tr>
			<tr></tr>
			<tr>
				<th>*모집인원</th>
			</tr>
			<tr>
				<td colspan="3">❗ 3~4명을 추천합니다. 인원 설정 후 저장 버튼을 눌러주세요. (최대 9명까지
					가능)</td>
			</tr>
			<tr id="memberAdd">
				<td><select name="job_code" id="job_code1">
						<option value="planning">기획</option>
						<option value="design">디자인</option>
						<option value="frontend">프론트엔드</option>
						<option value="backend">백엔드</option>
				</select></td>
				<td>
					<button class="count" id="plus1">+</button>
					<span id="count1">1</span>
				<button class="count" id="minus1">-</button>
				</td>
				<td><input type="button" id="delete" value="삭제"
					onclick="deleteRow()" /> <input type="button" id="add" value="추가"
					onclick="addRow()" /> <input type="button" id="clear" value="저장"
					onclick="checkTotal()" /></td>
			</tr>
			<tr></tr>
			<tr>
				<th>*기간 설정</th>
			</tr>
			<tr>
				<td colspan="3">❗ 날짜는 시작일 전까지 수정이 가능합니다.</td>
			</tr>
			<tr>
				<td class="date">시작일</td>
				<td colspan="2">
					<p>
						<input type="date" id="date_start">
					</p>
				</td>
			</tr>
			<tr>
				<td class="date">종료일</td>
				<td colspan="2">
					<p>
						<input type="date" id="date_end">
					</p>
				</td>
			</tr>
			<tr></tr>
			<tr>
				<th>*프로젝트 설명</th>
			</tr>
			<tr>
				<td colspan="3" id="summernoteWidth">❗ 프로젝트에 대한 자세한 설명을 적어주세요.
					자세할수록 지원률이 올라갑니다. <br>
				<div>
						<textarea id="summernote" name="editordata"></textarea>
					</div>
				</td>
			</tr>
			<tr></tr>
			<tr>
				<th colspan="2"><br>
				<input type="submit" value="등록하기"></th>
			</tr>
		</tbody>
	</table>
</form>
<script>
    let container = document.querySelector('#memberAdd');
    const plusBtn = container.querySelector('#plus1');
    const minusBtn = container.querySelector('#minus1');
    const number = container.querySelector('#count1');

    plusBtn.addEventListener('click',plusClick);
    minusBtn.addEventListener('click',minusClick);

    function minusClick(e){
        let count = Number(number.textContent)
        if(number.textContent>1){
        count = count - 1;
        number.textContent = count;}
    }

    function plusClick(e){
        let count = Number(number.textContent)
        if(number.textContent<9){
        count = count + 1;
        number.textContent = count;}
    }

    let cnt=1;
    let addRowNum=1;
    function addRow(){
        if(addRowNum<4){
        let n=++cnt;
        const tr=document.createElement("tr");
        const td=document.createElement("td");
        const buttonPlus=document.createElement("button");
        buttonPlus.classList.add("count");
        buttonPlus.id="plus"+n;
        buttonPlus.innerHTML='+';
        const span=document.createElement("span");
        span.id="count"+n;
        span.innerHTML='1';
        const buttonMinus=document.createElement("button");
        buttonMinus.classList.add("count");
        buttonMinus.id="minus"+n;
        buttonMinus.innerHTML='-';
        const select=document.createElement("select");
        select.name="job_code";
        select.id="job_code"+n;
        const option = document.createElement("option");
        option.value="planning";
        option.innerText="기획";
        const option2=document.createElement("option");
        option2.value="design";
        option2.innerText="디자인";
        const option3=document.createElement("option");
        option3.value="frontend";
        option3.innerText="프론트엔드";
        const option4=document.createElement("option");
        option4.value="backend";
        option4.innerText="백엔드";
        const td1=document.createElement("td");
        buttonPlus.addEventListener('click',(e)=>{
            while(true){
                const span=document.querySelector("#count"+n);
                const currentN=Number(span.innerHTML);
                if(currentN==9){
                    break;
                }else{
                    span.innerHTML=currentN+1;
                    break;
                }
            }
        });
        buttonMinus.addEventListener('click',(e)=>{
            while(true){
                const span=document.querySelector("#count"+n);
                const currentN=Number(span.innerHTML);
                if(currentN==1){
                    break;
                }else{
                    span.innerHTML=currentN-1;
                    break;
                }
            }
        });
        select.append(option,option2,option3,option4);
        td1.append(select);
        td.append(buttonPlus,span,buttonMinus);
        tr.append(td1,td);
        
        document.querySelector("#memberAdd").insertAdjacentElement("afterend",tr)
        addRowNum+=1;
        }
    };
    
    function deleteRow(){
        if(addRowNum>1){
            var table=document.getElementById("tbl-project-enrollview");
            const delRow=table.deleteRow(table.rows.length-11);
            addRowNum-=1;
        }
    };

    function checkTotal(){
        //모집인원 인원체크, 분야체크 -> 맞으면 값 저장
        let checkError=0;
        let countTotal=0;
        var jobCodes=[];
        for(let j=1;j<=addRowNum;j++){
                const jobCode=document.getElementById("job_code"+j);
                jobCodes[j-1]+=jobCode.value;
            }
        for(let k=0;k<addRowNum;k++){
            for(let m=k+1;m<addRowNum;m++){
                if(jobCodes[k]==jobCodes[m]){
                    alert("중복되는 모집 인원 분야가 있습니다. 분야를 다시 설정해주세요.");
                    checkError+=1;
                }
            }
        }
        for(let i=1;i<=addRowNum;i++){
            const span=document.getElementById("count"+i);
            const currentN=Number(span.innerHTML);
            countTotal+=currentN;
        }
        if(countTotal>9){
            alert("총 인원 수가 9명이 넘습니다. 인원을 다시 설정해주세요.");
            checkError+=1;
        }
        if(checkError==0){
            alert("저장되었습니다.")
            //값 저장하는 코드 추가
            //저장 안할 경우 폼 제출 불가능하도록 설정
            //저장 버튼 누르고 값 수정할 경우 확인
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
                uploadSummernoteImageFile(files[i],
                this);
                        }
                    }
                }
             };
    
            $('#summernote').summernote(setting);
            });
    function saveContent(){
        var summernoteContent = $('#summernote').summernote('code');        //썸머노트(설명)
        console.log("summernoteContent : "+summernoteContent);
    }

    document.projectEnrollFrm.onsubmit = (e) => {
	const frm = e.target;
	//제목을 작성하지 않은 경우 폼제출할 수 없음.
	if(!/^.+$/.test(frm.title.value)){
		alert("제목을 작성해주세요.");
		frm.title.focus();
		return false;
	}
	
	//내용을 작성하지 않은 경우 폼제출할 수 없음.
	if(!/^(.|\n)+$/.test(frm.editordata.value)){
		alert("내용을 작성해주세요.");
		frm.editordata.focus();	
		return false;
	}

	return true;
}

</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>