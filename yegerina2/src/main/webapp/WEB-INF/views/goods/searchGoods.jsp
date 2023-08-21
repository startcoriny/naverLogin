<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<head>
 <title>검색 상품 목록 페이지</title>
</head>
<body>
	<div class="searchResult">
	
		<h1>${searchWord }검색 결과</h1>
		
	</div>
	
	<div id="searchgoods">	
		<div id="carousel_inner">
			<ul id="carousel_ul">
				<c:choose>
				   <c:when test="${ empty goodsList  }" >
				   		<li>
							<div id="book">
								<a><h1>제품이없습니다.</h1></a>
						  	</div>
						</li> 
				   </c:when>
				   <c:otherwise>
				    	<c:forEach var="item" items="${goodsList }" >
				     		<li>
								<div id="book">
									<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goodsId}">
										<img width="75" src="${contextPath}/download.do?goods_id=${item.goodsId}&fileName=${item.goodsFileName}">
									</a>
							
									<div class="title">
										<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goodsId }">
								  			${item.goodsTitle}
										</a>
									</div>
									<div class="price">
										<span>
								  			<fmt:formatNumber  value="${item.goodsSalesPrice}" type="number" var="goods_price" />
			                         			${goods_price}원
										</span> <br>
								 			<fmt:formatNumber  value="${item.goodsSalesPrice*0.9}" type="number" var="discounted_price" />
					              	 			${discounted_price}원(10%할인)
									</div>
								</div>
							</li>
						</c:forEach> 
				   </c:otherwise>
				 </c:choose>
			 </ul>
		</div>
	</div>
