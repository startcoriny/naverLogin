<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="membersLen" value="${sessionScope.membersLen}" /> <!-- 총회원수 -->


<div class="detail_box">
	<h3 align="left" style="margin: 30px 0;">회원관리</h3>
	<form name="frm_mod_member" id="admin_member">
		<div align="left">
			<a href="javascript:search_order_history('today')" class="badge">오늘</a> 
			<a href="javascript:search_order_history('one_month')" class="badge">1개월</a> 
			<a href="javascript:search_order_history('two_month')" class="badge">2개월</a> 
			<a href="javascript:search_order_history('three_month')" class="badge">3개월</a> 
			<a href="javascript:search_order_history('six_month')" class="badge">6개월</a>
			<span>회원수 : ${membersLen }</span>
		</div>

		<div>
			<table class="admin_member_table">
				<tr>
					<td>회원ID</td>
					<td>회원정보</td>
					<td>배송정보</td>
					<td>가입일/탈퇴여부</td>
					<td>-</td>
				</tr>

				<c:choose>
					<c:when test="${empty member_list }">
						<tr>
							<td colspan="5">조회된 회원이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="item" items="${member_list }" varStatus="item_num">
							<tr>
								<td>${item.memberId }</td>
								<td>
									<div>
										<span>이름</span>
										<input type="text" value="${item.memberName }" name="memberName" placeholder="이름" readonly>
									</div>
									<div>
										<span>아이디</span>
										<input type="text" value="${item.memberId }" name="memberId" placeholder="아이디" readonly>
									</div>
									<div>
										<span>비밀번호</span>
										<input type="text" value="${item.memberPw }" name="memberPw" placeholder="비밀번호" readonly>
									</div>
									<div>
										<span>휴대전화</span>
										<input type="text" value="${item.hp1 }" name="hp1" placeholder="휴대전화" readonly>
									</div>
								</td>
								<td>
									<div>
										<span>우편번호</span>
										<input type="text" placeholder="우편번호" value="${item.zipcode }" name="zipcode" readonly>
									</div>
									<div>
										<span>주소</span>
										<input type="text" placeholder="주소" value="${item.address }" name="address" readonly>
									</div>
									<div>
										<span>상세주소</span>
										<input type="text" placeholder="상세주소" value="${item.subaddress }" name="subaddress" readonly>
									</div>
								</td>
								<td>
								<c:choose>
									<c:when test="${item.del_yn == 'N' }">
										<span>활동중</span>
									</c:when>
									<c:otherwise>
										<span>탈퇴</span>
									</c:otherwise>
								</c:choose>
								<br>${item.joinDate }</td>
								<td>
									<button onclick="fn_delete_member('${item.memberId}','Y')">탈퇴</button>
								</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
			<div class="pages">
			<c:forEach var="page" begin="1" end="10" step="1">
				<a href="${contextPath}/admin/member/adminMemberMain.do?chapter=${section}&pageNum=${page}">${(section-1)*10 +page }</a>
			</c:forEach> 
		</div>
		</div>
	</form>
</div>



<script>

function search_order_history(fixedSearchPeriod) {
	var formObj = document.createElement("form");
	var i_fixedSearch_period = document.createElement("input");
	i_fixedSearch_period.name = "fixedSearchPeriod";
	i_fixedSearch_period.value = fixedSearchPeriod;
	formObj.appendChild(i_fixedSearch_period);
	document.body.appendChild(formObj);
	formObj.method = "get";
	formObj.action = "${contextPath}/admin/member/adminMemberMain.do";
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


function fn_delete_member(memberId,del_yn) {
	var memberId=memberId;
	var del_yn=del_yn;
	
	//confirm단계를 거치고 사용자가 취소를 누를경우 삭제를 취소한다.
	var answer=confirm("해당회원을 삭제하시겠습니까?");
	if(answer==true){
		$.ajax({
			type : "post",
			async : false,
			url : "${contextPath}/mypage/deleteMember.do",
			data : {
				memberId:memberId,
				del_yn:del_yn
			},
			success : function(data, textStatus) {
				if(data.trim()=='delete_success'){
					alert("삭제되었습니다.");
					location.href="${contextPath}/admin/member/adminMemberMain.do";
				}else if(data.trim()=='failed'){
					alert("다시 시도해 주세요.");	
				}
			},
			error : function(data, textStatus) {
				alert("에러가 발생했습니다."+data);
			},
			complete : function(data, textStatus) {}
		});
	}
}



</script>