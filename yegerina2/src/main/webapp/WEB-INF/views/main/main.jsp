<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<%
	request.setCharacterEncoding("UTF-8");
%>


<div class="main_container">
	<div class="slideshow-container">
		<div class="mySlides fade">
			<div class="numbertext"></div>
			<img src="${contextPath }/resources/image/main_images_01.gif" alt="">
		</div>
		<div class="mySlides fade">
			<div class="numbertext"></div>
			<img src="${contextPath }/resources/image/main_images_02.jpg" alt="">
		</div>
		<div class="mySlides fade">
			<div class="numbertext"></div>
			<img src="${contextPath }/resources/image/main_images_03.jpg" alt="">
		</div>
		<div>
			<span class="dot"></span> <span class="dot"></span> <span class="dot"></span>
		</div>
	</div>


	<article>
	
		<h2>BEST - ITEMS</h2>
		<div class="main_text">주간 인기상품 확인해보세요</div>
		<div class="container_main">


			<div class="main_goods">
				<!-- MainController에서 바인딩된 데이터를 사용 -->
				<c:forEach var="item" items="${goodsMap.BEST_20 }">
				<%-- BEST_20이라는 키로 저장된 리스트를 가져와서 각각의 아이템(item)에 대해 반복 --%>
					
					<div class="goods">
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
						<%-- 해당item의 가격 --%>
						<%-- fmt:formatNumber - JSTL(JavaServer Pages Standard Tag Library)의 하나
							* 숫자를 형식화 하는데 사용되는 태그
							  type속성 : 형식화 타입을 지정
							  var속성 : 형식화된 값을 저장할 변수의 이름을 지정
							  type"number"를 성정하면 숫자가 ##,### 형식으로 자동으로 설정되어 문자열로 저장 --%>
					</div>
				</c:forEach>
			</div>

		</div>
	</article>

	<article>

		<h2>NEW - ITEMS</h2>
		<div class="main_text">주간 신상품을 만나보세요!</div>
		<div class="new_container_main">
		
			<div class="main_goods">
				<c:forEach var="item" items="${goodsMap.NEW_ITEM }">
					<div class="goods">
						<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goodsId }">						
						<img width="121" height="154" src="${contextPath}/download.do?goods_id=${item.goodsId}&fileName=${item.goodsFileName}">
						</a> 

						<div class="title" align="left" style="font-weight:500; font-size: 19px">${item.goodsTitle }</div>
						<div class="price" align="left" style="font-weight: bold; font-size: 20px">
							<fmt:formatNumber value="${item.goodsSalesPrice}" type="number"
								var="goods_price" />
							${goods_price}원
						</div>
					</div>
				</c:forEach>
			</div>		
		
		
		
		</div>
	</article>

	<article>
		<h2>REVIEW</h2>
		<div>후기를 남겨주세요~</div>
	</article>
</div>
