// --------------------- 비밀번호 찾기(비밀번호 재설정)--------------------------
const resetPwd2 = document.getElementById("resetPwd2");

const pwd1GuideArea = document.getElementById("pwd1GuideArea");
const pwd1GuideLine1 = document.getElementById("pwd1GuideLine1");
const pwd1GuideLine2 = document.getElementById("pwd1GuideLine2");
const pwd2GuideArea = document.getElementById("pwd2GuideArea");
const pwd2GuideLine = document.getElementById("pwd2GuideLine");

const checkArr = [
  pwd1GuideLine1,
  pwd1GuideLine2,
  pwd2GuideLine
];
 /**
  * 유효성 검사 결과 출력하는 함수
  */
 const showValidationResult = (input, result, msg) => {
   if (result === "fail") {
     input.firstElementChild.innerHTML = "&#10060";
   } else {
     input.firstElementChild.innerHTML = "&#9989";
   }
   input.className = result;
   input.lastElementChild.innerHTML = msg;
   input.style.fontSize="13px";
 };

 /**
  * 유효성 검사 통과 여부에 따라 input태그 색상 변경하는 함수
  */
 const inputStyle = (input, color) => {
   input.style.borderBottom = `2px solid ${color}`;
 };
 
 /**
  * 비번 입력값 2개가 서로 일치하는지 확인하는 함수
  */
 const isPwdEqual = () => {
   const pwd1 = resetPwd1.value.trim();
   const pwd2 = resetPwd2.value.trim();

   if (pwd1 !== pwd2) {
     pwd2GuideArea.className = "";
     showValidationResult(pwd2GuideLine, "fail", "비밀번호가 일치하지 않습니다.");
     inputStyle(resetPwd2, "red");
   } else {
     showValidationResult(pwd2GuideLine, "success", "비밀번호가 일치합니다.");
     inputStyle(resetPwd2, "blue");
   }
 };

 resetPwd1.addEventListener("input", (e) => {
   // 비번 재입력 시, 앞서 유효성검사 통과해서 숨김처리 해놓은 가이드라인 다시 드러내기
   pwd1GuideArea.className = "";

   const val = e.target.value.trim();
   const regExp1 = /^[a-zA-Z\d!&/\\*@]{8,16}$/;
   const regExp2 = /[a-zA-Z]/;
   const regExp3 = /\d/;
   const regExp4 = /[!&/\\*@]/;

   if (!(regExp1.test(val) && regExp2.test(val) && regExp3.test(val) && regExp4.test(val))) {
     showValidationResult(pwd1GuideLine1, "fail", "영문, 숫자, 특수문자(!&/\\*@) 조합 (8~16자)");
   } else {
     showValidationResult(pwd1GuideLine1, "success", "영문, 숫자, 특수문자(!&/\\*@) 조합 (8~16자)");
   }

	isPwdContainsId();
	
   // 비번 유효성검사1&2 모두 통과 시, input태그 색상 결정
   if (pwd1GuideLine1.className === "success" && pwd1GuideLine2.className === "success")
     inputStyle(resetPwd1, "blue");
   else {
     inputStyle(resetPwd1, "red");
   }

   // 비번 확인 입력창이 비어있지 않으면, 비번 일치 여부 재확인
   if (resetPwd2.value !== "") {
     isPwdEqual();
   }
 });

 resetPwd1.addEventListener("blur", (e) => {
   if (pwd1GuideLine1.className === "success" && pwd1GuideLine2.className === "success")
     pwd1GuideArea.className = "hide";
 });

 resetPwd2.addEventListener("input", (e) => {
   isPwdEqual();
 });

 resetPwd2.addEventListener("blur", (e) => {
   if (pwd2GuideLine.className === "success") 
     pwd2GuideArea.className = "hide";
 });


 // 비밀번호 보기/숨기기 아이콘
 const pwdShowHide = document.querySelectorAll(".pwd-show-hide");
 pwdShowHide.forEach(function (btn) {
   btn.addEventListener("click", (e) => {
     const pwdInputType = e.target.previousElementSibling.firstElementChild;
     if (pwdInputType.type === "password") {
       pwdInputType.type = "text";
       e.target.classList.remove("fa-eye-slash");
       e.target.classList.add("fa-eye");
       e.target.title="문자 숨기기";
     } else {
       pwdInputType.type = "password";
       e.target.classList.remove("fa-eye");
       e.target.classList.add("fa-eye-slash");
       e.target.title="문자 보이기";
     }
   });
 });

 // 비밀번호 재설정 폼 제출 전 유효성 검사
 document.resetPasswordFrm.onsubmit = (e) => {
	const resetPwd1Val = resetPwd1.value;
	const resetPwd2Val = resetPwd2.value;
	
	let msg;
	checkArr.forEach(function (el) {
	    if (el.className !== "success" || resetPwd1Val === "" || resetPwd2Val === "") {
	      e.preventDefault();
	      msg = "입력사항을 모두 정확히 입력하신 후 비밀번호 재설정이 가능합니다.";
	    }
	});

	if (msg !== undefined) 
    	alert(msg);

  };  