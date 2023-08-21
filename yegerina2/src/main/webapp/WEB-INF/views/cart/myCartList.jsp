<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="myCartList"  value="${cartMap.myCartList}"  />
<c:set var="myGoodsList"  value="${cartMap.myGoodsList}"  />

<c:set  var="totalGoodsNum" value="0" />  <!--주문 개수 -->
<c:set  var="totalDeliveryPrice" value="0" /> <!-- 총 배송비 --> 
<c:set  var="totalDiscountedPrice" value="0" /> <!-- 총 할인금액 -->

<head>
<script type="text/javascript">
function delete_cart_goods(cart_id){
	var cart_id=Number(cart_id);
	var formObj=document.createElement("form");
	var i_cart = document.createElement("input");
	i_cart.name="cart_id";
	i_cart.value=cart_id;
	
	formObj.appendChild(i_cart);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/cart/removeCartGoods.do";
    formObj.submit();
}


function fn_order_each_goods(goods_id,goods_title,goods_sales_price,fileName){
	var total_price,final_total_price,_goods_qty;
	var cart_goods_qty=document.getElementById("cart_goods_qty");
	
	_order_goods_qty=cart_goods_qty.value; //장바구니에 담긴 개수 만큼 주문한다.
	var formObj=document.createElement("form");
	var i_goods_id = document.createElement("input"); 
    var i_goods_title = document.createElement("input");
    var i_goods_sales_price=document.createElement("input");
    var i_fileName=document.createElement("input");
    var i_order_goods_qty=document.createElement("input");
    
    i_goods_id.name="goodsId";
    i_goods_title.name="goodsTitle";
    i_goods_sales_price.name="goodsSalesPrice";
    i_fileName.name="goodsFileName";
    i_order_goods_qty.name="orderGoodsQty";
    //vo에 있는 필드명과 동일해야함.
    
    i_goods_id.value=goods_id;
    i_order_goods_qty.value=_order_goods_qty;
    i_goods_title.value=goods_title;
    i_goods_sales_price.value=goods_sales_price;
    i_fileName.value=fileName;
    
    formObj.appendChild(i_goods_id);
    formObj.appendChild(i_goods_title);
    formObj.appendChild(i_goods_sales_price);
    formObj.appendChild(i_fileName);
    formObj.appendChild(i_order_goods_qty);

    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/order/orderEachGoods.do";
    formObj.submit();
}




</script>
</head>

<body>
	<table class="list_view">
		<tbody class="cartListContainer">
			<tr>
				<td class="menuexplain" >전체</td>
				<td class="menuexplain">상품명(옵션)</td>
				<td></td>
				<td>판매가</td>
				<td>수량</td>
				<td>주문금액</td>				
				<td>주문관리</td>
				<td>배송비 / 배송형태</td>
			</tr>
			<c:choose>
				<c:when test="${ empty myCartList }">
			 		<tr>
						<td colspan=8 class="menuexplain">
							<strong>장바구니에 상품이 없습니다.</strong>
						</td>
					</tr>
			 	</c:when>
			   	<c:otherwise>
               			<form class="cartListmenu" name="frm_order_all_cart">
				      		<c:forEach var="item" items="${myGoodsList }" varStatus="cnt">
					       		<c:set var="cart_goods_qty" value="${myCartList[cnt.count-1].cartGoodsQty}" />
					       		<c:set var="cartId" value="${myCartList[cnt.count-1].cartId}" />
					 			<tr>
					 		
						 			<%-- 전체 --%>  
									<td>
										<input type="checkbox" name="checked_goods"  value="${item.goodsId }"  onClick="calcGoodsPrice(${cnt.index},${item.goodsSalesPrice},this)">
										
									</td>
									<%-- 상품이미지 --%> 
									<td class="goods_image">
										<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goodsId }">
											<img alt="" src="${contextPath}/download.do?goods_id=${item.goodsId}&fileName=${item.goodsFileName}" />
										</a>
	
									</td>
									<%-- 상품옵션 --%> 
									<td>
										<h6>${item.goodsTitle }</h6>
										<h6>${item.goodsSalesPrice }원</h6>
									</td>
									
									
									<%-- 판매가(세일) --%> 
									<td>
							   			<strong>
							      			<fmt:formatNumber  value="${item.goodsSalesPrice*0.9}" type="number" var="discounted_price" />
						            		${discounted_price}원(10%할인)
						         		</strong>
									</td>
									
									
									<%-- 수량 --%> 
									<td>							
							   			<strong>
						            		${cart_goods_qty}개
						         		</strong>
						         		<input type="hidden" id="cart_goods_qty${cnt.index}" name="cart_goods_qty" value="${cart_goods_qty}">									
									</td>
									
									
									<%-- 주문 금액 --%> 
									<td>
							   			<strong>
							      			<fmt:formatNumber  value="${(item.goodsSalesPrice * cart_goods_qty)*0.9}" type="number" var="discounted_price" />
						            		${discounted_price}원(10%할인)
						         		</strong>
									</td>
	
									<%-- 주문관리(삭제, 수량) --%> 
									<td>
										<a href="javascript:fn_order_each_goods('${item.goodsId }','${item.goodsTitle }','${item.goodsSalesPrice}','${item.goodsFileName}','${myCartList[cnt.count-1].cartGoodsQty}${myCartList[cnt.count-1].cartGoodsQty}');" style="width: 150px;">
										주문하기 
										</a>
										/
										<a href="javascript:delete_cart_goods('${cartId}');"> 
										  삭제
							   			</a>
									</td>
								
									<%-- 배송비 / 배송형태 --%> 
									<td>
										택배배송 <br>
										배송비무료 <br>
										0원 이상 무료 <br>									
									</td>
								
								</tr>
<%-- 							<c:set  var="totalGoodsPrice" value="${totalGoodsPrice+ (item.goodsSalesPrice * cart_goods_qty)}" />
							<c:set  var="totalGoodsNum" value="${totalGoodsNum + cart_goods_qty }" />
							<c:set  var="totalDiscountedPrice" value="${totalDiscountedPrice + (item.goodsSalesPrice * cart_goods_qty)*0.1 }" /> --%>
		   					</c:forEach>
		   				</form>
			 	</c:otherwise>
			</c:choose>
		</tbody>
	</table>
	
	<table class="total_info">
		<tbody class="total_info_container">
	     	<tr  align=center  class="menuexplain" >
	       		<td class="">총 상품수 </td>
	       		<td>총 상품금액</td>
	       		<td>총 배송비</td>
	       		<td>총 할인 금액 </td>
	       		<td>최종 결제금액</td>
	     	</tr>
			<tr>
				<td>

 			  		<p id="p_totalNum">${totalGoodsNum}개 </p> 
			  		<input id="h_totalNum"type="hidden" value="${totalGoodsNum}"  />
				</td>
	       		<td>
	          		<p id="p_totalPrice">
	          		<fmt:formatNumber  value="${totalGoodsPrice}" type="number" var="total_goods_price" />
				         ${total_goods_price}원
	          		</p>
	          		<input id="h_totalPrice"type="hidden" value="${totalGoodsPrice}" />
	       		</td>

	       		<td>
	         		<p id="p_totalDeliveryPrice">${totalDeliveryPrice }원  </p>
	         		<input id="h_totalDelivery"type="hidden" value="${totalDeliveryPrice}" />
	       		</td>

	       		<td>  
	         		<p id="p_totalSalesPrice"> 
	         		<fmt:formatNumber  value="${totalDiscountedPrice}" type="number" var="total_Discounted_Price" />
				    	${total_Discounted_Price}원
	         		</p>
	         		<input id="h_totalSalesPrice"type="hidden" value="${totalDiscountedPrice}" />
	       		</td>
	       		<td>
	          		<p id="p_final_totalPrice">
	          		<fmt:formatNumber  value="${totalGoodsPrice+totalDeliveryPrice-totalDiscountedPrice}" type="number" var="total_price" />
	           	 		${total_price}원
	          		</p>
	          		<input id="h_final_totalPrice" type="hidden" value="${totalGoodsPrice+totalDeliveryPrice-totalDiscountedPrice}" />
	       		</td>
			</tr>
		</tbody>
	</table>
	
	    <br><br>	
		 <a class="orderbtn" href="javascript:fn_order_all_cart_goods()">
		 	주문하기
		 </a>
		     
		 <a class="btn_home" href="${contextPath}/main/main.do">
		 	쇼핑계속하기
		 </a>

		 
		 
<script type="text/javascript">
	function fn_order_all_cart_goods(){
	//	alert("모두 주문하기");
		var order_goods_qty;
		var order_goods_id;
		var objForm=document.frm_order_all_cart;
		var cart_goods_qty=objForm.cart_goods_qty;
		var checked_goods=objForm.checked_goods;
		var length=checked_goods.length;
		
		
		//alert(length);
		if(length>1){
			for(var i=0; i<length;i++){
				if(checked_goods[i].checked==true){
					order_goods_id=checked_goods[i].value;
					order_goods_qty=cart_goods_qty[i].value;
					cart_goods_qty[i].value="";
					cart_goods_qty[i].value=order_goods_id+":"+order_goods_qty;
					//alert(select_goods_qty[i].value);
					console.log(cart_goods_qty[i].value);
				}
			}	
		}else{
			order_goods_id=checked_goods.value;
			order_goods_qty=cart_goods_qty.value;
			cart_goods_qty.value=order_goods_id+":"+order_goods_qty;
			//alert(select_goods_qty.value);
		}
			
	 	objForm.method="post";
	 	objForm.action="${contextPath}/order/orderAllCartGoods.do";
		objForm.submit();
	}
	
	
	
	function calcGoodsPrice(index,goodsSalesPrice,obj){
		var totalPrice,final_total_price,totalNum,totalSalesPrice = 0; 
		var goods_qty=document.getElementById("cart_goods_qty"+index); // 1
		console.log(goods_qty.value);

		var p_totalNum=document.getElementById("p_totalNum");
		var p_totalPrice=document.getElementById("p_totalPrice");
		var p_final_totalPrice=document.getElementById("p_final_totalPrice");
		var h_totalNum=document.getElementById("h_totalNum");
		var h_totalPrice=document.getElementById("h_totalPrice");
		var h_totalDelivery=document.getElementById("h_totalDelivery");
		var h_totalSalesPrice=document.getElementById("h_totalSalesPrice");
		var h_final_total_price=document.getElementById("h_final_totalPrice");
		if(obj.checked==true){
			
			totalNum=Number(h_totalNum.value)+Number(goods_qty.value);

			
			totalPrice=Number(h_totalPrice.value)+Number(goods_qty.value*goodsSalesPrice);
			

			var salesprice = goodsSalesPrice*0.1

			totalSalesPrice=Number(h_totalSalesPrice.value)+Number((goods_qty.value*goodsSalesPrice)*0.1);

			
			final_total_price=totalPrice+Number(h_totalDelivery.value)-totalSalesPrice;


		}else{

		
			totalNum=Number(h_totalNum.value)-Number(goods_qty.value);
	
		
			
			totalPrice=Number(h_totalPrice.value)-Number(goods_qty.value*goodsSalesPrice);
	
		
			totalSalesPrice=Number(h_totalSalesPrice.value)-Number((goods_qty.value*goodsSalesPrice)*0.1);
			
			
			final_total_price=totalPrice-totalSalesPrice;

		}
		
		h_totalNum.value=totalNum;
		
		h_totalPrice.value=totalPrice;
		h_totalSalesPrice.value=totalSalesPrice;
		h_totalSalesPrice.value=totalSalesPrice;
		h_final_total_price.value=final_total_price;
		
		p_totalNum.innerHTML=totalNum + "개";
		p_totalPrice.innerHTML=totalPrice + "원";
		p_totalSalesPrice.innerHTML=totalSalesPrice + "원";
		p_final_totalPrice.innerHTML=final_total_price + "원";
	}	
	
	
	
	
	
	
	
	
	
	
	
</script>