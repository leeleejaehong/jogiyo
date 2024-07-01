<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>가게 메뉴관리페이지</title>
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
    margin-bottom: 10px;
    margin-left: -390px; /* 주문목록 제목의 상단 여백을 없앱니다. */
}
        table {
            width: 50%;
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
</head>
<body>
<jsp:include page="../header.jsp"/>

<div class="store-container">
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
        <h1><span style="font-weight: bold; color:#fa0050; font-family: 'Gothic A1', sans-serif;">가게 메뉴관리페이지</span></h1>
        <a href="/store/addMenu.do?storeid=${storeid}">메뉴추가</a>
        <br><br>
        <table>
            <tr>
                <th>메뉴이름</th>
                <th>카테고리</th>
                <th>메뉴설명</th>
                <th>메뉴가격</th>
                <th>메뉴사진</th>
                <th>수정/삭제</th>
                <th>메뉴품절/재개</th>
            </tr>
            <c:forEach var="dto" items="${mlist}">
                <tr>
                    <td>${dto.menuname}
                        <c:if test="${dto.mqty==1}">[재고있음]</c:if>
                        <c:if test="${dto.mqty==0}">[품절]</c:if>
                    </td>
                    <td>${dto.jstorename}</td>
                    <td>${dto.menucontent}</td>
                    <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${dto.price}"></fmt:formatNumber>￦</td>
                    <td><img src="${pageContext.request.contextPath}/resources/img/${dto.img}" width="80" height="80"></td>
                    <td>
                        <form name="f" method="post" action="/store/editMenu.do" onsubmit="return confirm('메뉴 수정페이지로 이동합니다');">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <input type="hidden" value="${dto.menuid}" name="menuid">
                            <input type="hidden" value="${dto.storeid}" name="storeid">
                            <input type="submit" value="수정">
                        </form>
                        <form name="ff" action="/store/deleteMenu.do" onsubmit="return confirm('정말 메뉴를 삭제하시겠습니까?');">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <input type="hidden" value="${dto.menuid}" name="menuid">
                            <input type="hidden" value="${dto.storeid}" name="storeid">
                            <input type="submit" value="삭제">
                        </form>
                    </td>
                    <td>
                        <form name="fff" action="/store/stopMenu.do" onsubmit="return confirm('해당메뉴를 품절처리하시겠습니까?');">
                            <input type="hidden" value="${dto.menuid}" name="menuid">
                            <input type="hidden" value="${dto.storeid}" name="storeid">
                            <input type="submit" value="품절">
                        </form>
                        <form name="ffff" action="/store/startMenu.do" onsubmit="return confirm('해당메뉴를 재개하시겠습니까?');">
                            <input type="hidden" value="${dto.menuid}" name="menuid">
                            <input type="hidden" value="${dto.storeid}" name="storeid">
                            <input type="submit" value="품절취소">
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>

</body>
</html>
