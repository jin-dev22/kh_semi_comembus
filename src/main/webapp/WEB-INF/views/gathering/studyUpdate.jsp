<%@page import="kh.semi.comembus.gathering.model.dto.Gathering"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%
	Gathering gathering = (Gathering) request.getAttribute("study");
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
		                <p><input type="date" name="date_start" id="date_start" value="<%= gathering.getStartDate() %>"></p>
		            </td>
		        </tr>
		        <tr>
		            <td class="date">
		                종료일
		            </td>
		            <td colspan="2">
		                <p><input type="date" name="date_end" id="date_end" value="<%= gathering.getEndDate() %>"></p>
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
                        <br><input type="submit" value="수정하기">
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
	document.getElementById("date_start").setAttribute("value",today);
	document.getElementById("date_end").setAttribute("min",today);
	document.getElementById("date_end").setAttribute("value",today);
		
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
	
	$(document)
			.ready(
					function() {
						var toolbar = [
								// 글꼴 설정
								[ 'fontname', [ 'fontname' ] ],
								// 글자 크기 설정
								[ 'fontsize', [ 'fontsize' ] ],
								// 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
								[
										'style',
										[ 'bold', 'italic', 'underline',
												'strikethrough', 'clear' ] ],
								// 글자색
								[ 'color', [ 'forecolor', 'color' ] ],
								// 표만들기
								[ 'table', [ 'table' ] ],
								// 글머리 기호, 번호매기기, 문단정렬
								[ 'para', [ 'ul', 'ol', 'paragraph' ] ],
								// 줄간격
								[ 'height', [ 'height' ] ] ];

						var setting = {
							placeholder : '<strong>1. 스터디 목표와 진행방식</strong> <br> - 목표를 적어주세요<br> (ex. 하반기 공채/수시 합격을 목표로 합니다.) <br> - 진행 방식을 적어주세요 <br> (ex - 강남역 ㅇㅇ스터디 주 1회 (요일 협의)) <br>(ex - 매주 기업 선정, 질문리스트와 면접 연습 및 복기. 벌금제도 보증금10000원, 지각 -1000원, 결석 -3000원)<br><br> <strong> 2. 참여 조건</strong> <br> - 참여 조건을 자세히 적어주세요. <br>(ex - 현재 하반기 공채 지원 예정인 분들만 모집합니다.) <br>(ex - 백엔드 SPRING을 집중적으로 공부할 사람을 모집합니다.)<br><br> <strong>3. 그외 자유 기재</strong> <br>(ex - 참여를 원하시는 분은 신청하시면 오픈카톡 링크를 드립니다.)<br>',
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