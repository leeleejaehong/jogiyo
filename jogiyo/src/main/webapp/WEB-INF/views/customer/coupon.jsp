<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/coupon.css">
    <div class="order-table-container">
        <div class="order-header">
            <h2>My Coupon</h2>
            <span>2024-06-09</span>
        </div>
        <table class="order-table">
            <thead>
                <tr>
                    <th>coupon name</th>
                    <th>coupon content</th>
                    <th>store</th>
                    <th>사용기간?</th>
                    <th>use(나중)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                <c:forEach items="${cCoupon}" var="coupon">
                    <td>${coupon.couname}</td>
                    <td>${coupon.coucontent}</td>
                    <td>가게이름</td>
                    <td>기간 ~ </td>
                    <td class="actions">
                        <button onclick="use()">사용</button>
                    </td>
                     </c:forEach>
                     </tr>
            </tbody>
        </table>
    </div>
    <script>
        function reorder() {
            alert('재주문 기능을 구현하세요.');
        }

        function writeReview() {
            alert('리뷰 쓰기 기능을 구현하세요.');
        }
    </script>

<jsp:include page="../footer.jsp"/>

