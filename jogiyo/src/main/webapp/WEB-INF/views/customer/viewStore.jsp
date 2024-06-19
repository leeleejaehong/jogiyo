<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
							<div class="menu-item-price">${menu.price}원</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</c:forEach>
		<button onclick='CheckboxOrder()'>주문</button>
		<div id="result"></div>

		<form id="myForm" action="/customer/basketList.do" method="POST">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" id="sub" name="sub">
			<input type="hidden" id="sub2" name="sub2" value="${store.storename}">
			<button onclick='basketList()'>주문서 전송</button>
		</form>
	</div>

	<div id="Review" class="tabcontent">
		<h3>리뷰 탭</h3>
		<p>여기에 리뷰 내용이 들어갑니다.</p>
	</div>

	<div id="Info" class="tabcontent">
		<h3>${store.storecontent}</h3>
		<p>여기에 카카오 지도 넣어주세요.</p>
	</div>
</div>
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

	// 탭이 로드될 때 첫 번째 탭을 열도록 설정
	document.getElementById("defaultOpen").click();
	//체크박스에 선택된 값 출력
	   function CheckboxOrder()  {
	        // 선택된 목록 가져오기
	        const query = 'input[name="menu"]:checked';
	        const selectedEls = 
	            document.querySelectorAll(query);
	        
	        // 선택된 목록에서 value 찾기
	        let result = '';
	        selectedEls.forEach((el) => {
	          result += el.value + ',';
	        });
	        
	        // 출력
	        document.getElementById('result').innerText
	          = result;
	      }

	 
	   function basketList() {
	       var result = document.getElementById('result').innerText; // 가져올 데이터
	       document.getElementById('sub').value = result;
	       document.getElementById('myForm').submit();
	   }
</script>
<jsp:include page="../footer.jsp" />