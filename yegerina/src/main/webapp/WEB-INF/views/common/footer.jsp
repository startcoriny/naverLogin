<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"    
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />


    <section>
        <nav>
            <ul>
                <li><a href="#">회사소개</a></li>
                <li><a href="#">이용약관</a></li>
                <li><a href="#">개인정보 처리방침</a></li>
                <li><a href="#">이용안내</a></li>
                <li><a href="#">제휴문의</a></li>
            </ul>
        </nav>
    </section>

    <section class="info">
        <ul>
            <li>
                <h6>CUSTOMER CENTER</h6> 
                <div class="centerNb"> 010-1234-1234</div>
                <span> 평일 오후 1:00 ~ 오후 6:00</span><br>
                <span> 점심시간 오후 12:00 ~ 오후 1:00</span><br>
                <span> 토 / 일 / 공휴일 휴무</span>
            </li>
            <li>
                <h6>ACCOUNT INFO</h6> 
                <span> 둘은행 123-1234-5678-90</span><br>
                <span> 예금주 : 주식회사 A</span>
            </li>
            <li>
                <h6>FAVORITE MENU</h6> 
                <span><a href="#">로그인</a><a href="#">/ 회원가입</a></span><br>
                <span><a href="#">관심상품</a></span><br>
                <span><a href="#">장바구니</a></span><br>
                <span><a href="#">주문조회</a></span><br>
                <span><a href="#">마이페이지</a></span>
            </li>
            <li>
                <h6>RETURN / EXCHANGE</h6> 
                <span>123456 서울특별시 성남시 안양시 cj대한통운 지민1팀 'A'</span><br>
                <span>[CJ 대한통운 택배 가상주소로 CJ택배로만 반품 가능합니다.]</span><br>
            </li>
        </ul>
    </section>


