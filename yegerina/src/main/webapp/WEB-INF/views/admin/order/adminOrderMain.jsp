<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="ordersLen" value="${sessionScope.ordersLen}" /> <!-- 총회원수 -->


<!-- order_goods_list에 데이터가 있을때 -->
<c:choose>
	<c:when test='${not empty order_goods_list}'>
		<script type="text/javascript">
			window.onload = function() {
				init();
			}

			//각각의 주문건에 대한 배송 상태를 표시한다.
			function init() {
				var frm_delivery_list = document.frm_delivery_list;
				var h_delivery_state = frm_delivery_list.h_delivery_state;
				var s_delivery_state = frm_delivery_list.s_delivery_state;

				//조회된 주문 정보가 1건인 경우
				if (h_delivery_state.length == undefined) {
					s_delivery_state.value = h_delivery_state.value;
				} else {
					//조회된 주문 정보가 여러건인 경우
					for (var i = 0; s_delivery_state.length; i++) {
						s_delivery_state[i].value = h_delivery_state[i].value;
					}
				}
			}
		</script>
	</c:when>
</c:choose>
<!-- order_goods_list에 데이터가 있을때 -->

<div class="detail_box" id="admin_order">
	<h3 align="left" style="margin: 30px 0;">주문관리</h3>
	<div align="left">
		<a href="javascript:search_order_history('today')" class="badge">오늘</a>
		<a href="javascript:search_order_history('one_month')" class="badge">1개월</a>
		<a href="javascript:search_order_history('two_month')" class="badge">2개월</a>
		<a href="javascript:search_order_history('three_month')" class="badge">3개월</a>
		<a href="javascript:search_order_history('six_month')" class="badge">6개월</a>
		<span>총 주문건 : ${ordersLen }</span>
		
	</div>

	<div>
		<table>
			<tr>
				<td>주문번호</td>
				<td>주문정보</td>
				<td>배송정보</td>
				<td>주문날짜</td>
				<td style="width: 50px;">-</td>
			</tr>

			<c:choose>
				<c:when test="${empty newOrderList }">
					<tr>
						<td colspan="5">
							<div class="empty_order">
								<p>조회된 주문이 없습니다.</p>
							</div>
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="item" items="${newOrderList }" varStatus="i">
						<c:choose>
							<c:when test="${item.orderId != pre_orderId }">
								<form name="frm_delivery_list">
									<tr>
										<td>${item.orderId }</td>
										<td>
											<div>
												<span>주문회원</span> <input type="text" placeholder="회원이름"
													readonly value="${item.memberId }">
											</div>
											<div>
												<span>수령자</span> <input type="text" placeholder="수령자"
													readonly value="${item.receiver_name }">
											</div>
											<div>
												<span>배송연락처</span> <input type="text" placeholder="배송연락처"
													readonly value="${item.receiver_hp1 }">
											</div>
										</td>
										<td>
											<div>
												<span>주문상품</span> <input type="text" placeholder="주문상품"
													readonly value="${item.goodsTitle }">
											</div>
											<div>
												<span>주문수량</span> <input type="text" placeholder="주문수량"
													readonly value="${item.orderGoodsQty }">
											</div> <!-- 다중 주문일 경우 --> <c:forEach var="item2"
												items="${newOrderList}" varStatus="j">
												<!-- i.index보다 j.index의 수가 크다면  -->
												<c:if test="${j.index > i.index }">
													<!-- 그리고 주문id가 동일하다면 -->
													<c:if test="${item.orderId == item2.orderId}">

														<!-- 구분선 -->
														<hr>
														<!-- 구분선 -->

														<div>
															<span>주문상품</span>

															<!-- 상품이름 -->
															<input type="text" placeholder="주문상품"
																value="${item2.goodsTitle}">
															<!-- 상품이름 -->

														</div>
														<div>
															<span>주문수량</span>

															<!-- 주문수량 -->
															<input type="text" placeholder="주문수량"
																value="${item2.orderGoodsQty}">
															<!-- 주문수량 -->

														</div>
													</c:if>
												</c:if>
											</c:forEach> <!-- 다중 주문일 경우 -->
											<div>
												<span>주문상태</span>

												<c:choose>
													<c:when test="${item.delivery_state=='delivery_prepared' }">
														<select name="s_delivery_state${i.index }" id="s_delivery_state${i.index}" onchange="selectValue(this,this.value)" class="prepared">
													</c:when>
													<c:when
														test="${item.delivery_state=='finished_delivering' }">
														<select name="s_delivery_state${i.index }" id="s_delivery_state${i.index }" onchange="selectValue(this,this.value)" class="success">
													</c:when>
													<c:otherwise>
														<select name="s_delivery_state${i.index }" id="s_delivery_state${i.index }" onchange="selectValue(this,this.value)" class="danger">
													</c:otherwise>
												</c:choose>
												<c:choose>
													<c:when test="${item.delivery_state=='delivery_prepared' }">
														<!-- 배송준비중 option 선택 -->
														<option value="delivery_prepared" class="text-secondary"
															selected>배송준비중</option>
														<option value="delivering">배송중</option>
														<option value="finished_delivering">배송완료</option>
														<option value="cancel_order">주문취소</option>
														<option value="returning_goods">반품</option>
													</c:when>
													<c:when test="${item.delivery_state=='delivering' }">
														<!-- 배송중 option 선택 -->
														<option value="delivery_prepared">배송준비중</option>
														<option value="delivering" selected>배송중</option>
														<option value="finished_delivering">배송완료</option>
														<option value="cancel_order">주문취소</option>
														<option value="returning_goods">반품</option>
													</c:when>
													<c:when
														test="${item.delivery_state=='finished_delivering' }">
														<!-- 배송완료 option 선택 -->
														<option value="delivery_prepared">배송준비중</option>
														<option value="delivering">배송중</option>
														<option value="finished_delivering" selected>배송완료</option>
														<option value="cancel_order">주문취소</option>
														<option value="returning_goods">반품</option>
													</c:when>
													<c:when test="${item.delivery_state=='cancel_order' }">
														<!-- 주문취소 option 선택 -->
														<option value="delivery_prepared">배송준비중</option>
														<option value="delivering">배송중</option>
														<option value="finished_delivering">배송완료</option>
														<option value="cancel_order" selected>주문취소</option>
														<option value="returning_goods">반품</option>
													</c:when>
													<c:when test="${item.delivery_state=='returning_goods' }">
														<!-- 반품 option 선택 -->
														<option value="delivery_prepared">배송준비중</option>
														<option value="delivering">배송중</option>
														<option value="finished_delivering">배송완료</option>
														<option value="cancel_order">주문취소</option>
														<option value="returning_goods" selected>반품</option>
													</c:when>
													<c:otherwise>
														<!-- 주문오류 option 선택 -->
														<option value="delivery_prepared">배송준비중</option>
														<option value="주문오류" selected>주문오류</option>
														<option value="delivering">배송중</option>
														<option value="finished_delivering">배송완료</option>
														<option value="cancel_order">주문취소</option>
														<option value="returning_goods">반품</option>
													</c:otherwise>
												</c:choose>
												</select>
												<!-- 배송상태 hidden input -->
												<input type="hidden" class="delivery_state"
													name="delivery_state" value="${item.delivery_state}">
												<!-- 배송상태 hidden input -->
											</div>
										</td>
										<td>${item.pay_order_time }</td>
										<td>
											<button
												onclick="fn_modify_order_state('${i.index}','${item.orderId }')">수정</button>
										</td>
								</c:when>
							</c:choose>
							</tr>

						</form>

						<c:set var="pre_orderId" value="${item.orderId }" />
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
		<div class="pages">
			<c:forEach var="page" begin="1" end="10" step="1">
				<a href="${contextPath}/admin/order/adminOrderMain.do?chapter=${section}&pageNum=${page}">${(section-1)*10 +page }</a>
			</c:forEach> 
		</div>
	</div>

</div>

<script>
	//selectBox가 selected되면 그다음 요소 input에게 그 value가 반영된다.
	function selectValue(selectBox, value) {
		var input = selectBox.nextElementSibling
		input.setAttribute("value", value);
	}

	//주문수정 - 배송수정
	//수정할 상품 index와 order_id를 가져온다.
	function fn_modify_order_state(index, orderId) {
		//해당 getElementsByName이 delivery_state인 input을 가져와
		/* var deliveryInputs = document.getElementsByClassName("delivery_state");
		//그 값 value을 저장해 수정 수행
		var delivery_state = deliveryInputs[index].value; */
		var deliveryInput = document.getElementById('s_delivery_state'+index);
		var delivery_state = deliveryInput.value;
		

		$.ajax({
					type : "post",
					async : false,
					url : "${contextPath}/admin/order/modifyDeliveryState.do",
					data : {
						orderId : orderId,
						delivery_state : delivery_state
					},
					success : function(data, textStatus) {
						if (data.trim() == 'mod_success') {
							//수정완료
							alert("주문 정보를 수정했습니다.");
							location.reload();
						} else if (data.trim() == 'failed') {
							alert("다시 시도해 주세요.");
						}

					},
					error : function(data, textStatus) {
						alert("에러가 발생했습니다." + data);
					},
					complete : function(data, textStatus) {
					}
				});
	}

	//버튼식 상품조회
	//onclick할때 같이 가져오는 fixedSearchPeriod값과함께 adminOrderMain 재요청
	//해당 값은 자바소스를 거쳐 지정된 기간에 맞는 정보만 select되어 뿌려진다.
	function search_order_history(fixedSearchPeriod) {
		var formObj = document.createElement("form");
		var i_fixedSearch_period = document.createElement("input");
		i_fixedSearch_period.name = "fixedSearchPeriod";
		i_fixedSearch_period.value = fixedSearchPeriod;
		formObj.appendChild(i_fixedSearch_period);
		document.body.appendChild(formObj);
		formObj.method = "get";
		formObj.action = "${contextPath}/admin/order/adminOrderMain.do";
		formObj.submit();
	}
	//버튼식 상품조회 badge url에 따른 style변경
	if (window.location.href.includes("fixedSearchPeriod")) {
		const badges = document.querySelectorAll(".badge");
		for (b of badges){ b.classList.remove("active");}
		//각 값이 url에 들어있을 경우 active된다.
		if (window.location.href.includes("today")) {badges[0].classList.add("active");
		} else if (window.location.href.includes("one_month")) {badges[1].classList.add("active");
		}else if (window.location.href.includes("two_month")) {badges[2].classList.add("active");
		}else if (window.location.href.includes("three_month")) {badges[3].classList.add("active");
		}else if (window.location.href.includes("six_month")) {badges[4].classList.add("active");
		}
	}
</script>