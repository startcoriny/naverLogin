<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>



<div class="myDetail_info_container">

				<h3 align="left" style="margin: 30px;">회원 정보 수정</h3>

					<form name="frm_mod_member">
					<div class="">
							<table class="mydetailinfo_table">
							
								<!-- 이름 -->
								<tr>
									<td class="" style="width: 200px;">이름</td>
									<td class=""><input style="width: 200px;" class="" name="memberName" type="text" size="20" value="${memberInfo.memberName }" disabled /></td>
								</tr>
								
								<!-- 아이디 -->
								<tr>
									<td class="" style="width: 200px;">아이디</td>
									<td class=""><input style="width: 200px;" name="memberId" class="" type="text" size="20" value="${memberInfo.memberId }" disabled /></td>
								</tr>
								
								<!-- 비밀번호 -->
								<tr>
									<td class="" style="width: 200px;">비밀번호</td>
									<td class=""><input style="width: 200px;" name="memberPw" class="" type="password" size="20" value="${memberInfo.memberPw }" />
									</td>
								</tr>
								
								<!-- 휴대폰번호 -->
								<tr>
									<td class="" style="width: 200px;">휴대폰번호</td>
									<td class=""><input style="width: 200px;" type="text" class="" name="hp1" size=4 value="${memberInfo.hp1 }"></td>
								</tr>
								<tr>
									<td class="" style="width: 200px;">배송지</td>
									<td class="">
										<div style="width: 395px; line-height: 80px;">
											
											<!-- 우편번호 -->
											<input type="text"  placeholder="우편번호" id="zipcode" name="zipcode" size=5 style="margin-right: 10px;" value="${memberInfo.zipcode }"> 
												
											<!-- 다음 우편번호 검색 -->
											<a href="javascript:execDaumPostcode()">우편번호검색</a>
											<!-- 다음 우편번호 검색 -->
											
										</div> 
										
										<div style="width: 395px; line-height: 80px;">
											<!-- 주소 -->
											<input type="text" id="address" class="" placeholder="주소" name="address" size="50" value="${memberInfo.address }"> 
											
											<!-- 상세주소 -->
											<input type="text" id="subaddress" class="" name="subaddress" size="50" value="${memberInfo.subaddress }">
										</div>
									</td>
								</tr>
							</table>
						</div>

						<!-- 수정 -->
						<a style="margin-left: 10px;" href="javascript:fn_modify_member_info()" class="mydetailinfo_table_btn">수정하기</a>

						<div class="btn_container">
						<!-- 취소, 클릭시  reload-->
						<button type="button" onClick="location.reload()"
							class="cancelbtn">취소하기</button>

						<!-- 탈퇴 -->
						<button type="button"
							onClick="fn_delete_member('${member_info.memberId }','Y')"
							class="outmemberbtn">탈퇴하기</button>						
						</div>

					</form>
				</div>

	<input type="hidden" name="h_hp1" value="${memberInfo.hp1}" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script>
	//다음 주소 찾기
	function execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
				document.getElementById('address').value = data.address;
			}
		}).open();
	}

	//회원정보 수정
	function fn_modify_member_info() {
		var frm_mod_member = document.frm_mod_member.value;
		var memberPw = document.frm_mod_member.memberPw.value;
		var hp1 = document.frm_mod_member.hp1.value;
		var zipcode = document.frm_mod_member.zipcode.value;
		var address = document.frm_mod_member.address.value;
		var subaddress = document.frm_mod_member.subaddress.value;
		$.ajax({
			type : "post",
			async : false, //false인 경우 동기식으로 처리한다.
			url : "${contextPath}/mypage/modifyMyInfo.do",
			data : {
				memberPw : memberPw,
				hp1 : hp1,
				zipcode : zipcode,
				address : address,
				subaddress : subaddress
			},
			success : function(data, textStatus) {
				if (data.trim() == 'mod_success') {
					//성공시 안내
					alert("회원 정보를 수정했습니다.");
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

	//회원탈퇴
	function fn_delete_member(memberId, del_yn) {
		var frm_mod_member = document.frm_mod_member.value;
		var memberId = document.frm_mod_member.memberId.value;

		var answer = confirm("탈퇴하시겠습니까?");
		//confirm answer = true일때 submit
		if (answer == true) {
			$.ajax({
				type : "post",
				async : false,
				url : "${contextPath}/mypage/deleteMember.do",
				data : {
					memberId : memberId,
					del_yn : del_yn
				},
				success : function(data, textStatus) {
					if (data.trim() == 'delete_success') {
						//성공시 안내와 함께 logout.do
						alert("탈퇴되었습니다.");
						location.href = "${contextPath}/member/logout.do";
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
	}
</script>