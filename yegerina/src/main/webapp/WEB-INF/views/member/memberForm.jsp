<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

</head>
<body>

    <form class="join_us" name="join_us" action="${contextPath}/member/addMember.do" method="post">
        <h3 style="margin: 70px 0px 20px 0px;">회원가입</h3>

        <table class="outLoginTable">
            <tr>
            	<td class="outLogin">
            		sns계정으로 회원가입
            	</td>
            </tr>
            <tr class="outLogin_container">
            	<td class="outLogin_container">
            		<div class="naver_join">
            			<img alt="" src="${contextPath }/resources/image/naver_icon.png">
	            		<a href="https://nid.naver.com/nidlogin.login?mode=form&url=https://www.naver.com/">
	            			네이버로 로그인
	            		</a> 
            		</div>
            		<div class="kakao_join">
            			<img alt="" src="${contextPath }/resources/image/kakao_icon.png">
	            		<a href="https://accounts.kakao.com/login/?continue=https%3A%2F%2Fcs.kakao.com%2Fhelps%3Fcategory%3D25">
	            			카카오로 로그인
	            		</a> 
            		</div>
            	</td>
            </tr>            
        </table>
		<br>
		<br>

        <div class="basicInf">
           	 기본정보
        </div>


        <div id="detail_memberinfo_container">
        	<table class="join_us_Form">
            	<tbody>
               		<tr class="dot_line">
	                    <td >&nbsp;&nbsp;아이디</td>
	                    <td>
	                      <input type="text" id="memberId" name="memberId" size="20" />                         
                          <input type="button"  id="btnOverlapped" value="중복체크" size="5" onClick="checkDuplicateId()" />
	                      <span id="IDRequirements" style="font-size: 12px; color: gray;">&nbsp;(영문 소문자/숫자. 8~16자)</span>
                          <span id="idValidationMessage" style="font-size: 12px;"></span>
	                    </td>
	                </tr>
	                
                    <tr class="dot_line">
                        <td >&nbsp;&nbsp;이름</td>
                        <td><input name="memberName" type="text" size="20" /></td>
                    </tr>

                    <tr class="dot_line">
                        <td >&nbsp;&nbsp;비밀번호</td>
                        <td>
                        	<input name="memberPw" id="password" type="password" size="20" /> 
                        	<span id="passwordRequirements" style="font-size: 12px; color: gray;">&nbsp;(영문 대소문자/숫자/특수문자 중 2가지 이상 조합. 8~16자)</span>
                        </td>
                    </tr>
                    <tr class="dot_line">
                        <td >&nbsp;&nbsp;비밀번호 확인</td>
                        <td><input id="passwordConfirm" name="memberPwConfirm" type="password" size="20" on/>&nbsp;<span id="passwordMismatch" style="color: red; font-size: 12px;"></span></td>
                    </tr>

                    <tr class="dot_line">
                        <td >&nbsp;&nbsp;휴대폰번호</td>
                        <td> <input type="text" name="hp1" placeholder=" - 포함해서 작성"></td>
                    </tr>

                    <tr class="dot_line">
                        <td >&nbsp;&nbsp;주소</td>
                        <td>
                           <input type="text" id="zipcode" name="zipcode" size="10" placeholder="우편번호" > <a class="search_address_btn" href="javascript:execDaumPostcode()">주소검색</a>
                          <br><input type="text" id="address"  name="address" size="50" placeholder="기본주소"><br>
                          <input type="text" id="subaddress" name="subaddress" size="50" placeholder="상세주소">
                          <!--   <span id="guide" style="color:#999"></span> -->
                        </td>
                        
                    </tr>
      	      	</tbody>
            </table>
        </div>
            
        <table align=center style="margin: 10px auto;">
        	<tr >
            	<td >
                	<input id="join_us_btn" type="submit"  value="회원 가입">
                </td>
            </tr>
        </table>
    </form>	

<script type="text/javascript">


	//아이디 입력란 요소와 메시지 요소 가져오기
	var memberIdInput = document.getElementById("memberId");
	var idRequirementsMessage = document.getElementById("IDRequirements");
	
	// 아이디 입력란 값 변경 시 체크 함수 호출
	memberIdInput.addEventListener("input", checkIdRequirements);
	
	// 아이디 조건 체크 함수
	function checkIdRequirements() {
	    var memberId = memberIdInput.value;
	
	    // 정규 표현식을 사용하여 조건 체크
	    var meetsRequirements = /^[a-z0-9]{8,16}$/.test(memberId);
	
	    if (meetsRequirements) {
	        idRequirementsMessage.style.color = "green";
	    } else {
	        idRequirementsMessage.style.color = "red";
	    }
	}

	function checkDuplicateId() {
	    var memberIdInput = document.getElementById("memberId");
	    var idValidationMessage = document.getElementById("idValidationMessage");
	    var memberId = memberIdInput.value;

	    // AJAX를 사용하여 서버에 아이디 중복 체크 요청
	    $.ajax({
	        type: "GET",
	        url: "${contextPath}/member/checkDuplicateId.do", // 실제 서버 URL로 변경
	        data: { memberId: memberId },
	        success: function(response) {
	            if (response === "duplicate") {
	                idValidationMessage.style.color = "red";
	                idValidationMessage.textContent = "존재하는 아이디 입니다.";
	            } else {
	                idValidationMessage.style.color = "green";
	                idValidationMessage.textContent = "사용 가능한 아이디 입니다.";
	            }
	        },
	        error: function() {
	            idValidationMessage.style.color = "red";
	            idValidationMessage.textContent = "서버 오류 발생";
	        }
	    });
	}
	
	
	// 비밀번호 조건 체크 함수
	function checkPasswordRequirements() {
	    var password = document.getElementById("password").value;
	    var requirementsMessage = document.getElementById("passwordRequirements");

	    var hasLowerCase = /[a-z]/.test(password);
	    var hasUpperCase = /[A-Z]/.test(password);
	    var hasDigit = /\d/.test(password);
	    var hasSpecialChar = /[!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]/.test(password);

	    var meetsRequirements =
	        (hasLowerCase + hasUpperCase + hasDigit + hasSpecialChar >= 2) && // 최소 2가지 조합
	        (password.length >= 8 && password.length <= 16); // 8~16자

	    if (meetsRequirements) {
	        requirementsMessage.style.color = "green";
	    } else {
	        requirementsMessage.style.color = "red";
	    }
	}

	// input 값 변경 시 비밀번호 조건 체크 호출
	document.getElementById("password").addEventListener("input", checkPasswordRequirements);
	
	
	// 비밀번호 확인 체크 함수
	function checkPassword() {
	    var password = document.getElementById("password").value;
	    var passwordConfirm = document.getElementById("passwordConfirm").value;
	    var mismatchMessage = document.getElementById("passwordMismatch");

	    if (password === passwordConfirm) {
	        mismatchMessage.textContent = ""; // 일치하는 경우 메시지 삭제
	    } else {
	        mismatchMessage.textContent = "비밀번호가 다릅니다.";
	    }
	}

	// input 값 변경 시 비밀번호 확인 체크 호출
	document.getElementById("password").addEventListener("input", checkPassword);
	document.getElementById("passwordConfirm").addEventListener("input", checkPassword);
	
	
	
	//주소 불러와서 입력란에 넣기
	function execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
				document.getElementById('address').value = data.address;
			}
		}).open();
	}
</script>
</body>
</html>