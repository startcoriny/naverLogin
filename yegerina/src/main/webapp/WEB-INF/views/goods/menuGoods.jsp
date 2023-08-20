<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<div >
	<div>
		<div>		
			<!-- 카테고리 명 -->
			<p align="left" style="font-size: 25px; font-weight: 600; margin: 30px 0;">${menuGoods}</p>
			<!-- 카테고리 명 -->
		</div>
	</div>
	
	<c:choose>
		<c:when test="${menuGoods=='Top'}">
			<div class="categori_Title">
				<a href="${contextPath}/goods/menuGoodsitem.do?menuGoodsitem=티셔츠" style="border: 1px solid;">티셔츠</a>
				<a href="${contextPath}/goods/menuGoodsitem.do?menuGoodsitem=블라우스/셔츠" style="border: 1px solid;">블라우스/셔츠</a>
				<a href="${contextPath}/goods/menuGoodsitem.do?menuGoodsitem=니트" style="border: 1px solid;">니트</a>
				<a href="${contextPath}/goods/menuGoodsitem.do?menuGoodsitem=롱슬리브" style="border: 1px solid;">롱슬리브</a>
				<a href="${contextPath}/goods/menuGoodsitem.do?menuGoodsitem=후드티" style="border: 1px solid;">후드티</a>
				<a href="${contextPath}/goods/menuGoodsitem.do?menuGoodsitem=맨투맨" style="border: 1px solid;">맨투맨</a>
			</div>	
		</c:when>
		<c:when test="${menuGoods=='Bottom'}">
			<div class="categori_Title">
				<a href="${contextPath}/goods/menuGoodsitem.do?menuGoodsitem=긴바지" style="border: 1px solid;">긴바지</a>
				<a href="${contextPath}/goods/menuGoodsitem.do?menuGoodsitem=반바지" style="border: 1px solid;">반바지</a>
				<a href="${contextPath}/goods/menuGoodsitem.do?menuGoodsitem=슬랙스" style="border: 1px solid;">슬랙스</a>
				<a href="${contextPath}/goods/menuGoodsitem.do?menuGoodsitem=레깅스" style="border: 1px solid;">레깅스</a>
				<a href="${contextPath}/goods/menuGoodsitem.do?menuGoodsitem=멜빵" style="border: 1px solid;">멜빵</a>
				<a href="${contextPath}/goods/menuGoodsitem.do?menuGoodsitem=츄리닝" style="border: 1px solid;">츄리닝</a>
			</div>	
		</c:when>
		<c:when test="${menuGoods=='Outer'}">
			<div class="categori_Title">
				<a href="${contextPath}/goods/menuGoodsitem.do?menuGoodsitem=가디건" style="border: 1px solid;">가디건</a>
				<a href="${contextPath}/goods/menuGoodsitem.do?menuGoodsitem=점퍼" style="border: 1px solid;">점퍼</a>
				<a href="${contextPath}/goods/menuGoodsitem.do?menuGoodsitem=야상" style="border: 1px solid;">야상</a>
				<a href="${contextPath}/goods/menuGoodsitem.do?menuGoodsitem=코트" style="border: 1px solid;">코트</a>
				<a href="${contextPath}/goods/menuGoodsitem.do?menuGoodsitem=자켓" style="border: 1px solid;">자켓</a>
				<a href="${contextPath}/goods/menuGoodsitem.do?menuGoodsitem=패딩" style="border: 1px solid;">패딩</a>
			</div>	
		</c:when>
		<c:when test="${menuGoods=='Skirt'}">
			<div class="categori_Title">
				<a href="${contextPath}/goods/menuGoodsitem.do?menuGoodsitem=롱치마" style="border: 1px solid;">롱치마</a>
				<a href="${contextPath}/goods/menuGoodsitem.do?menuGoodsitem=스커트" style="border: 1px solid;">스커트</a>
				<a href="${contextPath}/goods/menuGoodsitem.do?menuGoodsitem=원피스" style="border: 1px solid;">원피스</a>
			</div>	
		</c:when>
		<c:otherwise>
		</c:otherwise>
	
	</c:choose>
	

	<div class="categori_container">
			<c:choose>
			
				<c:when test="${empty goodsList}">
					<br>
					<br>
					<br>
					해당 카테고리에 상품이 없습니다.
				</c:when>

				<c:otherwise>
					<div class="categori_goods">
					<c:forEach var="item" items="${goodsList}">
						<div class="categori_goods_item">
							<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goodsId }">
							<%-- 쿼리문자열을 사용하여 변수에 해당아이템의 id를 저장한뒤 상세 페이지로 이동하는 링크를 생성 --%>
													
							<img width="121" height="154" src="${contextPath}/download.do?goods_id=${item.goodsId}&fileName=${item.goodsFileName}">
							<%-- 쿼리문자열을 사용하여 변수에 해당아이템의 id와 해당아이템의 filename을 저장한뒤 해당하는 상품 이미지 표시 --%>
							</a> 
	
							<div class="title" align="left" style="font-weight:500; font-size: 19px">${item.goodsTitle }</div>
							<%-- 해당item의 이름 --%>
							
							<div class="price" align="left" style="font-weight: bold; font-size: 20px">
								<fmt:formatNumber value="${item.goodsSalesPrice}" type="number"
									var="goods_price" />
								${goods_price}원
							</div>
						</div>
					</c:forEach>
					</div>
				</c:otherwise>

			</c:choose>
	</div>
</div>