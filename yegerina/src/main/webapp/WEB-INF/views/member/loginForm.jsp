<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<!-- JSP 페이지의 속성을 설정, 여기서 설정한 내용은 해당 JSP 페이지의 전체 범위에서 적용 -->	
<!-- language="java" : JSP 페이지 내에서 사용할 스크립트 언어를 지정 -->
<!-- contentType="text/html; charset=utf-8 : 해당 JSP 페이지의 출력 내용은 HTML 형식, 문자 인코딩은 UTF-8로 설정 -->
<!-- pageEncoding="utf-8" : JSP 페이지 내에서 사용하는 문자 인코딩을 설정 -->
<!-- isELIgnored="false" :  JSP 페이지에서 EL(Expression Language)을 사용할 수 있는지 여부를 설정하는 속성.
							isELIgnored="false"로 설정하는 경우, EL을 사용할 수 있도록 활성화,
							isELIgnored 속성을 true로 설정하면 EL을 사용할 수 없도록 비활성화 -->

<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!-- 사용할 태그 라이브러리를 가져옴 -->
<!-- Tiles 프레임워크에서 제공하는 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL (JavaServer Pages Standard Tag Library)의 Core 태그 라이브러리 -->
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body>

<!-- 컨트롤러에서 메세지가 담겨져서 왔다면 함수 실행 -->
<!-- window.onload - 웹 페이지의 모든 리소스가 로드되고 준비되었을 때 실행되는 JavaScript 이벤트 핸들러 -->
<c:if test='${not empty message }'>
<script>
window.onload=function()
{
  result();
}

function result(){
	alert("아이디나  비밀번호가 틀립니다. 다시 로그인해주세요");
}
</script>
</c:if>

<div class="login_form" style="margin-top: 40px;">
	<div id="log_in">
		<h3>LOGIN</h3>
		<ul class="select">
			<li class="select_member"><a href="javascript:void(0);" onclick="toggleForm('member')">회원 로그인</a></li>
			<li class="select_nomember"><a href="javascript:void(0);" onclick="toggleForm('nomember')">비회원 로그인</a></li>
		</ul>


		<div class="member">
			<form method="post" action="${contextPath }/member/login.do">
			<!-- form에 정보를 담아서 로그인 -->
			
				<div class="member_form">

					<label for="memberId"> 
						<input type="text" id="memberId" name="memberId" placeholder="아이디">
					</label> 
					
					<label for="memberPw"> 
						<input type="password" id="memberPw" name="memberPw" placeholder="비밀번호">
					</label> 
					
					<input id="login_btn" type="submit" value="로그인">
					
				</div>
			</form>
				<div id="naver_login_btn_container">
					<a id="naver_login_btn" href="${naverUrl }">네이버로 로그인</a>
					<img id="naver_login_btn_logo" alt="naver_login" src="${contextPath }/resources/image/naver_icon.png"> 
				</div>
				<br>
				<div id="kakao_login_btn_container">
					<a id="kakao_login_btn" href="https://accounts.kakao.com/login/?continue=https%3A%2F%2Fcs.kakao.com%2Fhelps%3Fcategory%3D25">카카오로 로그인</a>
					<img id="kakao_login_btn_logo" alt="kakao_login" src="${contextPath }/resources/image/kakao_icon.png"> 				
				</div>	 

			
			
			<div class="member_info">
				<ul>
					<li><a href="#">아이디 찾기</a></li>
					<li><a href="#">비밀번호 찾기</a></li>
				</ul>
				<ul>
					<li class="signup">
						<a href="${contextPath }/member/memberForm.do">회원 가입</a>
					</li>
				</ul>
			</div>

		</div>
		
		<form class="nomember_form" style="display: none;">
			<div>
				<img alt="security_icon" src="${contextPath }/resources/image/security_icon.png" style="width: 100px; height: 100px;">
				<p>비회원의 경우 주문번호로 조회가 가능합니다.</p>
				<br>
				<p>로그인 메뉴로 접속한 경우 아래의 버튼을 클릭 후 다시 시도 해주세요.</p>
				<br>
				<p>아래의 버튼을 클릭하면 로그인 페이지로 이동합니다.</p>
				<br>
				<input id="nomember_login_btn" type="submit" value="이동하기">
			</div>
		</form>		
		<br>
		<div>
			<h4>아직도 회원이 아니세요?</h4>
			<br>
			<p>지금 yegerina의 회원이 되어 다양한 이벤트에 참여해보세요.</p>
			<br>
			<p>회원만의 특별한 혜택을 가장 먼저 만나보세요.</p>
		</div>
		
	</div>
</div>

<script type="text/javascript">
	function toggleForm(formType) {
	    var memberForm = document.querySelector('.member');
	    var nomemberForm = document.querySelector('.nomember_form');
	    var select_member = document.querySelector('.select_member');
	    var select_nomember = document.querySelector('.select_nomember');
	    
	    if (formType === 'member') {
	        memberForm.style.display = 'block';
	        select_member.style.borderBottom = '2px solid rgb(10, 10, 10)';
	        select_nomember.style.borderBottom = '2px solid rgb(136, 136, 136)';
	        nomemberForm.style.display = 'none';
	    } else if (formType === 'nomember') {
	        memberForm.style.display = 'none';
	        nomemberForm.style.display = 'block';
	        select_nomember.style.borderBottom = '2px solid rgb(10, 10, 10)';
	        select_member.style.borderBottom = '2px solid rgb(136, 136, 136)';
	    }
	}
</script>
</body>
</html>