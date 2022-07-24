<%@page import="java.text.SimpleDateFormat"%>
<%@page import="kh.semi.comembus.gathering.model.dto.Gathering"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/gathering/gatheringEnroll.css">
<%
	Gathering gathering = (Gathering) request.getAttribute("study");

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String startDate = sdf.format(gathering.getStartDate());
	String endDate = sdf.format(gathering.getEndDate());
%>
	<form name="studyEnrollFrm"
		action="<%=request.getContextPath()%>/gathering/studyUpdateView"
		method="post">
		<table id="tbl-study-enrollview">
			<tbody>
				<tr>
					<th>*스터디명</th>
				</tr>
				<tr>
					<td colspan="3">❗ 스터디 제목을 적어주세요</td>
				</tr>
				<tr>
					<td colspan="3" id="name"><input type="text" name="title" value="<%= gathering.getTitle() %>" required></td>
				</tr>
				<tr></tr>
				<tr>
					<th>*스터디 분야</th>
				</tr>
				<tr>
					<td colspan="3">스터디분야는 변경 불가능합니다.</td>
				</tr>
				<tr>
					<td><%= gathering.getTopic() %></td>
				</tr>
				<tr></tr>
				<tr>
					<th>*지역</th>
				</tr>
				<tr>
					<td colspan="3">❗ 지역을 선택해 주세요</td>
				</tr>
				<tr>
					<td><select name="local" id="local" value="<%= gathering.getLocal() %>">
							<option value="Online">온라인</option>
							<option value="Capital">수도권</option>
							<option value="Gangwon">강원도</option>
							<option value="Chungcheong">충청도</option>
							<option value="Jeolla">전라도</option>
							<option value="Gyeongsang">경상도</option>
							<option value="Jeju">제주도</option>
					</select></td>
				</tr>
				<tr></tr>
				<tr>
					<th>*모집인원</th>
				</tr>
				<tr>
					<td colspan="3" >❗ 3~4명을 추천합니다. (최대 9명까지 가능)</td>
				</tr>
				<tr>
					<td width="200px" colspan="3">
						<div id="container">
							<input type="button" class="count" id="plus" value="+">
							<span id="count"><%= gathering.getPeople() %></span>
							<!-- <span id="people"></span> -->
							<input type="button" class="count" id="minus" value="-">

						</div>
					</td>
 				</tr>
				<tr></tr>
				<tr>
					<th>*기간 설정</th>
				</tr>
				<tr>
					<td colspan="3">❗ 날짜는 시작일 전까지 수정이 가능합니다.</td>
				</tr>
		        <tr>
		            <td class="date">
		               시작일 
		            </td>
		            <td colspan="2">
		                <p><input type="date" name="date_start" id="date_start" value="<%= startDate %>"></p>
		            </td>
		        </tr>
		        <tr>
		            <td class="date">
		                종료일
		            </td>
		            <td colspan="2">
		                <p><input type="date" name="date_end" id="date_end" value="<%= endDate %>"></p>
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
							<textarea id="summernote" name="editordata"><%= gathering.getContent()%></textarea>
						</div>
					</td>
				</tr>
				<tr></tr>
				<tr><th><input type="hidden" name="psNo" value="<%= gathering.getPsNo() %>"></th></tr>
				<tr><th><input type="hidden" name="psType" value="S"></th></tr>
        		<tr><th><input type="hidden" name="writer" value="<%= loginMember.getMemberId() %>"/></th></tr>
                <tr>
                    <th colspan="2">
                        <br><input type="submit" id="submitS" value="수정하기">
                    </th>
                </tr>
			</tbody>
			<tfoot>
				<tr>
					<th colspan="2">
 						<input type="hidden" name="people" id="people" />
					</th>
				</tr>
			</tfoot>
		</table>
	</form>
</body>
<script>

	var now_date = Date.now()
	var timeoff=new Date().getTimezoneOffset()*60000;
	var today=new Date(now_date-timeoff).toISOString().split("T")[0];
	
	document.getElementById("date_start").setAttribute("min",today);
	document.getElementById("date_end").setAttribute("min",today);
		
	let container = document.querySelector('#container');
	const plusBtn = container.querySelector('#plus');
	const minusBtn = container.querySelector('#minus');
	const number = container.querySelector('span');

	plusBtn.addEventListener('click', function() {
		let count = Number(number.textContent)
		if (number.textContent < 9) {
			count = count + 1;
			number.textContent = count;
		}
		document.getElementById("people").value=count;
		console.log(document.getElementById("people").value);
	});
	minusBtn.addEventListener('click', function() {
		let count = Number(number.textContent)
		if (number.textContent > 1) {
			count = count - 1;
			number.textContent = count;
		}
		document.getElementById("people").value=count;
		console.log(document.getElementById("people").value)
	});
	document.getElementById("people").value=number.textContent;

	
    $("#summernote").summernote({
        height: 500,
        width: 900,
	    focus: true,
	    disableResizeEditor: true,
	    
	    
	   });
    $('#summernote').summernote('pasteHTML', data);

    document.studyEnrollFrm.onsubmit = (e) => {
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
    	
        //시작일이 종료일보다 늦은경우 폼제출할 수 없음.
        const startDate = document.getElementById("date_start").value;
        const endDate = document.getElementById("date_end").value;
        if(startDate>=endDate){
        	alert("시작일이 종료일보다 늦거나 같습니다.");
        	return false;
        }
    	
    	return true;
    }
</script>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>