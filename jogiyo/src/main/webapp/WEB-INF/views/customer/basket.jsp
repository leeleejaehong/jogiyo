<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/basket.css">
<jsp:include page="../js/basket_js.jsp" />
<div class="content_subject">
	<span>장바구니</span>
</div>
<!-- 장바구니 리스트 -->
<div class="content_middle_section"></div>
<!-- 장바구니 가격 합계 -->
<!-- cartInfo -->
<div class="content_totalCount_section">
	<table class="order-table">
		<caption>표 제목 부분</caption>
		<tbody>
			<tr>
				<th class="td_width_1"></th>
				<th class="td_width_2"></th>
				<th class="td_width_3">상품명</th>
				<th class="td_width_4">가격</th>
				<th class="td_width_4">수량</th>
				<th class="td_width_4">합계</th>
				<th class="td_width_4">삭제</th>
			</tr>
		</tbody>
	</table>
	<table>
		<caption>표 내용 부분</caption>
		<tbody>
			<c:forEach items="${basket}" var="ba">
				<tr class="basketTable">
					<td class="td_width_1" style="display: none;">${ba.menuid}</td>
					<td class="td_width_2">${ba.img}</td>
					<td class="td_width_3">${ba.menuname}</td>
					<td class="td_width_4 price_td"><span class="red_color"><fmt:formatNumber
								value="${ba.price}" pattern="##,### 원" /></span><br></td>
					<td class="td_width_4 table_text_align_center">
						<div class="table_text_align_center quantity_div">
							<input type="text" value="${ba.qty}" class="quantity_input">
							<input type="hidden" value="${ba.storeid}" class="storeid_input">
							<input type="hidden" value="${ba.jscateid}" class="cateid_input">
							<button class="quantity_btn plus_btn">+</button>
							<button class="quantity_btn minus_btn">-</button>
						</div> <a class="quantity_modify_btn">변경</a>
					</td>
					<td class="td_width_4"><span class="red_color"><fmt:formatNumber
								value="${ba.totprice}" pattern="##,### 원" /></span><br></td>
					 <td class="td_width_4 table_text_align_center delete_btn">
                              <button onclick="deleteBasket(${ba.basketid})">삭제</button></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<table class="list_table">
	</table>
</div><br><br>
<div class="order-table-container">
    <div class="address-inputs">
    <h3>배달 주소지 입력</h3>
        <input type="text" name="postcode" id="postcode" placeholder="우편번호" title="우편번호">
        <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기">
        <input type="text" name="address" id="address" placeholder="주소" title="주소">
        <input type="text" name="extraaddress" id="extraAddress" placeholder="참고항목" title="참고항목">
        <input type="text" name="detailaddress" id="detailAddress" placeholder="상세주소" title="상세주소">
    </div>
    <div class="actions">
        <button id="kaobtn" onclick="Pay()">카카오페이</button>
        <button onclick="">메뉴추가</button>
    </div>
</div>
<br><br>

<jsp:include page="../footer.jsp" />