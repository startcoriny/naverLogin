<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" 	isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="goods"  value="${goodsMap.goodsVO}"  />
<c:set var="imageList"  value="${goodsMap.imageList }"  />
 
 <%
     //치환 변수 선언합니다.
      //pageContext.setAttribute("crcn", "\r\n"); //개행문자
      pageContext.setAttribute("crcn" , "\n"); //Ajax로 변경 시 개행 문자 
      pageContext.setAttribute("br", "<br/>"); //br 태그
%>  
<html>
<head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">
	
	
	
	function add_cart(goods_id) {
        // getElementById를 사용하여 <select> 요소를 선택합니다.
        var selectElement = document.getElementById("order_goods_qty");
        
        // 선택된 옵션의 인덱스를 가져옵니다.
        var selectedIndex = selectElement.selectedIndex;
        
        // 선택된 옵션의 값을 가져옵니다.
        var selectedValue = selectElement.options[selectedIndex].value;
        
    	var _isLogOn=document.getElementById("isLogOn");
    	var isLogOn=_isLogOn.value;
    	
    	if(isLogOn=="false" || isLogOn=='' ){
    	    var confirmation = confirm("로그인 후 주문이 가능합니다!!!\n로그인 페이지로 이동하시겠습니까?");
    	    
    	    if (confirmation) {
    	        // 확인 버튼을 누른 경우 - 로그인 페이지로 이동
    	        window.location.href = "${contextPath}/member/loginForm.do";
    	    } else {
    	        // 취소 버튼을 누른 경우 - 아무 작업 없음
    	    }
    		
    	} else{
        	
			$.ajax({
				type : "post",
				async : false, //false인 경우 동기식으로 처리한다.
				url : "${contextPath}/cart/addGoodsInCart.do",
				data : {
					goods_id:goods_id,
					cart_goods_qty:selectedValue
					
				},
				success : function(data, textStatus) {
					//alert(data);
				//	$('#message').append(data);
					if(data.trim()=='add_success'){
						alert("장바구니에 추가되었습니다.");	
					}else if(data.trim()=='already_existed'){
						alert("이미 카트에 등록된 상품입니다.");	
					}
					
				},
				error : function(data, textStatus) {
					alert("에러 발생"+data);
				},
				complete : function(data, textStatus) {
					//alert("작업을완료 했습니다");
				}
			}); //end ajax	
        }
        
	}
	
function fn_order_each_goods(goods_id,goods_title,goods_sales_price,fileName){
	var _isLogOn=document.getElementById("isLogOn");
	var isLogOn=_isLogOn.value;
	
	 if(isLogOn=="false" || isLogOn=='' ){
		alert("로그인 후 주문이 가능합니다!!!");
	} 
	
	
	var total_price,final_total_price;
	var order_goods_qty=document.getElementById("order_goods_qty");
	
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
    
    i_goods_id.value=goods_id;
    i_order_goods_qty.value=order_goods_qty.value;
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

/* 
    function getSelectedValue() {
        // getElementById를 사용하여 <select> 요소를 선택합니다.
        var selectElement = document.getElementById("order_goods_qty");
        
        // 선택된 옵션의 인덱스를 가져옵니다.
        var selectedIndex = selectElement.selectedIndex;
        
        // 선택된 옵션의 값을 가져옵니다.
        var selectedValue = selectElement.options[selectedIndex].value;
        
        alert("선택된 값: " + selectedValue);
 	} */
	
</script>
</head>

	<div class="goodsDetail_container">
	
		<div id="goods_image">
			<figure>
				<img class="goods_image_property" src="${contextPath}/download.do?goods_id=${goods.goodsId}&fileName=${goods.goodsFileName}">
			</figure>
		</div>
		
		
		<div id="goods_detail_table">
			<table>
				<tbody>
					
					<div class="explain" align="center" style="font-size: 24px; font-weight: 600; margin: 15px 0;">
						${goods.goodsTitle }
					</div>
					
					<tr>
						<td class="explain">정가</td>
						<td class="active explain">
							
							   <fmt:formatNumber  value="${goods.goodsSalesPrice}" type="number" var="goods_price" />
						         ${goods_price}원
							
						</td>
					</tr>
					<tr >
						<td class="explain">판매가</td>
						<td class="active explain">
						   <fmt:formatNumber  value="${goods.goodsSalesPrice*0.9}" type="number" var="discounted_price" />
					         ${discounted_price}원(10%할인)
					    </td>
					</tr>
	
					<tr>
						<td class="explain">배송료</td>
						<td class="explain"><strong>무료</strong></td>
					</tr>
					
					<tr>
						<td class="explain">배송안내</td>
						<td class="explain"><strong>[당일배송]</strong> 당일배송 서비스<br> </td>
					</tr>
					
					
					<tr>
						<td class="explain">도착예정일</td>
						<td class="explain">지금 주문 시 내일 도착 예정</td>
					</tr>
					
					
					<tr>
						<td class="explain">수량</td>
						<td class="explain">
					      <select style="width: 60px;" id="order_goods_qty">
						    <option>1</option>
							<option>2</option>
							<option>3</option>
							<option>4</option>
							<option>5</option>
					      </select>
<!-- 						  <button onclick="getSelectedValue()">선택된 값 가져오기</button> -->
						</td>
					</tr>
				</tbody>
			
			</table>
			
			<ul>
				<!-- 단일 아이템 구매 -->
				<li><a class="buy" href="javascript:fn_order_each_goods('${goods.goodsId }','${goods.goodsTitle }','${goods.goodsSalesPrice}','${goods.goodsFileName}');">구매하기 </a></li>
				
				<!-- 해당 아이템 장바구니추가 -->
				<li><a class="cart" href="javascript:add_cart('${goods.goodsId }',)">장바구니</a></li>
				
				<li><a class="wish" href="#">위시리스트</a></li>
			</ul>
		</div>
	</div>	
<!-- 로그인 여부를 확인하기 위한 isLogOn -->
<input type="hidden" name="isLogOn" id="isLogOn" value="${isLogOn}"/>


<div>
<hr>

</div>

		<!-- 하단 상품상세정보 -->
		<div id="detailInfolist_container">
		
			<!-- tab Caller -->
			<ul class="detailinfolist_nav">
				<li id="detailgoods_btn">
					<a href="#" onclick="toggleDetail('detailInfo01')">
						상품상세 
					</a>
				</li>
				<li id="deliveryinfo_btn">
					<a href="#" onclick="toggleDetail('detailInfo02')">
						배송/교환/반품 안내
					</a>
				</li>
			</ul>
			<!-- tab Caller -->


			<!-- tab 본문 -->
			<div id="nav-tabContent">
				<div id="detailInfo01" >
				
					<!-- 상세이미지 리스트 foreach로 뿌림 -->
					<c:forEach var="image" items="${goodsMap.imageList }">
							<img style="height: 900px;" class="detailInfo_img" src="${contextPath}/download.do?goods_id=${goods.goodsId}&fileName=${image.fileName}">
					</c:forEach>
					<img style="height: 900px;" class="detailInfo_img" src="${contextPath}/download.do?goods_id=${goods.goodsId}&fileName=${goods.goodsFileName}">				
				</div>

				<!-- 상품/배송정보등의 외 정보 -->

				<div id="detailInfo02" style="display: none;">
					<img class="detailInfo_img " src="${contextPath }/resources/image/deliveryinfo01.png"><br>
					<img style="height: 550px;" class="detailInfo_img " src="${contextPath }/resources/image/deliveryinfo02.png">
									
				</div>
				<!-- 상품/배송정보등의 외 정보 -->
			</div>
			<!-- tab 본문 -->

		</div>
		<!-- 하단 상품상세정보 -->



<script type="text/javascript">

	function toggleDetail(detailId) {
	    var detailInfo01 = document.getElementById('detailInfo01');
	    var detailInfo02 = document.getElementById('detailInfo02');
	    var detailgoods_btn = document.getElementById('detailgoods_btn');
	    var deliveryinfo_btn = document.getElementById('deliveryinfo_btn');
	
	    if (detailId === 'detailInfo01') {
	        detailInfo01.style.display = 'block';
	        detailgoods_btn.style.borderBottom = 'none';
	        deliveryinfo_btn.style.borderBottom = '1px solid';
	        detailInfo02.style.display = 'none';
	    } else if (detailId === 'detailInfo02') {
	        detailInfo01.style.display = 'none';
	        detailgoods_btn.style.borderBottom = '1px solid';
	        deliveryinfo_btn.style.borderBottom = 'none';
	        detailInfo02.style.display = 'block';
	    }
	    
	    
	    event.preventDefault(); // 이벤트의 기본 동작 막기
	}


</script>


</body>
</html>