<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="kh.semi.comembus.gathering.model.dto.Gathering"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/gathering/ProjectView.css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 상세보기</title>
</head>
<body>
<p class="pjname">프로젝트명</p>
<p class="pjwriter"><img src="/멤버 이미지.png" alt="멤버아이디">우리는코하</p>
<!--지원자 현황은 글쓴이=로그인한 사용자 일치할 때만 보이게 하기-->
<button id="pjdetail"><a href="/projectDetailView.jsp">프로젝트 상세</a></button><button id="pjstatue"><a href="/projectApplicantStatue.jsp">지원자 현황</a></button>
<br>
<hr>
<h3>모집 현황</h3>
<table>
    <tr>
        <td>기획</td>
        <td><span id="statue">1</span>/<span id="total">2</span></td>
        <td><button id="apply" onclick="apply();">지원하기</button></td>
    </tr>
    <tr>
        <td>프론트엔드</td>
        <td><span id="statue">1</span>/<span id="total">1</span></td>
        <td><button onclick="apply();">지원하기</button></td>
    </tr>
    <tr>
        <td>백엔드</td>
        <td><span id="statue">1</span>/<span id="total">2</span></td>
        <td><button onclick="apply();">지원하기</button></td>
    </tr>
</table>
<h3>프로젝트 주제</h3>
<h5>이커머스</h5>

<h3>프로젝트 진행지역</h3>
<h5>온라인</h5>

<h3>프로젝트 설명</h3>
<p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Corrupti accusantium eveniet cumque molestiae in, dignissimos, assumenda eius earum, veniam deserunt possimus natus voluptate. Fugiat eaque natus, cupiditate reiciendis a commodi? Lorem ipsum dolor sit amet consectetur adipisicing elit. Ratione doloremque qui, numquam eius corporis totam omnis minus nisi ipsa minima amet maiores voluptas. Saepe dolores ad, delectus quod laborum exercitationem. Lorem, ipsum dolor sit amet consectetur adipisicing elit. Rem sit aspernatur incidunt in eveniet aperiam? Illo nisi optio dolor explicabo fuga laboriosam dicta. Nulla provident iure maxime consequatur laudantium maiores. Lorem ipsum dolor sit amet consectetur, adipisicing elit. Et a ipsa reiciendis vel cum saepe sequi illo, repellat autem assumenda rerum beatae, voluptatibus rem neque magni, in excepturi ullam est.</p>
<br><br><br>
<hr>
<h3>이 프로젝트를 찜한 사람<span id="bookmarkCount">7</span>명</h3>
<div id="list">
    <table id="listBm">
        <tbody>
            <tr>
                <td><img src="/멤버 이미지.png" alt="멤버아이디"></td>
                <td><img src="/멤버 이미지.png" alt="멤버아이디"></td>
                <td><img src="/멤버 이미지.png" alt="멤버아이디"></td>
                <td><img src="/멤버 이미지.png" alt="멤버아이디"></td>
                <td><img src="/멤버 이미지.png" alt="멤버아이디"></td>
                <td><img src="/멤버 이미지.png" alt="멤버아이디"></td>
                <td><img src="/멤버 이미지.png" alt="멤버아이디"></td>
            </tr>
        </tbody>
    </table>
</div>

<input type="button" id="bookmark" onclick="bookmark()" value="이 프로젝트 찜하기"></input><input type="button" id="bookmarkCancel" onclick="bookmarkCancel()" value="프로젝트 찜하기 취소"></input>
<br><br><br><br>
<!--로그인 했을 경우에만 되도록 설정하기-->
<button>수정</button><button>삭제</button>
</body>
<script>
const bookmarkNum=document.querySelector('#bookmarkCount');
const bmBtn=document.querySelector('#bookmark');
const bmCancelBtn=document.querySelector('#bookmarkCancel');
const table=document.getElementById('listBm');
bmCancelBtn.style.display='none';
let bmCount=0;

function bookmark(){
    if(bmCount==0){
    let count=Number(bookmarkNum.textContent)
    count=count+1;
    bookmarkNum.textContent=count;
    bmCount+=1;
    }
    if(bmBtn.style.display!=='none'){
        bmBtn.style.display='none';
        bmCancelBtn.style.display='block';
    }
    for(let i=0;i<table.rows.length;i++){
        const newCell=table.rows[i].insertCell(-1);
        newCell.innerHTML='<td><img src="/멤버 이미지.png" alt="멤버아이디"></td>'
    }
}
function bookmarkCancel(){
    if(bmCount==1){
        let count=Number(bookmarkNum.textContent)
        count-=1;
        bookmarkNum.textContent=count;
        bmCount-=1;
    }
    if(bmCancelBtn.style.display!=='none'){
        bmCancelBtn.style.display='none';
        bmBtn.style.display='block';
    }
    for(let i=0;i<table.rows.length;i++){
        const newCell=table.rows[i].deleteCell(-1);
    }
}

const applyStatue=document.querySelector('#statue');
const applyTotal=document.querySelector('#total');
if(cntStatue==cntTotal){
    const target=document.getElementById('apply');
    target.disabled=true;
    //처음부터 지원이 불가능한 경우 작성하기
}
function apply(){
    if(confirm("지원 하시겠습니까?")){
        alert("지원이 완료되었습니다.");
        let cntStatue=Number(applyStatue.textContent)
        let cntTotal=Number(applyTotal.textContent)
        if(cntStatue<cntTotal){
            cntStatue+=1;
            applyStatue.textContent=cntStatue;
        }
        if(cntStatue==cntTotal){
            const target=document.getElementById('apply');
            target.disabled=true;
        }
        //로그인 한 회원의 정보(id)전달 
    }
    else{
        alert("지원이 취소되었습니다.");
    }
}


</script>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>