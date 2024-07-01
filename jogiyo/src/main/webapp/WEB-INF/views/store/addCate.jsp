<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 가게카테고리추가 페이지 -->
<jsp:include page="../header.jsp"/>

<style>
.store-container2 {
    display: flex;
    flex-direction: row; /* 기본 방향을 가로로 설정 */
    justify-content: center; /* 가운데 정렬 */
    align-items: flex-start; /* 세로 방향 정렬을 위해 flex-start 설정 */
    height: 100vh; /* 화면 전체 높이 사용 */

    /* 추가적으로 필요한 스타일들 */
}
.toolbar {
    width: 150px;
    background-color: #f1f1f1;
    padding: 15px 0;
    height: 100%; /* 컨테이너 전체 높이에서의 비율 설정 */
    overflow-y: auto; /* 스크롤이 필요한 경우에만 스크롤 표시 */
}

.toolbar ul {
    list-style-type: none;
    padding: 0;
    margin: 0;
}

.toolbar ul li {
    text-align: center;
    margin-bottom: 10px;
}

.toolbar ul li a {
    display: block;
    padding: 10px;
    color: black;
    text-decoration: none;
}

.toolbar ul li a:hover {
    background-color: #ccc;
}

.content {
    flex: 1; /* 남은 공간을 모두 차지하도록 설정 */
    padding: 20px; /* 내용 여백 설정 */
    text-align: center; /* 가운데 정렬 */
}

h2 {
    margin-top: 20px;
    margin-bottom: 10px;/
}
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px; /* Added margin-top for the table */
        }
        th, td {
            border: 1px solid #dddddd;
            text-align: center;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
let ck = false;
function check() {
    const jfrm = document.f;
    let length = jfrm.length - 1;
    for (let i = 0; i < length; i++) {
        if (jfrm[i].value == "" || jfrm[i].value == null) {
            alert(jfrm[i].title + "를 입력해주세요.");
            jfrm[i].focus();
            return false;
        }
    }
    return true;
}
</script>

<div class="store-container2">
    <h1>가게 카테고리 추가</h1>
    <div class="toolbar">
        <ul>
            <li><strong>현재가게: ${storename}</strong></li>
            <li><a href="/store/selectStore.do?storeid=${storeid}">주문목록</a></li>
            <li><a href="/store/reviewStore.do?storeid=${storeid}">리뷰관리</a></li>
            <li><a href="/store/storeMenu.do?storeid=${storeid}">메뉴관리</a></li>
            <li><a href="/store/storeSales2.do?storeid=${storeid}">매출관리(기간별)</a></li>
            <li><a href="/store/storeSales.do?storeid=${storeid}">매출관리(메뉴별)</a></li>
            <li><a href="/store/addCate.do?storeid=${storeid}">카테고리추가</a></li>
            <li><a href="/store/stopStore.do?storeid=${storeid}">가게일시정지</a></li>
            <li><a href="/store/addCoupon.do?storeid=${storeid}">쿠폰추가하기</a></li>
        </ul>
    </div>
    <div class="content">
        <form name="f" method="post" action="addCateOk.do" onsubmit="return check()">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <input type="hidden" name="storeid" value="${storeid}">
            <input type="text" name="jstorename" placeholder="메뉴카테고리 이름" title="카테고리이름">
            <button type="submit" value="확인">확인</button>
            <button type="reset" value="취소">취소</button>
        </form>
    </div>
</div>

</body>
</html>