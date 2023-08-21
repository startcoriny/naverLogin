<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />
<c:set var="cartCount" value="${sessionScope.cartCount}" /> <!-- 장바구니 -->

<script type="text/javascript">
	var loopSearch=true;
	
	function keywordSearch(){
		if(loopSearch==false)
			return;
		
	 var value=document.frmSearch.searchWord.value;
		$.ajax({
			type : "get",
			async : true, //false인 경우 동기식으로 처리한다.
			url : "${contextPath}/goods/keywordSearch.do",
			data : {keyword:value},
			success : function(data, textStatus) {
			    var jsonInfo = JSON.parse(data);
				displayResult(jsonInfo);
			},
			error : function(data, textStatus) {
				alert("에러가 발생했습니다."+data);
			},
			complete : function(data, textStatus) {
				//alert("작업을완료 했습니다");
				
			}
		}); //end ajax	
	}
	
	
	function displayResult(jsonInfo){
		var count = jsonInfo.keyword.length;
		if(count > 0) {
		    var html = '';
		    for(var i in jsonInfo.keyword){
			   html += "<a href=\"javascript:select('"+jsonInfo.keyword[i]+"')\">"+jsonInfo.keyword[i]+"</a><br/>";
		    }
		    var listView = document.getElementById("suggestList");
		    listView.innerHTML = html;
		    show('suggest');
		}else{
		    hide('suggest');
		} 
	}
	
	function select(selectedKeyword) {
		 document.frmSearch.searchWord.value=selectedKeyword;
		 loopSearch = false;
		 hide('suggest');
	}
		
	function show(elementId) {
		 var element = document.getElementById(elementId);
		 if(element) {
		  element.style.display = 'block';
		 }
		}
	
 	function hide(elementId){
	   var element = document.getElementById(elementId);
	   if(element){
		  element.style.display = 'none';
	   }
	}
 	
 	
 	function showLoginAlert() {
 	    alert("로그인이 필요한 서비스입니다. 로그인 페이지로 이동합니다.");
 	    window.location.href = "${contextPath }/member/loginForm.do";
 	}
</script>

        <div class="container">
            <h1>쇼핑몰 홈페이지 헤더 메뉴</h1>
            <nav>
                <div>
                    <ul>
                        <li><a href="${contextPath}/main/main.do"><img src="${contextPath }/resources/image/home_icon.png" alt="home" width="40px" height="40px" ></a></li>
                    	
                    	
                    	<!-- 로그인이 되어 있는 상태이면서 회원정보가 비어있지 않다면 로그아웃을 띄우고 그게 아니라면 로그인과 회원가입 li 띄우기 -->
                    	<c:choose>
                    		<c:when test="${isLogOn==true and not empty memberInfo }">
                    			<li><a href="${contextPath }/member/logout.do" >로그아웃</a></li>                    		
		                        <li style="position: relative;">
			                        <a href="${contextPath}/cart/myCartList.do">
			                        	<img alt="cart" src="${contextPath }/resources/image/cart_icon.png" width="40px" height="40px">
			                        </a>
			                        <div class="cartCountimage">${cartCount }</div>
		                        </li>
		                        <li><a href="${contextPath }/mypage/listMyOrderHistory.do">ORDER</a></li>
		                        <li><a href="${contextPath }/mypage/myPageForm.do">My Page</a></li>
                    		</c:when>
                    		<c:otherwise>
                    			<li><a href="${contextPath }/member/loginForm.do" >Login</a></li> 
		                        <li><a href="${contextPath }/member/memberForm.do">Join us</a></li>                    		
		                        <li><a href="javascript:showLoginAlert()"><img alt="cart" src="${contextPath }/resources/image/cart_icon.png" width="40px" height="40px"></a></li>
		                        <li><a href="javascript:showLoginAlert()">ORDER</a></li>
		                        <li><a href="javascript:showLoginAlert()">My Page</a></li>
                    		</c:otherwise>
                    	</c:choose>
                    </ul>
                </div>
                
                <div>
                    <ul>
                        <li>
                        <div id="search" >
							<form name="frmSearch" action="${contextPath}/goods/searchGoods.do">
							<!-- 검색하기를 누를때 action의 경로로 이동하면서 form의 value 값을 전달  -->
							  <div class="search_input_container">
							    <input class="searchWord" name="searchWord" class="search_input" type="text" onKeyUp="keywordSearch()">
							    <!-- 자동완성 기능 -->
							    <button type="submit" name="search" class="btn_search" value="검 색">
							      <img src="${contextPath}/resources/image/search_Icon.png" alt="검색 이미지" width="20px" height="20px">
							    </button>
							  </div>
							</form>
			   				<div id="suggest">
	        					<div id="suggestList" style="text-align: left;"></div>
	   						</div>				                        
						</div>
                        </li>
                        <li><a href="#">공지사항</a></li>
                        <li><a href="#">Q & A</a></li>
                        <li><a href="#">REVIEW</a></li>
                        <c:if test="${isLogOn==true and memberInfo.memberId =='admin' }">  
	   	   					<li class="admin">
	   	   						<a href="${contextPath}/admin/goods/adminGoodsMain.do">관리자</a>
	   	   						<ul class="adminList">
	   	   							<li><a href="${contextPath}/admin/goods/adminGoodsMain.do">상품관리</a></li>
	   	   							<li><a href="${contextPath}/admin/member/adminMemberMain.do">회원관리</a></li>
	   	   							<li><a href="${contextPath}/admin/order/adminOrderMain.do">주문관리</a></li>
	   	   						</ul>
	   	   					</li>
	    				</c:if>
                    </ul>
                </div>
            </nav>
        </div>

        <h2 style="background: url(${contextPath}/resources/image/yegerina.jpg) no-repeat 0/300px;">
        	쇼핑몰 로고 
        </h2><br>
        
        
        