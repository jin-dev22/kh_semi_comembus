<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=<device-width>, initial-scale=1.0" />
  <title>text</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
   <link rel="stylesheet" href="<%= request.getContextPath() %>/css/member/memberEnroll.css" />
</head>
<body>

  <h2>회원가입</h2>

  <form action="" method="POST" name="enrollFrm">
    <div class="enroll-input-container">
      <div class="enroll-label">
        <label for="enrollId">아이디<span> *</span></label>
      </div>
      <div class="enroll-input">
        <input type="text" id="enrollId" name="enrollId" placeholder="영어(소문자), 숫자 조합 (6~12자)" maxlength="15" />
        <div id="idGuideArea">
          <div id="idGuideLine">
            <span></span>
            <span></span>
          </div>
        </div>

      </div>
      <button type="button">중복검사</button>
    </div>

    <div class="enroll-input-container">
      <div class="enroll-label">
        <label for="enrollPwd1">비밀번호<span> *</span></label>
      </div>
      <div class="enroll-input">
        <input type="password" id="enrollPwd1" name="enrollPwd" placeholder="영문, 숫자, 특수문자 조합 (8~16자)" maxlength="25" />
        <div id="pwd1GuideArea">
          <div id="pwd1GuideLine1">
            <span></span>
            <span></span>
          </div>
          <div id="pwd1GuideLine2">
            <span></span>
            <span></span>
          </div>
        </div>
      </div>
      <i class="fa-solid fa-eye-slash pwd-show-hide" title="문자 보이기"></i>
    </div>

    <div class="enroll-input-container">
      <div class="enroll-label">
        <label for="enrollPwd2">비밀번호 확인<span> *</span></label>
      </div>
      <div class="enroll-input">
        <input type="password" id="enrollPwd2" placeholder="영문, 숫자, 특수문자 조합 (8~16자)" maxlength="25" />
        <div id="pwd2GuideArea">
          <div id="pwd2GuideLine">
            <span></span>
            <span></span>
          </div>      
        </div>
      </div>
      <i class="fa-solid fa-eye-slash pwd-show-hide" title="문자 보이기"></i>
    </div>

    <div class="enroll-input-container">
      <div class="enroll-label">
        <label for="enrollName">이름<span> *</span></label>
      </div>
      <div class="enroll-input">
        <input type="text" id="enrollName" name="enrollName" placeholder="한글 2자 이상" maxlength="11" />
        <div id="nameGuideArea">
          <div id="nameGuideLine">
            <span></span>
            <span></span>
          </div>
        </div>
      </div>
    </div>

    <div class="enroll-input-container">
      <div class="enroll-label">
        <label for="enrollNickname">닉네임<span> *</span></label>
      </div>
      <div class="enroll-input">
        <input type="text" id="enrollNickname" name="enrollNickname" placeholder="한글, 숫자 조합 (3~10자). 특수문자 사용 불가" maxlength="15" />
        <div id="nicknameGuideArea">
          <div id="nicknameGuideLine">
            <span></span>
            <span></span>
          </div>
        </div>
      </div>
      <button type="button">중복검사</button>
    </div>

    <div class="enroll-input-container">
      <div class="enroll-label">
        <label for="enrollPhone">핸드폰번호<span> *</span></label>
      </div>
      <div class="enroll-input">
        <input type="text" id="enrollPhone" name="enrollPhone" placeholder="ex) 01012345678" maxlength="15" />
        <div id="phoneGuideArea">
          <div id="phoneGuideLine">
            <span></span>
            <span></span>
          </div>
        </div>
      </div>
    </div>

    <div class="enroll-input-container">
      <div>
        <div class="enroll-label">
          <label>직무분야<span> *</span></label>
        </div>
        <div class="enroll-input">
            <select id="jobName" name="jobCode" class="select-options">
              <option value="" disabled selected>직무분야</option>
              <option value="PL">기획</option>
              <option value="DG">디자인</option>
              <option value="FE">프론트엔드</option>
              <option value="BE">백엔드</option>
            </select>
        </div>
      </div>
    </div>

    <div class="enroll-agreement-container">
      <textarea name=""  cols="50" rows="5" style="resize: none">test
        test
        test
        test
        test
      </textarea>
      <div class="agree-sentence">
        <input type="checkbox" id="privacyAgree1" name="agreeCheckBox" class="agree-check-box"/>
        <label for="privacyAgree" >(필수) 서비스 이용약관에 동의합니다.</label>
      </div>
    </div>

    <div class="enroll-agreement-container">
      <textarea name="" cols="50" rows="5" style="resize: none">test
        test
        test
        test
        test
      </textarea>
      <div class="agree-sentence">
        <input type="checkbox" id="privacyAgree2" name="agreeCheckBox" class="agree-check-box"/>
        <label for="privacyAgree" >(필수) 개인정보 수집 및 이용약관에 동의합니다.</label>
      </div>
    </div>

    <div class="enrollBtn">
      <button type="submit" id="enrollBtn" class="enrollBtnClick">가입하기</button>
    </div>

  </form>

  <script src="<%= request.getContextPath() %>/js/member/memberEnroll.js"></script>
  </body>
</html>
