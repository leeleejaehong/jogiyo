<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Gothic+A1&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/main.css">
<script type="text/javascript">
function viewStore(id) {
    var form = document.createElement('form');
    form.method = 'POST';
    form.action = '/customer/viewStore.do';

    var idInput = document.createElement('input');
    idInput.type = 'hidden';
    idInput.name = 'storeid';
    idInput.value = id;
    form.appendChild(idInput);

    document.body.appendChild(form);
    form.submit();
}
</script>
<title>조기요</title>
</head>

<body>

	<div class="header">
		<ul class="menu">
			<li><a href="${pageContext.request.contextPath}/index.do">죠기요</a></li>
			<li><a href="#">스토어</a>
				<ul class="submenu">
					<li><a
						href="${pageContext.request.contextPath}/store/AddStore.do">스토어
							추가하기</a></li>
					<li><a
						href="${pageContext.request.contextPath}/store/Myinfo.do">내
							정보(점주)</a></li>
					<li><a
						href="${pageContext.request.contextPath}/customer/mypage.do">내정보
							보기(일반사용자)</a></li>
					<li><a
						href="${pageContext.request.contextPath}/customer/pastOrder.do">과거
							주문내역</a></li>
					<li><a
						href="${pageContext.request.contextPath}/customer/basket.do">장바구니</a></li>
					<li><a
						href="${pageContext.request.contextPath}/customer/coupon.do">내쿠폰</a></li>
					<li><a
						href="${pageContext.request.contextPath}/store/ListStore.do">내
							가게리스트</a></li>
					<li><a href="${pageContext.request.contextPath}/store/test.do">맵</a></li>
				</ul></li>
			<li><a href="#">관리</a>
				<ul class="submenu">
					<li><a
						href="${pageContext.request.contextPath}/admin/insertCate.do">카테고리
							추가</a></li>
					<li><a
						href="${pageContext.request.contextPath}/admin/viewSales.do">매출현황
							보기</a></li>
					<li><a
						href="${pageContext.request.contextPath}/admin/notice.do">공지사항
							추가</a></li>
					<li><a
						href="${pageContext.request.contextPath}/admin/listAcc.do">사용자
							관리</a></li>
				</ul></li>
			<li><a
				href="${pageContext.request.contextPath}/customer/mypage.do">내정보
					보기</a></li>
		</ul>
		<a href="#" onclick="viewStore(1)">가게보기테스트버튼</a>
		<div class="login">
			<c:if test="${empty jId}">
				<button class="login-btn"
					onclick="window.location.href='${pageContext.request.contextPath}/login/login.do'">로그인</button>
			</c:if>
			<c:if test="${not empty jId}">
				<button class="login-btn"
					onclick="window.location.href='${pageContext.request.contextPath}/login/logout.do'">로그아웃</button>
			</c:if>
		</div>
	</div>

	<div class="search-section">
		<div class="container">
			<h1>어디로 배달해 드릴까요?</h1>
			<p>배달받으실 동 이름으로 검색해주세요</p>
			<div class="search-bar">
				<button class="location-btn">
					<img src="/images/loca.svg" alt="location icon">
				</button>
				<input type="text" placeholder="주소를 입력해주세요" id="search-input">
				<button class="x-button" onclick="clearSearch()">X</button>
				<button>검색</button>
				<div class="dropdown">
					<a href="#">현재위치로 설정하기</a> <a href="#">검색 기록 1</a> <a href="#">검색
						기록 2</a>
				</div>
			</div>
		</div>
	</div>
	<script>
		function clearSearch() {
			document.getElementById('search-input').value = '';
		}
		document.addEventListener("DOMContentLoaded", function() {
			const menuItems = document.querySelectorAll(".menu > li");

			menuItems.forEach(function(menuItem) {
				menuItem.addEventListener("mouseover", function() {
					const submenu = this.querySelector(".submenu");
					if (submenu) {
						submenu.style.display = "block";
					}
				});

				menuItem.addEventListener("mouseleave", function() {
					const submenu = this.querySelector(".submenu");
					if (submenu) {
						submenu.style.display = "none";
					}
				});
			});
		});
	</script>