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
	width: 80px;
	height: 80px;
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
	text-align: center;
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
input.check_btn{
  display:none;
  margin-right: 10px;
  }

input.check_btn + label{
  cursor:pointer;
 }

input.check_btn + label > span{
  vertical-align: middle;
  padding-left: 5px;
 }

/* label:before에 체크하기 전 상태 CSS */
input.check_btn + label:before{
  content:"";
  display:inline-block;
  width:17px;
  height:17px;
  border:2px solid #fa0050;
  border-radius: 4px;
  vertical-align:middle;
  }
  
/* label:before에 체크 된 상태 CSS */  
input.check_btn:checked + label:before{
  content:"";
  background-color:#fa0050;
  border-color:#fa0050;
  background-image: url('check_btn.png');
  background-repeat: no-repeat;
  background-position: 50%;
  }
     .menu-item-qty {
        position: relative;
        font-family: Arial, sans-serif;
        font-size: 16px;
        color: #333;
        width: 150px; /* 선택 박스의 너비 */
        border: 1px solid #ccc;
        border-radius: 4px;
        overflow: hidden; /* 드롭다운 목록이 넘치지 않도록 설정 */
        background-color: #fff;
    }

    /* 선택 박스 스타일 */
    .menu-item-qty select {
        appearance: none; /* 기본 스타일링 제거 (모바일에서 사용) */
        -webkit-appearance: none;
        -moz-appearance: none;
        padding: 10px 30px 10px 10px; /* 내부 패딩 */
        display: block;
        width: 100%;
        border: none;
        background-color: transparent;
        cursor: pointer;
        outline: none;
    }

    /* 드롭다운 화살표 스타일 */
    .menu-item-qty::after {
        content: '\25BC'; /* 화살표 아이콘 (▼) */
        position: absolute;
        top: 50%;
        right: 10px;
        transform: translateY(-50%);
        font-size: 16px;
        pointer-events: none; /* 클릭 이벤트 방지 */
    }

    /* 드롭다운 목록 스타일 */
    .menu-item-qty select option {
        padding: 10px;
        border-bottom: 1px solid #ccc;
    }

    .menu-item-qty select option:last-child {
        border-bottom: none;
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
	        result.push({ menuid: menuid, totprice: price, qty: quantity });
	    });
	    
	    // 서버로 데이터 전송
	    var csrfToken = $("meta[name='_csrf']").attr("content");
	    var csrfHeader = $("meta[name='_csrf_header']").attr("content");
	    $.ajax({
	        url: "insertBasket.ajax",
	        type: "POST",
	        contentType: "application/json; charset=UTF-8", 
	        data: JSON.stringify(result), 
	        beforeSend: function(xhr) {
	            xhr.setRequestHeader(csrfHeader, csrfToken);
	        },
	        success: function(res) {
	        	console.log(res);
	        	if(confirm(res)){
	        		location.href="${pageContext.request.contextPath}/customer/basket.do"
	        	}else {
	                cancelSelection();
	            }
	        },
	        error: function(err) {
	            console.error("Error:", err);
	        }
	    });
	}
	function cancelSelection() {
	    const query = 'input[name="menu"]:checked';
	    const selectedEls = document.querySelectorAll(query);
	    
	    selectedEls.forEach((el) => {
	        el.checked = false;
	        
	        let select = el.closest('.menu-item').querySelector('select');
	        select.value = '1'; 
	    });
	}

	 
	   function basketList() {
		   const query = 'input[name="menu"]:checked';
		   const selectedEls = document.querySelectorAll(query);
		   var menuid = '';
		   selectedEls.forEach((el) => {
		        menuid += el.value + ',';
		   }); 
	       document.getElementById('sub').value = menuid;
	       document.getElementById('myForm').submit();
	   }
	 //바로결제기능
	   function directPay() {
	       // 선택된 목록 가져오기
	       const query = 'input[name="menu"]:checked';
	       const selectedEls = document.querySelectorAll(query);
	       
	       // 선택된 목록에서 데이터 추출
	       let result = [];
	       selectedEls.forEach((el) => {
	           let menuid = el.value;
	           let price = el.closest('.menu-item').querySelector('.menu-item-price').innerText.trim();
	           let quantity = el.closest('.menu-item').querySelector('select').value;
	           let storeid = ${store.storeid};
	           let menuname = el.closest('.menu-item').querySelector('.menu-item-title').innerText.trim();
	           result.push({ menuname:menuname, menuid: menuid, totprice: price, qty: quantity, storeid:storeid });
	       });

	       // 로컬 스토리지에 데이터 저장
	       localStorage.setItem('orderData', JSON.stringify(result));
	       
	       // 결제 페이지로 이동
	       location.href = "${pageContext.request.contextPath}/customer/directPay.do";
	   }
</script>
<div align="center">
    <span>${store.storename}</span>
    <hr>
    <img src="${pageContext.request.contextPath}/resources/img/${store.img}">
    <p>내용</p>
    <div class="tab">
        <button class="tablinks" onclick="openTab(event, 'Menu')" id="defaultOpen">메뉴</button>
        <button class="tablinks" onclick="openTab(event, 'Review')" id="reviewOpen">리뷰</button>
        <button class="tablinks" onclick="openTab(event, 'Info')">정보</button>
    </div>

    <div id="Menu" class="tabcontent">
        <h3>메뉴 탭</h3>
        <c:forEach items="${menuMap}" var="map" varStatus="sta">
            <div class="dropdown">
                <button class="dropbtn active" onclick="toggleDropdown(this)">${map.key}</button>
                <div class="dropdown-content">
                    <c:forEach items="${map.value}" var="menu" varStatus="status">
                        <div class="menu-item">
                            <c:if test="${menu.mqty==1}">
                                <div class="menu-item-content">
                                <img src="${pageContext.request.contextPath}/resources/img/${menu.img}"><br><br>
                                    <span class='label'>
                                        <input type='checkbox' id='dataInput${sta.index}${status.index}' name='menu' class="check_btn" value='${menu.menuid}' />
                                        <label for="dataInput${sta.index}${status.index}" class="menu-item-title" style="color: black;">${menu.menuname}</label><br>
                                   		<span class="menu-item-description">${menu.menucontent}</span>
                                    </span>
                                </div>
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
                            </c:if>
                            <c:if test="${menu.mqty==0}">
                                <div class="menu-item-content">
                                <img src="${pageContext.request.contextPath}/resources/img/${menu.img}"><br><br>
                                    <span class='label'>
                                        <input type='checkbox' disabled id='dataInput${sta.index}${status.index}' name='menu' class="check_btn" value='${menu.menuid}' />
                                        <label for="dataInput${sta.index}${status.index}" class="menu-item-title" style="color: black;">${menu.menuname}[품절]</label><br>
                                        <span class="menu-item-description">${menu.menucontent}</span>
                                    </span>
                                </div>
                                <div class="menu-item-price">${menu.price}</div>원
                                <div class="menu-item-qty">
                                    <select disabled>
                                        <option value="1">품절</option>
                                    </select>
                                </div>
                            </c:if>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:forEach>
        <button onclick='insertBasket()'>장바구니 담기</button>
        <div id="result"></div>

        <form id="myForm" action="/customer/basketList.do" method="POST">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <input type="hidden" id="sub" name="sub">
            <input type="hidden" id="sub2" name="sub2" value="${store.storename}">
            <button onclick='basketList()'>장바구니 담기</button>
        </form>
        <button type="button" onclick="directPay()">주문서 전송</button>
    </div>

    <div id="Review" class="tabcontent">
        <form method="post" action="/customer/insertReview.do" enctype="multipart/form-data">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <input type="hidden" name="storeid" value="${store.storeid}">
            <ul id="main">
                <li>
                    <ul class="row">
                        <li>별점</li>
                        <li>
                            <fieldset>
                                <input type="radio" name="grade" value="5" id="rate5"><label for="rate5">⭐</label>
                                <input type="radio" name="grade" value="4" id="rate4"><label for="rate4">⭐</label>
                                <input type="radio" name="grade" value="3" id="rate3"><label for="rate3">⭐</label>
                                <input type="radio" name="grade" value="2" id="rate2"><label for="rate2">⭐</label>
                                <input type="radio" name="grade" value="1" id="rate1"><label for="rate1">⭐</label>
                            </fieldset>
                        </li>
                    </ul>
                </li>
                <li>
                    <h3>리뷰 탭</h3>
                    리뷰내용 : <textarea placeholder="리뷰내용을 써주세요" name="revcotent"></textarea>
                    <input type="file" name="file"><br>
                    <input type="submit" value="작성">
                </li>
            </ul>
        </form>
        <c:forEach items="${review}" var="re">
            <li class="review-item">
                <div class="review-content">
                    <h2>${re.revcotent}</h2>
                    <c:if test="${not empty re.reply}">
                        <p class="reply">↳${re.reply}</p>
                    </c:if>
                </div>
                <div class="star-rating">
                    <fieldset>
                        <input type="radio" id="star${re.grade}-5" disabled ${re.grade ge 5 ? 'checked' : ''}><label for="star${re.grade}-5"></label>
                        <input type="radio" id="star${re.grade}-4" disabled ${re.grade ge 4 ? 'checked' : ''}><label for="star${re.grade}-4"></label>
                        <input type="radio" id="star${re.grade}-3" disabled ${re.grade ge 3 ? 'checked' : ''}><label for="star${re.grade}-3"></label>
                        <input type="radio" id="star${re.grade}-2" disabled ${re.grade ge 2 ? 'checked' : ''}><label for="star${re.grade}-2"></label>
                        <input type="radio" id="star${re.grade}-1" disabled ${re.grade ge 1 ? 'checked' : ''}><label for="star${re.grade}-1"></label>
                    </fieldset>
                    <p>${re.grade}</p>
                </div>
            </li>
        </c:forEach>
    </div>

    <div id="Info" class="tabcontent">
        <h3>${store.storecontent}</h3>
        <p>가게이름: ${store.storename}</p>
        <p>가게위치: ${store.address}</p>
        <div id="map" style="width:350px;height:350px;"></div>
    </div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${key}&libraries=services"></script>
<script>

    var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
     mapOption = {
            center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
          };

  // 지도를 생성합니다
  var map = new kakao.maps.Map(mapContainer, mapOption);

  // 주소-좌표 변환 객체를 생성합니다
  var geocoder = new kakao.maps.services.Geocoder();

  var positions = [
    {
      title: '${store.storename}',
      address: '${store.address}'
    }
  ];

  positions.forEach(function (position) { //추가한 코드
     
    // 주소로 좌표를 검색합니다
    geocoder.addressSearch(position.address, function(result, status) {

      // 정상적으로 검색이 완료됐으면
      if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
           
          map: map,
          position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        //변경한 코드
        var infowindow = new kakao.maps.InfoWindow({
           
         content: '<div style="width:150px;text-align:center;padding:6px 0;">' + position.title + '</div>'
        });
        
       infowindow.open(map, marker);

        window.addEventListener('click', function() {
            map.relayout();
            map.setCenter(coords);
		});
      //  map.setCenter(coords);
      }
    });
  });
</script>

<script>
if ("${isReview}" === "ok") {
    document.getElementById("reviewOpen").click();
} else{
	document.getElementById("defaultOpen").click();
}
</script>
<jsp:include page="../footer.jsp" />