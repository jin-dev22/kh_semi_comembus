<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스터디 등록하기</title>

<!-- include libraries(jQuery, bootstrap) -->
<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<!-- summer note -->
<script src="src/main/webapp/js/summernote/summernote-lite.js"></script>
<script src="src/main/webapp/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet"
	href="src/main/webapp/css/summernote/summernote-lite.css">

<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/gathering/Enroll.css">
</head>
<body>
	<form name="projectEnrollFrm"
		action="<%=request.getContextPath()%>/gathering/studyEnrollView"
		method="post" enctype="multipart/form-data">
		<table id="tbl-project-enrollview">
			<tbody>
				<tr>
					<th>*스터디명</th>
				</tr>
				<tr>
					<td colspan="3">❗ 스터디 제목을 적어주세요</td>
				</tr>
				<tr>
					<td colspan="3" id="name"><input type="text" name="title" placeholder="3~20자로 적어주세요" style="width:900px;" required></td>
				</tr>
				<tr></tr>
				<tr>
					<th>*스터디 분야</th>
				</tr>
				<tr>
					<td colspan="3">❗ 분야를 한가지만 선택해주세요. 추후 변경 불가능</td>
				</tr>
				<tr>
					<td colspan="3" id="topic"><input type="radio" name="Planning">기획
						<input type="radio" name="Design">디자인 <input type="radio"
						name="Frontend">프론트엔드 <input type="radio" name="Backend">백엔드
						<input type="radio" name="Interview">면접 <input
						type="radio" name="Codingtest">코딩테스트</td>
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
					<td colspan="3">❗ 3~4명을 추천합니다. (최대 9명까지 가능)</td>
				</tr>
				<tr>
					<td width="200px" colspan="3">
						<div id="container">
							<button class="count" id="plus">+</button>
							<span id="count">1</span>
							<button class="count" id="minus">-</button>

						</div>
					</td>
					<td id="plus"></td>
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
					<th colspan="2"><br> <input type="submit" value="등록하기"></th>
				</tr>
			</tbody>
		</table>
	</form>
	</section>
</body>
<script>
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
	});
	minusBtn.addEventListener('click', function() {
		let count = Number(number.textContent)
		if (number.textContent > 1) {
			count = count - 1;
			number.textContent = count;
		}
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
</script>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>