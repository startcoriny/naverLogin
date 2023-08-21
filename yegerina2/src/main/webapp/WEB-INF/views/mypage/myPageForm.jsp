<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<c:set var="cartCount" value="${sessionScope.cartCount}" /> <!-- 장바구니 -->
<c:set var="deliveringCount" value="${sessionScope.deliveringCount}" /> <!-- 배송중 -->
<c:set var="paycomplete" value="${sessionScope.paycomplete}" /> <!-- 결제완료 -->
<c:set var="Purchase_completed" value="${sessionScope.Purchase_completed}" /> <!-- 구매확정 -->

<body>
<head>

</head>
<body>
<div class="wrap">
  <div class="greenContainer">
    <div>
      <div class="name">마이페이지</div>
    </div>  
  </div>
  
  <div class="shippingStatusContainer">
    <div class="title">
      주문/배송조회
    </div>
    <div class="status">
      
      <div class="item">
        <div>
          <div class="green number">${cartCount }</div>
          <div class="mypageText">장바구니</div>
        </div>
        <div class="icon"> > </div>
      </div>     
      <div class="item">
        <div>
          <div class="number">${paycomplete }</div>
          <div class="mypageText">결제완료</div>
        </div>
        <div class="icon"> > </div>
      </div>     
      <div class="item">
        <div>
          <div class="green number">${deliveringCount }</div>
          <div class="mypageText">배송중</div>
        </div>
        <div class="icon"> > </div>
      </div>     
      <div class="item">
        <div>
          <div class="green number">${Purchase_completed }</div>
          <div class="mypageText">구매확정</div>
        </div>
      </div>     
      
    </div>
    
  </div>  
  <div class="listContainer">
    <a href="${contextPath}/mypage/myDetailInfo.do" class="item">
        <div class="icon">ii</div>
        <div class="mypageText">내정보</div>
        <div class="right"> > </div>
    </a>
    <a href="${contextPath}/mypage/listMyOrderHistory.do" class="item">
        <div class="icon">ii</div>
        <div class="mypageText">주문목록</div>
        <div class="right"> > </div>
    </a>
    <a href="#" class="item">
        <div class="icon">ii</div>
        <div class="mypageText">주문상세</div>
        <div class="right"> > </div>
    </a>
  </div>


</div>
</body>

</body>
