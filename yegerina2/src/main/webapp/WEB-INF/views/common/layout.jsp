<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("utf-8");
%>

<head>
<meta charset="utf-8">
<link href="${contextPath}/resources/css/main.css" rel="stylesheet" type="text/css">
<link href="${contextPath}/resources/css/login.css" rel="stylesheet" type="text/css">
<link href="${contextPath}/resources/css/join_us.css" rel="stylesheet" type="text/css">




	<title><tiles:insertAttribute name="title" /></title>
	
</head>
<body>
	<div id="outer_wrap">
		
		<div id="wrap">
						
			<header>
				   <tiles:insertAttribute name="header" />
			</header>

			
			<section>
				   <tiles:insertAttribute name="section" />
			</section>

			<main>
			 	<tiles:insertAttribute name="body" />
			</main>
			
			<footer>
        		<tiles:insertAttribute name="footer" />
        	</footer>
        	
    	</div>
    </div>        	

<script src="${contextPath}/resources/js/mainpage.js"></script>


    <!-- mainpage.js의 스크립트 포함 -->
<script>
 // mainpage.js
    function openPopup() {
        // 쿠키를 이용하여 7일간 팝업을 띄우지 않기 여부 확인
        
            // 팝업 창 위치 조정을 위한 좌표값 계산
	    var popupWidth = 550;
	    var popupHeight = 400;
    
    
        var disablePopup = getCookie('disablePopup');
        if (!disablePopup) {
            // 팝업을 위한 URL 생성
            var popupUrl = '${contextPath}/popup/showpopup.do';
            var popupUrl2 = '${contextPath}/popup/showpopup2.do';

            var popup = window.open(popupUrl, '_blank', 'width=' + popupWidth + ', height=' + popupHeight + ', left=' + 100 + ', top=' + 100 + ', resizable=yes, scrollbars=yes');
            var popup2 = window.open(popupUrl2, '_blank', 'width=' + popupWidth + ', height=' + popupHeight + ', left=' + 100 + ', top=' + 200 + ', resizable=yes, scrollbars=yes');

            // 팝업이 닫힐 때 이벤트 처리
            if (popup) {
                popup.onbeforeunload = function() {
                    // 팝업이 닫힐 때 처리할 내용을 추가
                };
            }
            
            // 팝업이 열릴 때 세션 쿠키 생성
            setCookie('disablePopup', 'true');
            
            
        }
    }

    // 쿠키를 생성하는 함수
    function setCookie(name, value) {
        document.cookie = name + '=' + value + '; path=/';
    }

    // 쿠키를 가져오는 함수
    function getCookie(name) {
        var nameEQ = name + '=';
        var ca = document.cookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') c = c.substring(1, c.length);
            if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
        }
        return null;
    }


    // 페이지 로드 시 팝업 띄우기
    window.onload = function() {
        openPopup();
    };
    

    
    
</script>


</body>
      
        
        