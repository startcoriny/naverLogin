<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="goods" value="${goodsMap.goods}" />
<c:set var="imageFileList" value="${goodsMap.imageFileList}" />


<div class="detail_box goods_form">
	<h2>상품수정</h2>
	<form name="frm_modify_goods" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>카테고리</td>
				<td><select name="goodsSort">
					<option value="TOP">TOP</option>
					<option value="Bottom">Bottom</option>
					<option value="Outer">Outer</option>
					<option value="Skirt">Skirt</option>
				</select></td>
			</tr>
			<tr>
				<td>상품이름</td>
				<td>
					<input type="text" placeholder="상품이름" value="${goods.goodsTitle }" name="goodsTitle">
				</td>
			</tr>
			<tr>
				<td>상품소개</td>
				<td>
					<select name="goodsWriterIntro">								
						<option value="티셔츠">티셔츠</option>
						<option value="블라우스/셔츠">블라우스/셔츠</option>
						<option value="니트">니트</option>
						<option value="롱슬리브">롱슬리브</option>
						<option value="후드티">후드티</option>
						<option value="맨투맨">맨투맨</option>							
						<option value="긴바지">긴바지</option>
						<option value="반바지">반바지</option>
						<option value="슬랙스">슬랙스</option>
						<option value="레깅스">레깅스</option>
						<option value="멜빵">멜빵</option>
						<option value="츄리닝">츄리닝</option>							
						<option value="가디건">가디건</option>
						<option value="점퍼">점퍼</option>
						<option value="야상">야상</option>
						<option value="코트">코트</option>
						<option value="자켓">자켓</option>
						<option value="패딩">패딩</option>							
						<option value="롱치마">롱치마</option>
						<option value="스커트">스커트</option>
						<option value="원피스">원피스</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>상품판매가격</td>
				<td>
					<input type="text" placeholder="상품판매가격" value="${goods.goodsSalesPrice }" name="goodsSalesPrice">
				</td>
			</tr>
			<tr>
				<td>배송비</td>
				<td>
					0
				</td>
			</tr>
			<tr>
				<td>상품배송일</td>
				<td>
					<input type="date" value="${goods.goodsDeliveryDate }" name="goodsDeliveryDate">
				</td>
			</tr>
			<tr>
				<td>상품분류</td>
				<td>
					<select name="goodsStatus">
						<option value="best20">bestItem</option>
						<option value="newItem">신상품</option>
						<option value="sale">세일중</option>
						<option value="Item">일반 상품</option>
					</select>
					<input type="hidden" name="h_goods_status" value="${goods.goodsStatus }">
				</td>
			</tr>
			<c:forEach var="item" items="${imageFileList }" varStatus="itemNum">
				<c:choose>
					<c:when test="${item.fileType=='main_image' }">
						<tr>
							<td rowspan="2">상품 이미지</td>
							<td>메인 이미지 <input type="file" id="main_image" name="main_image" onchange="readURL(this,'preview${itemNum.count }');">
								<input type="hidden" name="imageId" value="${item.imageId }">
								<img id="preview${itemNum.count }" width="150" src="${contextPath}/download.do?goods_id=${item.goodsId}&fileName=${item.fileName}">
							</td>
							
						</tr>
					</c:when>
					<c:otherwise>
						<tr>
							<td>상세 이미지 <input type="file" id="detail_image" name="detail_image" onchange="readURL(this,'preview${itemNum.count }');">
								<input type="hidden" name="imageId" value="${item.imageId }">
								<img id="preview${itemNum.count }" width="150" style="background-size: cover;" src="${contextPath}/download.do?goods_id=${item.goodsId}&fileName=${item.fileName}">
							</td>
						</tr>
					</c:otherwise>						
				</c:choose>
			</c:forEach>
		</table>
		<button type="submit" formaction="${contextPath }/admin/goods/modifyGoodsInfo.do?goodsId=${goods.goodsId}">수정하기</button>
	</form>
</div>


<script>


function readURL(input,preview) {
	//  alert(preview);
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#'+preview).attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
  }  
</script>