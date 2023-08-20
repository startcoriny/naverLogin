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
<!DOCTYPE html>
<html>
<head>
    <title>로맨틱크라운 시즌오프~60%</title>
</head>
<body>
	<div class="popup-content">
		<img alt="팝업" src="${contextPath }/resources/image/popup_image.jpg" width="500px" height="500px">
	 	<br><input type="checkbox" id="disablePopup"> 7일간 띄우지 않기
	 	<button id="closePopupButton">닫기</button> 
	</div>
    <script>

        // 닫기 버튼 클릭 시 팝업 창 닫기
        var closePopupButton = document.getElementById('closePopupButton');
        if (closePopupButton) {
            closePopupButton.addEventListener('click', function() {
                window.close();
            });
        }
    </script>
</body>
</html>