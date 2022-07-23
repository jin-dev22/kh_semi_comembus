<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="kh.semi.comembus.gathering.model.dto.Gathering"%>
<%@page import="kh.semi.comembus.gathering.model.dto.GatheringExt" %>
<%@page import="kh.semi.comembus.member.model.dto.Member" %>
<%@page import="kh.semi.comembus.member.model.dto.MemberExt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
/* Gathering gathering = (Gathering) request.getAttribute("project"); */
   GatheringExt gathering = (GatheringExt) request.getAttribute("study");

%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/gathering/ProjectView.css" />
<p class="stname"><%= gathering.getTitle() %></p><!-- 프로젝트명 -->
<p class="stwriter"><img src="/멤버 이미지.png" alt="멤버아이디"><%= gathering.getWriter() %></p>
<!--지원자 현황은 글쓴이=로그인한 사용자 일치할 때만 보이게 하기-->
<button id="stdetail"><a href="#">모임 상세</a></button><button id="ststatue"><a href="<%=request.getContextPath() %>/gathering/showApplicants?psNo=<%= gathering.getPsNo()%>">지원자 현황</a></button>
<br>
<hr>
<h3>모집 현황</h3>
<table>
    <tr>
        <td>총 인원</td>
        <td><span id="statue"><%= gathering.getRecruited_cnt()%></span>/<span id="total"><%= gathering.getPeople() %></span></td>
    </tr>
    <tr>
        <td><input type="button" id="apply" value="지원하기" onclick="applyStatus()"></td>
    </tr>
</table>
<h3>스터디 주제</h3>
<h5><%= gathering.getTopic() %></h5>

<h3>스터디 진행지역</h3>
<h5><%= gathering.getLocal() %></h5>

<h3>스터디 설명</h3>
<p><%= gathering.getContent() %></p>
<br><br><br>
<hr>
<input type="button" id="bookmark" onclick="bookmark()" value="이 프로젝트 찜하기"></input>
<input type="button" id="bookmarkCancel" onclick="bookmarkCancel()" value="프로젝트 찜하기 취소"></input>
<br><br><br><br>
<!--로그인 했을 경우+작성자일 경우에만 되도록 설정하기-->
<%if(loginMember != null && gathering.getWriter() == loginMember.getMemberId()){ %>
<button>수정</button><button>삭제</button>
<%} %>
</body>
<script>
const bmBtn=document.querySelector('#bookmark');
const bmCancelBtn=document.querySelector('#bookmarkCancel');
bmCancelBtn.style.display='none';

function bookmark(){
    if(bmBtn.style.display!=='none'){
        bmBtn.style.display='none';
        bmCancelBtn.style.display='block';
    }
}

function bookmarkCancel(){
    if(bmCancelBtn.style.display!=='none'){
        bmCancelBtn.style.display='none';
        bmBtn.style.display='block';
    }
}

const applyStatue=document.querySelector('#statue');
const applyTotal=document.querySelector('#total');
if(cntStatue==cntTotal){
    const target=document.getElementById('apply');
    target.disabled=true;
    //처음부터 지원이 불가능한 경우 작성하기
}
function applyStatus(){
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