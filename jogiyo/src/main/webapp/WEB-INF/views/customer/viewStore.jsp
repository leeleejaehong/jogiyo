<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/star.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
.tab {
	overflow: hidden;
	border: 1px solid #ccc;
	background-color: #f1f1f1;
}

.tab button {
	background-color: inherit;
	float: left;
	border: none;
	outline: none;
	cursor: pointer;
	padding: 14px 16px;
	transition: 0.3s;
}

.tab button:hover {
	background-color: #ddd;
}

.tab button.active {
	background-color: #ccc;
}

.tabcontent {
	display: none;
	padding: 6px 12px;
	border: 1px solid #ccc;
	border-top: none;
}

.menu-item {
	display: flex;
	align-items: center;
	justify-content: space-between;
	border-bottom: 1px solid #ddd;
	padding: 10px 0;
}

.menu-item img {
	width: 50px;
	height: 50px;
}

.menu-item-content {
	flex-grow: 1;
	margin-left: 10px;
}

.menu-item-title {
	font-size: 16px;
	font-weight: bold;
}

.menu-item-description {
	font-size: 14px;
	color: #555;
}

.menu-item-price {
	font-size: 14px;
	font-weight: bold;
}

.dropdown {
	border: 1px solid #ddd;
	margin-top: 10px;
}

.dropdown .dropbtn {
	width: 100%;
	background-color: #f1f1f1;
	color: #333;
	padding: 14px 20px;
	font-size: 16px;
	border: none;
	cursor: pointer;
	text-align: left;
	transition: background-color 0.3s, color 0.3s;
}

.dropdown .dropbtn:hover, .dropdown .dropbtn.active {
	background-color: #ddd;
	color: #000;
}

.dropdown .dropbtn:focus {
	outline: none;
}

.dropdown-content {
	display: none;
	padding: 10px;
}

.dropdown .dropbtn.active+.dropdown-content {
	display: block;
}
</style>
<script>

	function openTab(evt, tabName) {
		var i, tabcontent, tablinks;
		tabcontent = document.getElementsByClassName("tabcontent");
		for (i = 0; i < tabcontent.length; i++) {
			tabcontent[i].style.display = "none";
		}
		tablinks = document.getElementsByClassName("tablinks");
		for (i = 0; i < tablinks.length; i++) {
			tablinks[i].className = tablinks[i].className
					.replace(" active", "");
		}
		document.getElementById(tabName).style.display = "block";
		evt.currentTarget.className += " active";
	}

	function toggleDropdown(button) {
		button.classList.toggle("active");
	}


	function insertBasket() {
	    // 선택된 목록 가져오기
	    const query = 'input[name="menu"]:checked';
	    const selectedEls = document.querySelectorAll(query);
	    
	    // 선택된 목록에서 데이터 추출
	    let result = [];
	    selectedEls.forEach((el) => {
	        let menuid = el.value;
	        let price = el.closest('.menu-item').querySelector('.menu-item-price').innerText.trim();
	        let quantity = el.closest('.menu-item').querySelector('select').value;
	        result.push({ menuid: menuid, price: price, mqty: quantity });
	    });
	    
	    // 서버로 데이터 전송
	    var csrfToken = $("meta[name='_csrf']").attr("content");
	    var csrfHeader = $("meta[name='_csrf_header']").attr("content");
	    $.ajax({
	        url: "insertBasket.ajax",
	        type: "POST",
	        contentType: "application/json", // JSON 형식으로 데이터 전송
	        data: JSON.stringify(result), // 배열을 직접 보냅니다
	        beforeSend: function(xhr) {
	            xhr.setRequestHeader(csrfHeader, csrfToken);
	        },
	        success: function(res) {
	            // 성공 시 처리
	            console.log(res)
	        },
	        error: function(err) {
	            console.error("Error:", err);
	        }
	    });
	}

	 
	   function basketList() {
	       var result = document.getElementById('result').innerText; // 가져올 데이터
	       document.getElementById('sub').value = result;
	       document.getElementById('myForm').submit();
	   }
</script>
<div align="center">
	<span>${store.storename}</span>
	<hr>
	<img
		src="${pageContext.request.contextPath}/resources/img/${store.img}">
	<p>내용</p>
	<div class="tab">
		<button class="tablinks" onclick="openTab(event, 'Menu')"
			id="defaultOpen">메뉴</button>
		<button class="tablinks" onclick="openTab(event, 'Review')">리뷰</button>
		<button class="tablinks" onclick="openTab(event, 'Info')">정보</button>
	</div>

	<div id="Menu" class="tabcontent">
		<h3>메뉴 탭</h3>
		<c:forEach items="${menuMap}" var="map">
			<div class="dropdown">
				<button class="dropbtn active" onclick="toggleDropdown(this)">${map.key}</button>
				<div class="dropdown-content">
					<c:forEach items="${map.value}" var="menu">
						<div class="menu-item">
							<img src="${menu.img}" alt="${menu.menuname}">
							<div class="menu-item-content">
								<div class="menu-item-title">${menu.menuname}</div>
								<span class='label'> <input type='checkbox'
									id='dataInput' name='menu' value='${menu.menuid}' />
									${menu.menuname}
								</span>
							</div>
							<div class="menu-item-description">${menu.menucontent}</div>
							<div class="menu-item-price">${menu.price}</div>원
							<div class="menu-item-qty">
								<select>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
								</select>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</c:forEach>
		<button onclick='insertBasket()'>장바구니담기</button>
		<div id="result"></div>

		<form id="myForm" action="/customer/basketList.do" method="POST">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" id="sub" name="sub">
			<input type="hidden" id="sub2" name="sub2" value="${store.storename}">
			<button onclick='basketList()'>주문서 전송</button>
		</form>
	</div>

	<div id="Review" class="tabcontent">
		<form method="post" action="custmer/insertReview.do">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="storeid" value="${store.storeid}">
		<ul id="main">
			<li>
				<ul class="row">
					<li>별점</li>		
					<li>
					<fieldset>
				        <input type="radio" name="grade" value="5" id="rate1"><label for="rate1">⭐</label>
				        <input type="radio" name="grade" value="4" id="rate2"><label for="rate2">⭐</label>
				        <input type="radio" name="grade" value="3" id="rate3"><label for="rate3">⭐</label>
				        <input type="radio" name="grade" value="2" id="rate4"><label for="rate4">⭐</label>
				        <input type="radio" name="grade" value="1" id="rate5"><label for="rate5">⭐</label>
				    </fieldset>
    				</li>		
				</ul>
			</li>
			<li>
				<h3>리뷰 탭</h3>
				리뷰내용 :<input type="text" placeholder="리뷰내용을 써주세요" name="revcontent">
				<input type="submit" value="작성">
			</li>
			</ul>
		</form>
	</div>

	<div id="Info" class="tabcontent">
		<h3>${store.storecontent}</h3>
		<p>여기에 카카오 지도 넣어주세요.</p>
	</div>
</div>
<script>
//탭이 로드될 때 첫 번째 탭을 열도록 설정
document.getElementById("defaultOpen").click();
</script>
<jsp:include page="../footer.jsp" />