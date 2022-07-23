<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	int memberEnrollNumToday = (int) request.getAttribute("memberEnrollNumToday");
	int totalMemberNum = (int) request.getAttribute("totalMemberNum");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String today = sdf.format(new Date());
%>

<section class="statistics">

	<h1>통계관리</h1>
	
	<div class="statistics-container">
	
	<div class="member-enroll-statistics">
	    <span class="statistics-title">오늘 가입회원 수</span>
	    <span class="statistics-num"><%= memberEnrollNumToday %>명</span>
	    <span class="statistics-date" id="today" data-today="<%= today %>">기준일시: <%= today %></span>
	</div>
	
	<div class="member-enroll-statistics">
	    <span class="statistics-title">전체 회원 수</span>
	    <span class="statistics-num" id="totalMemberNum"><%= totalMemberNum %>명</span>
	</div>
	
	<div class="preiod-statistics-container">
		<label for="startDate">조회 시작일: </label>
	    <input type="date" class="date-input" name="startDate" id="inputStartDate" />
	    <label for="endDate">조회 마지막일: </label>
	    <input type="date" class="date-input" name="endDate" id="inputEndDate" />
	    <input type="button" id="statisticsViewBtn" value="조회하기" onclick="memberEnrollNumPeriod();"/>
	
	    <div class="member-enroll-statistics">
	        <span class="statistics-title">기간별 가입회원 수</span>
	        <span class="statistics-num" id="memberEnrollNumPeriod"></span>
	        <div class="statistics-date">
		        <span id="startDate"></span>
		        <span id="endDate"></span>
	        </div>
	    </div>
	</div>

</div>
</section>

<script>
const inputStartDate = document.querySelector("#inputStartDate");
const inputEndDate = document.querySelector("#inputEndDate");
const today = document.querySelector("#today").dataset.today;

console.log(today);
inputStartDate.addEventListener('change', (e) =>{
	if(inputStartDate.value > today){
		alert("오늘 이후의 날짜는 선택하실 수 없습니다.");
		inputStartDate.value = '';
	}
	else if(inputEndDate.value !== ''){
		if(inputStartDate.value > inputEndDate.value){
			alert("조회 기간을 정확히 선택해주세요.");
			inputStartDate.value = '';
		}
	}
});

inputEndDate.addEventListener('change', (e) =>{
	if(inputEndDate.value > today){
		alert("오늘 이후의 날짜는 선택하실 수 없습니다.");
		inputEndDate.value = '';
	}
	else if(inputStartDate.value !== ''){
		if(inputStartDate.value > inputEndDate.value){
			alert("조회 기간을 정확히 선택해주세요.");
			inputEndDate.value = '';
		}
	}
});

function memberEnrollNumPeriod(){
	const inputStartDate = document.querySelector("#inputStartDate").value;
	const inputEndDate = document.querySelector("#inputEndDate").value;
	
	const startDate = document.querySelector("#startDate");
	const endDate = document.querySelector("#endDate");
	$.ajax({
		type : 'GET',
		url: '<%= request.getContextPath() %>/admin/memberEnrollNumPeriod',
		data : {inputStartDate, inputEndDate},
		success(result){
			console.log(result);
			document.querySelector("#memberEnrollNumPeriod").innerHTML = result + '명';
			startDate.innerHTML = '기간: ' + inputStartDate;
			endDate.innerHTML = ' ~ ' + inputEndDate;
		},
		error: console.log
	});
}
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>
