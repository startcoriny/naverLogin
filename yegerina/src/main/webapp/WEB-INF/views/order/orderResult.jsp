<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set  var="totalPrice" value="0" /> <!-- 총 금액 -->
<head>
</head>
<body>

	<h3 style="font-size:30px; ;margin:30px auto;">주문과 결제가 정상적으로 완료되었습니다.</h3>
	<h3 align="left" style=" margin: 30px; 10px;"> 상품정보</h3>
	<table class="orderResultInfo">
	
		<tr class="orderResultHead">
			<td>번호</td>
			<td></td>
			<td style="padding-left: 150px; text-align: left;">주문상품명</td>
			<td>수량</td>
			<td>주문금액</td>
			<td>배송비</td>
			<td>주문금액합계</td>
		</tr>
		
		
			<c:forEach var="item" items="${myOrderList }">
				<tr class="orderResultlist">
					<td style="width: 30px; text-align: center;">${item.orderId }</td>
					<td style="width: 50px; height: 70px;">
						<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goodsId }">
							<img style="width: 50px; height: 50px;" src="${contextPath}/download.do?goods_id=${item.goodsId}&fileName=${item.goodsFileName}" >
						</a> <br>
						
					</td>
					<td align="left" style="width: 200px">
							[yegerina]
							<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goodsId }">
								${item.goodsTitle }					
							</a>
										
					</td>				
					<td style="width: 40px;text-align: center;">
						${item.orderGoodsQty }
					</td>		
					<td style="width: 90px;text-align: center;">
						<fmt:formatNumber  value="${item.orderGoodsQty*(item.goodsSalesPrice*0.9)}" type="number" var="Discounted_Price" />
						${Discounted_Price}원(10%할인)
					</td>		
					<td style="width: 50px;text-align: center;">
						0원
					</td>		
					<td style="width: 70px;text-align: center;">
						<fmt:formatNumber  value="${item.orderGoodsQty*(item.goodsSalesPrice*0.9)}" type="number" var="Discounted_Price" />
						${Discounted_Price}원
					</td>		
				</tr>
				<c:set  var="finaltotalPrice" value="${totalPrice + (item.orderGoodsQty*(item.goodsSalesPrice*0.9))}" />
				
			</c:forEach>
	</table>

	<br>
	<br>
	
	<h3 align="left" style="margin: 30px; 10px;">배송지 정보</h3>
	<div>
		<table class="myOrderInfoTable">
			<tr>
				<td style="width: 150px;">수령인</td>
				<td style="width: 450px; border-left: 1px solid; background: #e7e7e7;">
					${myOrderInfo.receiver_name }
				</td>
				<td style="width: 150px; border-left: 1px solid;">휴대전화</td>
				<td style="width: 450px; border-left: 1px solid; background: #e7e7e7;">
					${myOrderInfo.receiver_hp1 }
				</td>
			</tr>
			<tr>
				<td style="width: 150px; ">배송지</td>
				<td style="width: 450px; border-left: 1px solid; background: #e7e7e7;">
					${myOrderInfo.delivery_address }
				</td>
				<td style="width: 150px; background: #e7e7e7;"></td>
				<td style="width: 450px; background: #e7e7e7;"></td>
			</tr>
			<tr>
				<td style="width: 150px; ">배송 메세지</td>
				<td style="border-left: 1px solid; background: #e7e7e7;">${myOrderInfo.delivery_message }</td>
				<td style="background: #e7e7e7;"></td>
				<td style="background: #e7e7e7;"></td>
			</tr>
		
		</table>

	</div>
	<br>
	<br>
	<div>
		<h3 align="left" style="margin: 30px; 10px;">결제정보</h3>
		<table class="payInfoTable">
			<tr>
				<td>결제방법</td>
				<td>
					${myOrderInfo.pay_method}
				</td>
			</tr>
			<tr>
				<td>결제카드</td>
				<td>
					${myOrderInfo.card_com_name}
				</td>
			</tr>
			<tr>
				<td>할부기간</td>
				<td>
					${myOrderInfo.card_pay_month}
				</td>
			</tr>
			<tr>
				<td>결제 금액</td>
				<td class="final_totalPrice">
				<fmt:formatNumber  value="${finaltotalPrice}" type="number" var="final_totalPrice" />
				${final_totalPrice }원
				</td>
			</tr>

		</table>
	</div>
	
	<br>
	<br>
	<br>
	<a style=" display:inline-block; border-radius:5px; font-size:20px; font-weight:600; width: 200px; line-height: 50px; background-color: black; color: white;" href="${contextPath}/main/main.do"> 
	홈으로 가기 
	</a>
		
</body>
