<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
			
<c:set  var="totalGoodsNum" value="0" />  <!--주문 개수 -->
<c:set  var="totalDeliveryPrice" value="0" /> <!-- 총 배송비 --> 
<c:set  var="totalDiscountedPrice" value="0" /> <!-- 총 할인금액 -->


<body>
	<form id="form_order" name="form_order">
		<h4 align="left" style="font-size: 30px; font-weight: 500; margin-top: 30px; padding-left: 20px; padding-bottom: 20px; border-bottom: 1px solid;">
			Order / Payment
		</h4>
		<br>
		<br>

		<div class="order_container">
			<h3 align="left" style="padding-bottom:10px; ">배송정보</h3>
			<table class="order_form">
			<tr class="order_form_dot_line">
				<td style="border-top: 1px solid;">
					배송지
				</td>
				<td style="border-top: 1px solid;">
					<input type="radio" name="delivery_place" onClick="restore_all()" value="기본배송지" checked>기본배송지 &nbsp;&nbsp;&nbsp; 
					<input type="radio" name="delivery_place" value="새로입력" onClick="reset_all()">새로입력 &nbsp;&nbsp;&nbsp;
					<input type="radio" name="delivery_place" value="최근배송지">최근배송지 &nbsp;&nbsp;&nbsp;
				</td>
			</tr>
			<tr class="order_form_dot_line">
				<td>
					<span>이름 / 연락처</span>
				</td>
				<td>
					<input id="receiver_name" name="receiver_name" type="text" size="3" value="${orderer.memberName }" />
					<input type="hidden" id="h_orderer_name" name="h_orderer_name"  value="${orderer.memberName }" /> 
					<input type="hidden" id="h_receiver_name" name="h_receiver_name"  value="${orderer.memberName }" />
					 | 
					<input id="receiver_hp" name="receiver_hp" type="text" size="10" value="${orderer.hp1 }" />
					<input type="hidden" id="h_orderer_hp" name="h_orderer_hp"  value="${orderer.hp1 }" /> 
					<input type="hidden" id="h_receiver_hp" name="h_receiver_hp"  value="${orderer.hp1 }" />
				</td>
			</tr>
			<tr class="order_form_dot_line">
				<td>
					<span>주소</span>
				</td>
				<td style="font-size: 20px;">
					<input type="text" id="zipcode" name="zipcode" size="4" value="(${orderer.zipcode})" required>
					<input type="text" id="member_address" name="member_address" size="23" value="${orderer.address }" required> 
					<input type="text" id="subaddress" name="subaddress" size="50" value="${orderer.subaddress }" required>
					<input type="hidden" id="h_zipcode" name="h_zipcode" value="${orderer.zipcode }"  /> 
					<input type="hidden" id="h_member_address" name="h_member_address" value="${orderer.address }" /> 
					<input type="hidden" id="h_subaddress" name="h_subaddress" value="${orderer.subaddress }" />
				</td>
			</tr>
			<tr class="order_form_dot_line">
				<td class="">배송 메시지</td>
				<td>
					<input id="delivery_message" name="delivery_message" type="text" size="50" style="border: 1px solid;"
						                   placeholder="택배 기사님께 전달할 메시지를 남겨주세요." />
				</td>
			</tr>
			</table>

			<br>
			<br>
			<h3 align="left" style="padding-bottom:10px; " >상품정보</h3>
			<table class="orderInfo">
				<tr class="orderInfoHead">
					<td style="border-right: none; width: 150px;"></td>
					<td style="width: 300px; text-align: left; padding-left: 50px;">상품 정보</td>
					<td style="width: 100px;">수량</td>
					<td>상품할인</td>
					<td>배송비</td>
					<td style="border-right: none;">주문금액</td>
				</tr>
					<!-- 상품들 정보 리스트 -->
					<c:forEach var="item" items="${myOrderList }">
						<tr class="orderInfoList">
							<td style="border-right: none; width: 150px; text-align: center; line-height: 20px; display: flex; align-items: center; justify-content: center;">
								<!-- 상품이미지 -->
	 							<img src="${contextPath}/download.do?goods_id=${item.goodsId}&fileName=${item.goodsFileName}" >
							    <input   type="hidden" id="h_goods_id" name="h_goods_id1" value="${item.goodsId }" />
							    <input   type="hidden" id="h_goods_fileName" name="h_goods_fileName" value="${item.goodsFileName }" />
							    <input   type="hidden" id="h_goods_title" name="h_goods_title" value="${item.goodsTitle }" />							
								<!-- 상품이미지 -->
							</td>
							<td style="width: 300px; padding-right: 50px; ">
							<!-- 상품정보 -->
								<div>
									<h4>${item.goodsTitle }<br>
									${item.goodsSalesPrice }원</h4>
								</div>
							<!-- 상품정보 -->
							</td>
							
							
							<td style="width: 100px;">
								<!-- 수량 -->
				            		${item.orderGoodsQty}개
				         		<input type="hidden" id="h_order_goods_qty" name="h_order_goods_qty" value="${item.orderGoodsQty}">						
								<!-- 수량 -->
							</td>				
							<td>
								<!-- 상품할인 -->
								<p id="p_totalSalesPrice"> 
		         				<fmt:formatNumber  value="${(item.goodsSalesPrice*0.1)*item.orderGoodsQty}" type="number" var="Discounted_Price" />
					    		${Discounted_Price}원
		         				</p>
		         				<input id="h_totalSalesPrice"type="hidden" value="${Discounted_Price}" />
								<!-- 상품할인 -->
							</td>
							<td>
								<!-- 배송비 -->
								<p id="p_totalDeliveryPrice">무료 </p>
		         				<input id="h_totalDeliveryPrice"type="hidden" value="${totalDeliveryPrice}" />
		       					<!-- 배송비 -->
							</td>
							<td style="border-right: none;">
								<!-- 주문금액 -->
				          		<p id="p_final_totalPrice">
				          		<fmt:formatNumber  value="${(item.goodsSalesPrice*0.9)*item.orderGoodsQty-totalDeliveryPrice}" type="number" var="total_price" />
				           	 		${total_price}원
				          		</p>
				          		<input id="h_final_totalPrice" type="hidden" value="${(item.goodsSalesPrice*0.9)*item.orderGoodsQty-totalDeliveryPrice}" />
								<!-- 주문금액 -->
							</td>																		
						<c:set  var="totalGoodsNum" value="${totalGoodsNum + item.orderGoodsQty }" /> <!-- 상품총갯수 -->
						<c:set  var="totalGoodsPrice" value="${totalGoodsPrice+ (item.goodsSalesPrice * item.orderGoodsQty)}" /> <!-- 상품 총가격 -->
						<c:set  var="totalDiscountedPrice" value="${totalDiscountedPrice + (item.goodsSalesPrice * item.orderGoodsQty)*0.1 }" /> <!-- 상품 총 할인 -->
											
						</tr>
					</c:forEach>
		
			</table>

			<br>
			<br>
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
					  		<p id="p_totalGoodsNum">${totalGoodsNum}개 </p>   <!-- 총상품갯수 -->
							<input id="h_total_order_goods_qty" type="hidden" value="${totalGoodsNum}" />
						</td>
			       		<td>
			          		<p id="p_totalGoodsPrice"> <!-- 상품 총가격(할인미적용) -->
			          		<fmt:formatNumber  value="${totalGoodsPrice}" type="number" var="total_goods_price" />
						         ${total_goods_price}원
			          		</p>
			          		<input id="h_totalGoodsPrice"type="hidden" value="${totalGoodsPrice}" />
			       		</td>
		
			       		<td>
			         		<p id="p_totalDeliveryPrice">${totalDeliveryPrice }원  </p> <!-- 상품총배달비 -->
			         		<input id="h_totalDeliveryPrice"type="hidden" value="${totalDeliveryPrice}" />
			       		</td>
		
			       		<td>  
			         		<p id="p_totalSalesPrice">  <!-- 상품 총 할인 -->
			         		<fmt:formatNumber  value="${totalDiscountedPrice}" type="number" var="total_Discounted_Price" />
						    	-${total_Discounted_Price}원
			         		</p>
							<input id="h_total_sales_price" type="hidden" value="${total_Discounted_Price}" />
			       		</td>
			       		<td>
			          		<p id="p_final_totalPrice"> <!-- 상품 총가격(할인적용) -->
			          		<fmt:formatNumber  value="${totalGoodsPrice+totalDeliveryPrice-totalDiscountedPrice}" type="number" var="total_price" />
			           	 		${total_price}원
							</p> 
							<input id="h_final_total_Price" type="hidden" value="${total_price}" />
			       		</td>
					</tr>
				</tbody>
			</table>
			
			
			
			<br>
			<br>
			<br>
			
			
			
			<h3 align="left" style="padding-bottom:10px; ">결제정보</h3>
			<div class="pay_detail_table_container">
				<table class="pay_detail_table">
					<tbody>										
						<tr >
							<td>
								결제 수단
							</td>
							<td>
							   <input type="radio" id="pay_type" name="pay_type" value="일반결제" checked>일반결제 &nbsp;&nbsp;&nbsp; 
							   <input type="radio" id="pay_type" name="pay_type" value="토스페이"  >토스페이 &nbsp;&nbsp;&nbsp; 
							   <input type="radio" id="pay_type" name="pay_type" value="네이버페이">네이버페이 &nbsp;&nbsp;&nbsp;
							</td>
						</tr>
						<tr >
							<td>
								결제 방법
							</td>
							<td>
							   <input type="button" class="pay_method" id="pay_method" name="pay_method" value="신용카드"   onClick="fn_pay_card()"> &nbsp;&nbsp;&nbsp; 
							   <input type="button" class="pay_method" id="pay_method" name="pay_method" value="제휴 신용카드"  > &nbsp;&nbsp;&nbsp; 
							   <input type="button" class="pay_method" id="pay_method" name="pay_method" value="실시간 계좌이체"> &nbsp;&nbsp;&nbsp;
							   <input type="button" class="pay_method" id="pay_method" name="pay_method" value="무통장 입금"> &nbsp;&nbsp;&nbsp;
							  </td>
						</tr>
						<tr >
							<td>
								
							</td>
							<td>
							   
							   <input type="button" class="pay_method" id="pay_method" name="pay_method" value="휴대폰결제" onClick="fn_pay_phone()"> &nbsp;&nbsp;&nbsp;
							   <input type="button" class="pay_method" id="pay_method" name="pay_method" value="카카오페이"> &nbsp;&nbsp;&nbsp; 
							   <input type="button" class="pay_method" id="pay_method" name="pay_method" value="페이나우"> &nbsp;&nbsp;&nbsp; 
							   <input type="button" class="pay_method" id="pay_method" name="pay_method" value="페이코"> &nbsp;&nbsp;&nbsp;
							</td>
						</tr>
						<tr id="tr_pay_phone" style="visibility:hidden">
							<td>
							</td>
						  	<td>
						  		<strong>휴대폰 번호 입력: </strong>
						  		<input  type="text" size="30" value=""  id="pay_orderer_hp_num" name="pay_orderer_hp_num" placeholder="-(하이픈)포함해서 작성해주세요"/>
						  	</td>
						</tr>						
						
						<tr id="tr_pay_card">
							<td>
							</td>
							<td style="height: 80px;">
								<select id="card_com_name" name="card_com_name">
									<option value="">카드선택</option>
									<option value="삼성">삼성</option>
									<option value="하나SK">하나SK</option>
									<option value="현대">현대</option>
									<option value="KB">KB</option>
									<option value="신한">신한</option>
									<option value="롯데">롯데</option>
									<option value="BC">BC</option>
									<option value="시티">시티</option>
									<option value="NH농협">NH농협</option>
								</select>
								&nbsp;&nbsp;
								<select id="card_pay_month" name="card_pay_month">
									<option value="일시불" selected>일시불</option>
									<option value="2개월">2개월</option>
									<option value="3개월">3개월</option>
									<option value="4개월">4개월</option>
									<option value="5개월">5개월</option>
									<option value="6개월">6개월</option>
								</select>
							</td>
						</tr>
						<tr >
							<td>
								품절 시 환불 안내
							</td>
							<td>
								<div style="font-weight: 600">&nbsp;&nbsp;결제하신 수단으로 취소됩니다.</div><br>
								· 입점업체 배송은 낮은 확률로 상품이 품절일 가능성이 있습니다. 이에 품절 시 빠르게 환불 처리해드립니다.
								<br>
								· 현금 환불의 경우, 예금정보가 일치해야 환불 처리가 가능합니다. 은행명, 계좌번호, 예금주명을 정확히 기재 부탁드립니다.
								<br>
								· 환불 받으신 날짜 기준으로 3~5일(주말 제외) 후 결제대행사에서 직접 고객님의 계좌로 환불 처리됩니다.
							</td>
						</tr>
					</tbody>
				</table>
			</div>

		</div>
		<br>
		<br>
		<br> 
		<div id="order_goods_btn">
			<a href="javascript:fn_show_order_detail();"> 
				${total_price}원 결제하기
			</a> 
		</div>
		<br>
		<br>
		<br> 
	</form>
	
	
		
		
		
		
	<div class="clear"></div>		
	<div id="layer" style="visibility:hidden">
		<!-- visibility:hidden 으로 설정하여 해당 div안의 모든것들을 가려둔다. -->
		<div id="popup_order_detail">
			<!-- 팝업창 닫기 버튼 -->
			<a href="#" onClick="javascript:imagePopup('close', '.layer01');">
				X
			</a> 
			<br/>
			 
			<div class="detail_table">
			  <h1>최종 주문 사항</h1>
				<table>
					<tbody align=left>
					 	<tr>
						  <td>
						      주문상품번호:
						 </td>
						 <td>
							 <p id="p_order_goods_id"> 주문번호 </p>    
						 </td>
					   </tr>
					   <tr>
						  <td>
						      주문상품명:
						  </td>
						  <td>
						 	<p id="p_order_goods_title"> 주문 상품명 </p>    
						  </td>
					   </tr>
					   <tr>
					   	  <td>
						      주문상품개수:
						  </td>
						  <td>
						  	<p id="p_total_order_goods_qty"> 주문 상품개수 </p>    
						  </td>
					   </tr>
					   <tr>
						  <td>
						     주문금액합계:
						  </td>
						  <td>
						    <p id="p_total_order_goods_price">주문금액합계</p>
						  </td>
					   </tr>
					   <tr>
						  <td width=200px height=100px>
						     주문자:
						  </td>
						  <td>
						    <p id="p_orderer_name"> 주문자 이름</p>
						  </td>
					   </tr>
					   <tr>
						  <td>
						     받는사람:
						  </td>
						  <td>
						    <p id="p_receiver_name">받는사람이름</p>
						  </td>
					   </tr>
					   <tr>
						  <td>
						     받는사람 휴대폰번호:
						  </td>
						  <td>
						    <p id="p_receiver_hp_num"></p>
						  </td>
					   </tr>
					   <tr>
						  <td>
						     배송주소:
						  </td>
						  <td align=left>
						    <p id="p_delivery_address">배송주소</p>
						  </td>
					   </tr>
					   <tr>
						  <td>
						     배송메시지:
						  </td>
						  <td align=left>
						    <p id="p_delivery_message">배송메시지</p>
						  </td>
					   </tr>
					   <tr>
						  <td>
						     결제방법:
						  </td>
						  <td align=left>
						    <p id="p_pay_method">결제방법</p>
						  </td>
					   </tr>
					   <tr>
					      <td colspan=2 align=center>
					      <input  name="btn_process_pay_order" type="button" onClick="fn_process_pay_order()" value="최종결제하기">
					      </td>
					   </tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>

</body>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">


/* 	window.onload=function()
	{
	  init();
	}
	
	function init(){
		var form_order=document.form_order;
		var h_hp1=form_order.h_orderer_hp;
		var hp1=h_hp1.value;
		var select_hp1=form_order.hp1;
		select_tel1.value=tel1;
		select_hp1.value=hp1;
	}   */


	function reset_all() {
		var e_receiver_name = document.getElementById("receiver_name");
		var e_hp1 = document.getElementById("receiver_hp");
	
		var e_zipcode = document.getElementById("zipcode");
		var e_member_address = document.getElementById("member_address");
		var e_subaddress = document.getElementById("subaddress");
	
		e_receiver_name.value = "";
		e_hp1.value = "";
		e_zipcode.value = "";
		e_member_address.value = "";
		e_subaddress.value = "";
		
	    e_receiver_name.style.border = "1px solid"; 
	    e_hp1.style.border = "1px solid";
	    e_zipcode.style.border = "1px solid";
	    e_member_address.style.border = "1px solid";
	    e_subaddress.style.border = "1px solid";
	}
	
	

	function restore_all() {
		var e_receiver_name = document.getElementById("receiver_name");
		var e_hp1 = document.getElementById("receiver_hp");


		var e_zipcode = document.getElementById("zipcode");
		var e_member_address = document.getElementById("member_address");
		var e_subaddress = document.getElementById("subaddress");


		var h_receiver_name = document.getElementById("h_receiver_name");
		var h_hp1 = document.getElementById("h_receiver_hp");

		var h_zipcode = document.getElementById("h_zipcode");
		var h_member_address = document.getElementById("h_member_address");
		var h_subaddress = document.getElementById("h_subaddress");
		//alert(e_receiver_name.value);
		e_receiver_name.value = h_receiver_name.value;
		e_hp1.value = h_hp1.value;

		e_zipcode.value = h_zipcode.value;
		e_member_address.value = h_member_address.value;
		e_subaddress.value = h_subaddress.value;
		
	    e_receiver_name.style.border = "none"; 
	    e_hp1.style.border = "none";
	    e_zipcode.style.border = "none";
	    e_member_address.style.border = "none";
	    e_subaddress.style.border = "none";

	}
	
	
	
	function fn_pay_card(){
		var e_card=document.getElementById("tr_pay_card");
		var e_phone=document.getElementById("tr_pay_phone");
		e_card.style.visibility="visible";
		e_phone.style.visibility="hidden";
	}
	
	

	function fn_pay_phone(){	
		var e_card=document.getElementById("tr_pay_card");
		var e_phone=document.getElementById("tr_pay_phone");
		e_card.style.visibility="hidden";
		e_phone.style.visibility="visible";
	}
	
	
	
	
	var goods_id="";
	var goods_title="";
	var goods_fileName="";

	var order_goods_qty
	var each_goods_price;
	var total_order_goods_price;
	var total_order_goods_qty;
	var orderer_name
	var receiver_name
	var hp1;

	var receiver_hp_num;
	var delivery_address;
	var delivery_message;
	var pay_method;
	var card_com_name;
	var card_pay_month;
	var pay_orderer_hp_num;

	
	
	function fn_show_order_detail(){
		goods_id="";
		goods_title="";
		
		var frm=document.form_order;
		var h_goods_id=document.getElementById("h_goods_id");
		var h_goods_title=document.getElementById("h_goods_title");
		var h_goods_fileName=document.getElementById("h_goods_fileName");
		var h_order_goods_qty=document.getElementById("h_order_goods_qty");
		var h_total_order_goods_qty=document.getElementById("h_total_order_goods_qty");		
		var h_total_sales_price=document.getElementById("h_total_sales_price");
		var h_final_total_Price=document.getElementById("h_final_total_Price");
		var h_orderer_name=document.getElementById("h_orderer_name");
		var i_receiver_name=document.getElementById("receiver_name");
		var i_pay_orderer_hp_num=document.getElementById("pay_orderer_hp_num");
		
		
		if(h_goods_id.length <2 ||h_goods_id.length==null){
			goods_id+=h_goods_id.value;
		}else{
			for(var i=0; i<h_goods_id.length;i++){
				goods_id+=h_goods_id[i].value+"<br>";
				
			}	
		}
		console.log(goods_id);
		
		
		
		if(h_goods_title.length <2 ||h_goods_title.length==null){
			goods_title+=h_goods_title.value;
		}else{
			for(var i=0; i<h_goods_title.length;i++){
				goods_title+=h_goods_title[i].value+"<br>";
				
			}	
		}		
		console.log(goods_title);
		
		
		if(h_goods_fileName.length <2 ||h_goods_fileName.length==null){
			goods_fileName+=h_goods_fileName.value;
		}else{
			for(var i=0; i<h_goods_fileName.length;i++){
				goods_fileName+=h_goods_fileName[i].value+"<br>";
				
			}	
		}
		console.log(goods_fileName);
		
		console.log(h_final_total_Price.value);
		total_order_goods_price=h_final_total_Price.value;
		
		console.log(h_total_order_goods_qty.value);
		
		total_order_goods_qty=h_total_order_goods_qty.value;
		
		
		var r_pay_method  =  frm.pay_method;
		console.log("결제 방식");
		console.log("결제 방식" + frm.pay_method);
		
		
		
		
		for(var i=0; i<r_pay_method.length;i++){
		  if(r_pay_method[i].classList.contains('active')){
/* 		  if(r_pay_method[i].active==true){ */
			  pay_method=r_pay_method[i].value
			  
			  console.log(pay_method);
			  
			  if(pay_method=="신용카드"){
				var i_card_com_name=document.getElementById("card_com_name");
				var i_card_pay_month=document.getElementById("card_pay_month");
				card_com_name=i_card_com_name.value;
				card_pay_month=i_card_pay_month.value;
/* 				pay_method+=card_com_name;	 */			 		
				pay_orderer_hp_num="해당없음";
				
				console.log(card_com_name);
				console.log(card_pay_month);
				
			  }else if(pay_method=="휴대폰결제"){
				pay_orderer_hp_num=i_pay_orderer_hp_num.value;
				pay_method+="<br>"+"결제휴대폰번호:"+pay_orderer_hp_num+"<br>";
				card_com_name="해당없음";
				card_pay_month="해당없음";
			  } //end if
			 break;
		  }// end for
		}
		
		
		
		
		var i_hp1=document.getElementById("receiver_hp");

		
		var i_zipcode=document.getElementById("zipcode");
		var i_address=document.getElementById("member_address");
		var i_subaddress=document.getElementById("subaddress");
		var i_delivery_message=document.getElementById("delivery_message");
		var i_pay_method=document.getElementById("pay_method");

//		alert("총주문 금액:"+total_order_goods_price);
		order_goods_qty=h_order_goods_qty.value;
		//order_total_price=h_order_total_price.value;
		
		console.log(order_goods_qty);
		
		
		orderer_name=h_orderer_name.value;
		console.log(orderer_name);

		receiver_name=i_receiver_name.value;
		console.log(receiver_name);

		hp1=i_hp1.value;
		console.log(hp1);
		
		
		receiver_hp_num=hp1;
		
		console.log(i_zipcode.value);
		console.log(i_address.value);
		console.log(i_subaddress.value);
		
		delivery_address=i_zipcode.value
							+i_address.value+
										i_subaddress.value;
		
							console.log(i_zipcode.value);
							console.log(i_address.value);
							console.log(i_subaddress.value);
							
		delivery_message=i_delivery_message.value;
		
		var p_order_goods_id=document.getElementById("p_order_goods_id");
		var p_order_goods_title=document.getElementById("p_order_goods_title");
/* 		var p_order_goods_qty=document.getElementById("p_order_goods_qty");
 */		var p_total_order_goods_qty=document.getElementById("p_total_order_goods_qty");
		var p_total_order_goods_price=document.getElementById("p_total_order_goods_price");
		var p_orderer_name=document.getElementById("p_orderer_name");
		var p_receiver_name=document.getElementById("p_receiver_name");
		var p_receiver_hp_num=document.getElementById("p_receiver_hp_num");
		var p_delivery_address=document.getElementById("p_delivery_address");
		var p_delivery_message=document.getElementById("p_delivery_message");
		var p_pay_method=document.getElementById("p_pay_method");
		
		p_order_goods_id.innerHTML=goods_id;
		p_order_goods_title.innerHTML=goods_title;
		p_total_order_goods_qty.innerHTML=total_order_goods_qty+"개";
		p_total_order_goods_price.innerHTML=total_order_goods_price+"원";
		p_orderer_name.innerHTML=orderer_name;
		p_receiver_name.innerHTML=receiver_name;
		p_receiver_hp_num.innerHTML=receiver_hp_num;
		p_delivery_address.innerHTML=delivery_address;
		p_delivery_message.innerHTML=delivery_message;
		p_pay_method.innerHTML=pay_method;
		imagePopup('open');
	}
	
	
	function imagePopup(type) {
		if (type == 'open') {
			// 팝업창을 연다.
			jQuery('#layer').attr('style', 'visibility:visible');

			jQuery('#layer').height(jQuery(document).height());
		}

		else if (type == 'close') {

			// 팝업창을 닫는다.
			jQuery('#layer').attr('style', 'visibility:hidden');
		}
	}	
	
	
	
	
	function fn_process_pay_order(){
		
		alert("최종 결제하기");
		var formObj=document.createElement("form");
	    var i_receiver_name=document.createElement("input");
	    
	    var i_receiver_hp1=document.createElement("input");
	    
	    var i_delivery_address=document.createElement("input");
	    var i_delivery_message=document.createElement("input");
	    var i_pay_method=document.createElement("input");
	    var i_card_com_name=document.createElement("input");
	    var i_card_pay_month=document.createElement("input");
	    var i_pay_orderer_hp_num=document.createElement("input");
	    

	    
	    i_receiver_name.name="receiver_name";
	    i_receiver_hp1.name="receiver_hp1";
	   
	    i_delivery_address.name="delivery_address";
	    i_delivery_message.name="delivery_message";

	    i_pay_method.name="pay_method";
	    i_card_com_name.name="card_com_name";
	    i_card_pay_month.name="card_pay_month";
	    i_pay_orderer_hp_num.name="pay_orderer_hp_num";
	    
	    
	    i_receiver_name.value=receiver_name;
	    i_receiver_hp1.value=hp1;	    
	    i_delivery_address.value=delivery_address;
	    i_delivery_message.value=delivery_message;
	    
	    i_pay_method.value=pay_method;
	    i_card_com_name.value=card_com_name;
	    i_card_pay_month.value=card_pay_month;
	    i_pay_orderer_hp_num.value=pay_orderer_hp_num;
	    
	    
	    formObj.appendChild(i_receiver_name);
	    formObj.appendChild(i_receiver_hp1);

	    formObj.appendChild(i_delivery_address);
	    formObj.appendChild(i_delivery_message);
	    
	    formObj.appendChild(i_pay_method);
	    formObj.appendChild(i_card_com_name);
	    formObj.appendChild(i_card_pay_month);
	    formObj.appendChild(i_pay_orderer_hp_num);
	    

	    document.body.appendChild(formObj); 
	    formObj.method="post";
	    formObj.action="${contextPath}/order/payToOrderGoods.do";
	    formObj.submit();
		imagePopup('close');
	    
	}

	var buttons = document.querySelectorAll(".pay_method");

	buttons.forEach(function(button) {
	  button.addEventListener("click", function() {
	    buttons.forEach(function(btn) {
	      btn.classList.remove("active");
	    });
	    this.classList.add("active");
	  });
	});
	
</script>
			