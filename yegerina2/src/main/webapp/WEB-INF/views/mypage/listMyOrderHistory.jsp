<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<div id="OrderHistory_container">
	<div>
		<div>
			<div>

				<p align="left" style="font-size:30px; padding: 50px 0">주문내역 조회</p>
				<form id="orderListHistory_date" method="post">

					<!-- 검색 - 오늘 -->
					<a class="order_date" href="javascript:search_order_history('today')">
						오늘
					</a>
					
					<!-- 검색 - 1개월 -->
					<a class="order_date" href="javascript:search_order_history('one_month')" name="one_month">
						1개월
					</a>
					
					<!-- 검색 - 2개월 -->
					<a class="order_date" href="javascript:search_order_history('two_month')">
						2개월
					</a>
					
					<!-- 검색 - 3개월 -->
					<a class="order_date" href="javascript:search_order_history('three_month')">
						3개월
					</a>
					
					<!-- 검색 - 6개월 -->
					<a class="order_date" href="javascript:search_order_history('six_month')">
						6개월
					</a>

					<!-- set된 조회할 기간 -->
					<div class="d-none">
						<div style="border: 1px solid; width: 120px; border-radius: 5px;">
							 <input type="text" size="1" value="${beginYear}" />-
							 <input style="width: 20px;" type="text" size="1" value="${beginMonth}" />-
							 <input style="width: 20px;" type="text" size="1" value="${beginDay}" />
						</div>
						&nbsp; - &nbsp;
						<div style="border: 1px solid; width: 120px; border-radius: 5px;">
							 <input type="text" size="1" value="${endYear}" />-
							 <input style="width: 20px;" type="text" size="1" value="${endMonth}" />- 
							 <input style="width: 20px;" type="text" size="1" value="${endDay}" />
						</div>
					</div>
					<!-- set된 조회할 기간 -->

				</form>

				<!-- 주문정보 표시 영역 -->
				<div>
					
					<table id="orderListHistory">
						<tr>
							<td class="tdtd"></td>
							<td class="tdtd">상품정보</td>
							<td>주문금액(수량)</td>
							<td>주문일자</td>
							<td>주문번호</td>
							<td>주문 상태</td>
							<td>주문 수정</td>
						</tr>					
						<c:choose>
						
							<c:when test="${empty myOrderHistList }">
								<tr>
									<!-- 주문상품이 없을때 -->
									<td colspan=8 class="menuexplain">
											<strong>주문한 상품이 없습니다.</strong>
									</td>
									<!-- 주문상품이 없을때 -->
								</tr>
							</c:when>
	
							<c:otherwise>		
								<c:forEach var="item" items="${myOrderHistList}" varStatus="i">
								    <tr>
								        <td>
								            <!-- 상품 이미지 -->
								            <img src="${contextPath}/download.do?goods_id=${item.goodsId}&fileName=${item.goodsFileName}" style="width: 64px; height: 64px">
								            <!-- 상품 이미지 -->
								        </td>
								        <td>
								            <p>
								                <!-- 상품명 -->
								                <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goodsId}">${item.goodsTitle}</a>
								                <!-- 상품명 -->
								            </p>
								        </td>
								        <td>
								            <p>
								                <!-- 주문 갯수 -->
								                <span>${item.orderGoodsQty}</span>개
								                <span> · </span>
								                <span>
								                    <!-- 상품 가격 * 갯수 : 총 구매 가격 -->
								                    <fmt:formatNumber value="${(item.goodsSalesPrice * item.orderGoodsQty) * 0.9}" pattern="#,###" />
								                </span> 원
								            </p>
								        </td>
								        <td>
											<p>${item.pay_order_time }주문</p>										
										</td>
										<td>
											<div>
												<p>${item.orderId }</p>
											</div>
										</td>
												
										<td>
											<div>
												<p>
													<!-- 배송정보에 따른 표시 -->
													<c:choose>
														<c:when test="${item.delivery_state=='delivery_prepared' }">배송준비중</c:when>
														<c:when test="${item.delivery_state=='delivering' }">배송중</c:when>
														<c:when test="${item.delivery_state=='finished_delivering' }">배송완료</c:when>
														<c:when test="${item.delivery_state=='cancel_order' }">주문취소완료</c:when>
														<c:when test="${item.delivery_state=='returning_goods' }">반품중</c:when>
														<c:when test="${item.delivery_state=='exchange_goods' }">교환중</c:when>
													</c:choose>
													<!-- 배송정보에 따른 표시 -->
												</p>
											</div>
										</td>
										<td>	
											<c:choose>
												<c:when test="${item.delivery_state=='cancel_order'}">
												</c:when>
												<c:when test="${item.delivery_state=='returning_goods'}">
												</c:when>
												<c:when test="${item.delivery_state=='exchange_goods'}">
												</c:when>
												<c:when test="${item.delivery_state=='delivering'}">
												</c:when>
												
												<c:otherwise>
													<div>
														<div>
															<c:choose>
																<c:when test="${item.delivery_state=='null'}">
																	<!-- 배송준비완료일때 -->
																	<button onClick="fn_edit_order('${item.orderId}','cancel')" style="width: 150px;">
																		주문취소
																	</button>
																	<!-- 배송준비완료일때 -->
																</c:when>
																<c:when test="${item.delivery_state=='delivery_prepared'}">
																	<!-- 배송준비완료일때 -->
																	<button onClick="fn_edit_order('${item.orderId}','cancel')" style="width: 150px;">
																		주문취소
																	</button>
																	<!-- 배송준비완료일때 -->
																</c:when>

																<c:when test="${item.delivery_state=='finished_delivering' }">
																	<!-- 배송완료 일때 -->
																	<button onClick="fn_edit_order('${item.orderId}', 'exchange')"style="width: 150px;">
																		교환신청
																	</button>
																	<button onClick="fn_edit_order('${item.orderId}','return')" style="width: 150px;">
																		반품신청
																	</button>
																		<!-- 배송완료 일때 -->
																</c:when>

															</c:choose>
														</div>
													</div>
												</c:otherwise>
											</c:choose>
										</td>
								    </tr>
								</c:forEach>							
							</c:otherwise>
						</c:choose>
					</table>
				</div>
				<!-- 주문정보 표시 영역 -->
			</div>
		</div>
	</div>
</div>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script>
			
			//기간별 조회, fixedSearchPeriod값을 가지고 submit
			function search_order_history(fixedSearchPeriod) {
				var formObj = document.createElement("form");
				var i_fixedSearch_period = document.createElement("input");
				i_fixedSearch_period.name = "fixedSearchPeriod";
				i_fixedSearch_period.value = fixedSearchPeriod;
				formObj.appendChild(i_fixedSearch_period);
				document.body.appendChild(formObj);
				formObj.method = "get";
				formObj.action = "${contextPath}/mypage/listMyOrderHistory.do";
				formObj.submit();
			}
			
			//주문수정, option값에 따라 if문을 통해 submit한다.
			function fn_edit_order(orderId, option){
				var formObj=document.createElement("form");
				var i_order_id = document.createElement("input"); 
				 	i_order_id.name="orderId";
				    i_order_id.value=orderId;
					
				    formObj.appendChild(i_order_id);
				    document.body.appendChild(formObj); 
				    formObj.method="post";
				   
				    //취소
				    if(option == "cancel"){
				    	var answer=confirm("주문을 취소하시겠습니까?");
						if(answer==true){
							formObj.action="${contextPath}/mypage/cancelMyOrder.do";
							formObj.submit();
						}
				    }else if(option == "return"){
				    //반품
				    	var answer=confirm("반품신청 하시겠습니까?");
						if(answer==true){
				    	formObj.action="${contextPath}/mypage/returnMyOrder.do";
				    	formObj.submit();
						}
				    }else if(option == "exchange"){
				    //교환
				    	var answer=confirm("교환신청 하시겠습니까?");
						if(answer==true){
				    	formObj.action="${contextPath}/mypage/exchangeMyOrder.do";
				    	formObj.submit();
						}
				    }
				    	
				
			}
			
			//url에 따라서 버튼의 style을 변경
			if (window.location.href.includes("fixedSearchPeriod")) {
				//모든 뱃지 style 초기화
				const badges = document.querySelectorAll(".badge");
				for (b of badges){ b.classList.remove("active");}
				
				//url에 표시된 txt에 따른 style 변경
				if (window.location.href.includes("today")) {
					badges[0].classList.add("active");
				} else if (window.location.href.includes("one_month")) {
					badges[1].classList.add("active");
				}else if (window.location.href.includes("two_month")) {
					badges[2].classList.add("active");
				}else if (window.location.href.includes("three_month")) {
					badges[3].classList.add("active");
				}else if (window.location.href.includes("six_month")) {
					badges[4].classList.add("active");
				}
			
			}
			
		</script>