const enrollId = document.getElementById("enrollId");
const enrollPwd1 = document.getElementById("enrollPwd1");
const enrollPwd2 = document.getElementById("enrollPwd2");
const enrollName = document.getElementById("enrollName");
const enrollNickname = document.getElementById("enrollNickname");
const enrollPhone = document.getElementById("enrollPhone");
const jobName = document.getElementById("jobName");

const idGuideArea = document.getElementById("idGuideArea");
const idGuideLine = document.getElementById("idGuideLine");

const pwd1GuideArea = document.getElementById("pwd1GuideArea");
const pwd1GuideLine1 = document.getElementById("pwd1GuideLine1");
const pwd1GuideLine2 = document.getElementById("pwd1GuideLine2");
const pwd2GuideArea = document.getElementById("pwd2GuideArea");
const pwd2GuideLine = document.getElementById("pwd2GuideLine");

const nameGuideArea = document.getElementById("nameGuideArea");
const nameGuideLine = document.getElementById("nameGuideLine");

const nicknameGuideLine = document.getElementById("nicknameGuideLine");

const privacyAgree1Cbx = document.getElementById("privacyAgree1Cbx");
const privacyAgree2Cbx = document.getElementById("privacyAgree2Cbx");
const privacyAgree1 = document.getElementById("privacyAgree1");
const privacyAgree2 = document.getElementById("privacyAgree2");

const inputArr = [
  enrollId,
  enrollPwd1,
  enrollPwd2,
  enrollName,
  enrollNickname,
  enrollPhone,
  jobName,
];

const checkArr = [
  nameGuideLine,
  idGuideLine,
  pwd1GuideLine1,
  pwd1GuideLine2,
  pwd2GuideLine,
  nicknameGuideLine
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


// ----------------------------- 아이디 ---------------------------------------
/**
 * 비번에 아이디가 포함되어있는지 확인하는 함수
 */
 const isPwdContainsId = () => {
  if (enrollPwd1.value.indexOf(enrollId.value) !== -1) {
    if (enrollId.value == "")
      showValidationResult(pwd1GuideLine2, "success", "아이디 사용 제외");
    else 
      showValidationResult(pwd1GuideLine2, "fail", "아이디 사용 제외");
  } else {
    showValidationResult(pwd1GuideLine2, "success", "아이디 사용 제외");
  }
};

// 키보드 입력없이 마우스로 복붙했을 경우에도 유효성 검사할 수 있도록 이벤트속성 'input' 사용
enrollId.addEventListener("input", (e) => {
  idGuideArea.className = "";
  idCheckArea.className = "hide";

  const val = e.target.value;
  const regExp1 = /^[a-z\d]{6,12}$/;
  const regExp2 = /[a-z]/;
  const regExp3 = /[\d]/;

  if (!(regExp1.test(val) && regExp2.test(val) && regExp3.test(val))) {
    showValidationResult(idGuideLine, "fail", "영어(소문자), 숫자 조합 6~12자  (특수문자 사용 불가)");
    inputStyle(enrollId, "red");
  } else {
    showValidationResult(idGuideLine, "success", "영어(소문자), 숫자 조합 6~12자  (특수문자 사용 불가)");
    inputStyle(enrollId, "blue");
  }

  // 비번 입력 후 아이디 변경 시, 비번에 아이디 포함되어있는지 재확인
  isPwdContainsId();
});


// ----------------------------- 비밀번호 ---------------------------------------
/**
 * 비번 입력값 2개가 서로 일치하는지 확인하는 함수
 */
const isPwdEqual = () => {
  const pwd1 = enrollPwd1.value.trim();
  const pwd2 = enrollPwd2.value.trim();

  if (pwd1 !== pwd2) {
    pwd2GuideArea.className = "";
    showValidationResult(pwd2GuideLine, "fail", "비밀번호가 일치하지 않습니다.");
    inputStyle(enrollPwd2, "red");
  } else {
    showValidationResult(pwd2GuideLine, "success", "비밀번호가 일치합니다.");
    inputStyle(enrollPwd2, "blue");
  }
};

enrollPwd1.addEventListener("input", (e) => {	
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

  // 비번에 아이디 포함되어있는지 확인
  isPwdContainsId();

  // 비번 유효성검사1&2 모두 통과 시, input태그 색상 결정
  if (pwd1GuideLine1.className === "success" && pwd1GuideLine2.className === "success")
    inputStyle(enrollPwd1, "blue");
  else {
    inputStyle(enrollPwd1, "red");
  }

  // 비번 확인 입력창이 비어있지 않으면, 비번 일치 여부 재확인
  if (enrollPwd2.value !== "") {
    isPwdEqual();
  }
	
  e.target.style.fontFamily = "auto";
});

enrollPwd1.addEventListener("blur", (e) => {
  if (pwd1GuideLine1.className === "success" && pwd1GuideLine2.className === "success")
    pwd1GuideArea.className = "hide";
});

enrollPwd2.addEventListener("input", (e) => {
  isPwdEqual();
  e.target.style.fontFamily = "auto";
});

enrollPwd2.addEventListener("blur", (e) => {
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


// ----------------------------- 이름 ---------------------------------------
enrollName.addEventListener("input", (e) => {
  // 재입력하게 되는 경우, 앞서 유효성검사 통과해서 숨김처리해놓은 가이드라인 다시 드러냄
  nameGuideArea.className = "";

  const val = e.target.value;
  const regExp = /^[가-힣]{2,}$/;


  if (!regExp.test(val)) {
    showValidationResult(nameGuideLine, "fail", "한글 2자 이상");
    inputStyle(enrollName, "red");
  } else {
    showValidationResult(nameGuideLine, "success", "한글 2자 이상");
    inputStyle(enrollName, "blue");
  }
});

enrollName.addEventListener("blur", (e) => {
  if (nameGuideLine.className === "success") 
    nameGuideArea.className = "hide";
});


// ----------------------------- 닉네임 ---------------------------------------
enrollNickname.addEventListener("input", (e) => {
  nicknameGuideArea.className = "";
  nicknameCheckArea.className = "hide";

  const val = e.target.value;
  const regExp1 = /^[가-힣\d]{3,10}$/;
  const regExp2 = /[가-힣]+/;
  const regExp3 = /[\d]*/;

  if (!(regExp1.test(val) && regExp2.test(val) && regExp3.test(val))) {
    showValidationResult(
      nicknameGuideLine,
      "fail",
      "한글(필수), 숫자(선택) 조합 (3~10자). 특수문자 사용 불가"
    );
    inputStyle(enrollNickname, "red");
  } else {
    showValidationResult(
      nicknameGuideLine,
      "success",
      "한글(필수), 숫자(선택) 조합 (3~10자). 특수문자 사용 불가"
    );
    inputStyle(enrollNickname, "blue");
  }

});

enrollNickname.addEventListener("blur", (e) => {
  if (nicknameGuideLine.className === "success") 
    nicknameGuideArea.className = "hide";
});

// ----------------------------- 핸드폰 번호 ---------------------------------------
enrollPhone.addEventListener("input", (e) => {
  phoneGuideArea.className = "";

  const val = e.target.value;
  const regExp = /^(010){1}[0-9]{7,8}$/;

  if (!(regExp.test(val))) {
    showValidationResult(
      phoneGuideLine,
      "fail",
      "올바른 핸드폰 번호 형식(- 제외)"
    );
    inputStyle(enrollPhone, "red");
  } else {
    showValidationResult(
      phoneGuideLine,
      "success",
      "올바른 핸드폰 번호 형식(- 제외)"
    );
    inputStyle(enrollPhone, "blue");
  }

});

enrollPhone.addEventListener("blur", (e) => {
  if (phoneGuideLine.className === "success") 
    phoneGuideArea.className = "hide";
});


// ----------------------------- 약관 동의 ---------------------------------------
privacyAgree1.addEventListener("click", (e) => {
	privacyAgree1Cbx.checked = privacyAgree1Cbx.checked === true ? false : true;
});

privacyAgree2.addEventListener("click", (e) => {
	privacyAgree2Cbx.checked = privacyAgree2Cbx.checked === true ? false : true;
});


// ----------------------------- 폼 제출 전 확인 ---------------------------------------
document.enrollFrm.onsubmit = (e) => {
  // input태그 입력 안 되어 있으면 스타일 적용
  inputArr.forEach(function (el) {
    if (el.value.length === 0) 
      inputStyle(el, "red");
  });

  let msg;
  checkArr.forEach(function (el) {
    if (el.className !== "success") {
      e.preventDefault();
      msg = "필수정보를 모두 올바르게 입력해주세요.";
    }
  });

  if (msg !== undefined) 
    alert(msg);

  if (jobName.value === "")
    e.preventDefault();

  if (privacyAgree1Cbx.checked !== true || privacyAgree2Cbx.checked !== true) {
    e.preventDefault();
    alert("필수 약관에 모두 동의하셔야 회원가입이 가능합니다.");
  }
};