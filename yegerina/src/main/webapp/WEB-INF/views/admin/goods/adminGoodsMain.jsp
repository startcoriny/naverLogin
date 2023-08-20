<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />



<div class="detail_box" id="admin_goods">
	<h3 align="left" style="margin: 30px 0;">상품관리</h3>
	<div style="height: 50px;">
		<a href="javascript:search_order_history('today')" class="badge">오늘</a>
		<a href="javascript:search_order_history('one_month')" class="badge">1개월</a>
		<a href="javascript:search_order_history('two_month')" class="badge">2개월</a>
		<a href="javascript:search_order_history('three_month')" class="badge">3개월</a>
		<a href="javascript:search_order_history('six_month')" class="badge">6개월</a>
		<button onclick="location.href='${contextPath}/admin/goods/addNewGoodsForm.do'">추가하기</button>
	</div>
	<div>
		<table>
			<tr>
				<td style="width: 70px;">상품번호</td>
				<td>상품이름</td>
				<td>상품가격</td>
				<td>등록일</td>
				<td>-</td>
			</tr>
			<c:choose>
				<c:when test="${empty newGoodsList }">
					<tr>
						<td colspan="5">조회된 상품이 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="item" items="${newGoodsList }">
						<tr>
							<td>${item.goodsId }</td>
							<td><a href="${contextPath }/admin/goods/modifyGoodsForm.do?goodsId=${item.goodsId}">${item.goodsTitle }</a></td>
							<td><fmt:formatNumber value="${item.goodsSalesPrice }" var="goodsSalesPrice" pattern="#,###"/>
								${goodsSalesPrice }
							</td>
							<td>${item.goodsCreDate }</td>
							<td style="width: 100px;"><button onclick="location.href='${contextPath }/admin/goods/deleteGoods.do?goodsId=${item.goodsId}'">삭제</button></td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
		
		<div class="pages">
			<c:forEach var="page" begin="1" end="10" step="1">
				<a href="${contextPath}/admin/goods/adminGoodsMain.do?chapter=${section}&pageNum=${page}">${(section-1)*10 +page }</a>
			</c:forEach> 
		</div>
	</div>
</div>



<script>

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
		formObj.action = "${contextPath}/admin/goods/adminGoodsMain.do";
		formObj.submit();
	}
	//버튼식 상품조회 badge url에 따른 style변경
	if (window.location.href.includes("fixedSearchPeriod")) {
	    const badges = document.querySelectorAll(".badge");
	    badges.forEach(b => b.classList.remove("active1"));
	    
	    if (window.location.href.includes("today")) {
	        badges[0].classList.add("active1");
	    } else if (window.location.href.includes("one_month")) {
	        badges[1].classList.add("active1");
	    } else if (window.location.href.includes("two_month")) {
	        badges[2].classList.add("active1");
	    } else if (window.location.href.includes("three_month")) {
	        badges[3].classList.add("active1");
	    } else if (window.location.href.includes("six_month")) {
	        badges[4].classList.add("active1");
	    }
}
</script>