<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/star.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #white;
            margin: 0;
            padding: 0;
            color: #white;
        }
        .container {
            width: 50%;
            margin: 0 auto;
            color: #white;
        }
        h2 {
            color: #555;
            margin-bottom: 20px;
        }
        .pagination {
            margin: 20px 0;
            text-align: center;
        }
        .pagination a {
            color: #555;
            display: inline-block;
            padding: 8px 16px;
            text-decoration: none;
            transition: background-color .3s;
            border: 1px solid #ddd;
            margin: 0 4px;
            border-radius: 4px;
        }
        .pagination a.active {
            background-color: #fa0050;
            color: white;
            border: 1px solid #fa0050;
        }
        .pagination a:hover:not(.active) {
            background-color: #ddd;
        }
        .review-container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .review-item {
            list-style: none;
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #ddd;
        }
        .review-item:last-child {
            border-bottom: none;
        }
        .review-content {
            text-align: left;
            display: flex;
            flex-wrap: wrap;
        }
        .review-content h3, .review-content p {
            margin: 10px 0;
        }
        .review-content img {
            max-width: 200px;
            height: auto;
            border-radius: 8px;
            margin-top: 10px;
            margin-right: 20px;
        }
        .star-rating {
            margin-top: 10px;
        }
        .star-rating input {
            display: none;
        }
        .star-rating label {
            color: #ffd700;
            font-size: 20px;
        }
        .reply {
            margin-top: 10px;
            padding: 10px;
            background-color: #f1f1f1;
            border-radius: 4px;
        }
        button {
            padding: 10px 20px;
            color: white;
            background-color: #fa0050;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #d90445;
        }
        .form-container {
            display: none;
            margin-top: 10px;
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 4px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        
        .form-container textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            resize: vertical;
        }
        .form-container input[type="submit"], .form-container input[type="button"] {
            padding: 10px 20px;
            margin-right: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <div align="center" style="margin-top: 80px;">
    <h1><span style="font-weight: bold; color:#fa0050; font-family: 'Gothic A1', sans-serif;">리뷰관리 페이지</span></h1>
    <div align="center" style="margin-top: 40px;">
    <c:if test="${empty rList}">
        <p>등록된 리뷰가 없습니다.</p>
    </c:if>
    <c:if test="${not empty rList}">
        <div id="Review">
            <c:forEach var="dto" items="${rList}" varStatus="loop">
                <c:if test="${loop.index % 5 == 0}">
                    <c:if test="${loop.index != 0}">
                        </div>
                    </c:if>
                    <div class="review-group">
                </c:if>
                <div class="review-item">
                    <div class="review-content">
                        <c:choose>
                            <c:when test="${not empty dto.img}">
                                <div>
                                    <img src="${pageContext.request.contextPath}/resources/img/${dto.img}" alt="Review Image">
                                </div>
                            </c:when>
                            <c:when test="${empty dto.img}">
                                <p>등록된 사진이 없습니다.</p>
                            </c:when>
                        </c:choose>
                        <div>
                            <h3>아이디:  ${dto.id}</h3>
                            <h3>주문일자: ${dto.reviewdate}</h3>
                            <h2>리뷰내용: ${dto.revcotent}</h2>
                            <c:if test="${not empty dto.reply}">
                                <p class="reply">⤷사장님댓글: ${dto.reply}</p>
                            </c:if>
                            <div class="star-rating">
                                <fieldset>
                            <input type="radio" id="star${dto.grade}-5" disabled ${dto.grade ge 5 ? 'checked' : ''}><label for="star${re.grade}-5"></label>
                            <input type="radio" id="star${dto.grade}-4" disabled ${dto.grade ge 4 ? 'checked' : ''}><label for="star${re.grade}-4"></label>
                            <input type="radio" id="star${dto.grade}-3" disabled ${dto.grade ge 3 ? 'checked' : ''}><label for="star${re.grade}-3"></label>
                            <input type="radio" id="star${dto.grade}-2" disabled ${dto.grade ge 2 ? 'checked' : ''}><label for="star${re.grade}-2"></label>
                            <input type="radio" id="star${dto.grade}-1" disabled ${dto.grade ge 1 ? 'checked' : ''}><label for="star${re.grade}-1"></label>
                        </fieldset>
                                <p>평점: ${dto.grade}</p>
                            </div>
                        </div>
                    </div>
                    <c:if test="${empty dto.reply}">
                        <button onclick="showForm(${dto.reviewid})">댓글등록</button>
                    </c:if>
                    <c:if test="${not empty dto.reply}">
                        <button onclick="showForm(${dto.reviewid})">댓글수정</button>
                        <button onclick="location.href='/store/deleteReview.do?reviewid=${dto.reviewid}&storeid=${dto.storeid}'">답글삭제</button>
                    </c:if>
                    <br>
                    <div id="myForm${dto.reviewid}" class="form-container">
                        <h4>${empty dto.reply ? '댓글추가' : '댓글수정'}</h4>
                        <form id="form${dto.reviewid}" action="${empty dto.reply ? 'addReviewOk.do' : 'editReviewOk.do'}" method="post">
                            <input type="hidden" name="reviewid" value="${dto.reviewid}">
                            <input type="hidden" name="storeid" value="${dto.storeid}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <label for="reply${dto.reviewid}"></label>
                            <textarea id="reply${dto.reviewid}" name="reply" rows="4">${dto.reply}</textarea>
                            <br>
                            <button type="submit" value="${empty dto.reply ? '등록' : '수정'}">등록</button>
                            <button type="button" value="취소" onclick="cancelForm(${dto.reviewid})">수정</button>
                        </form>
                    </div>
                </div>
                <c:if test="${loop.last}">
                    </div>
                </c:if>
            </c:forEach>
        </div>
        <div class="pagination">
            <c:if test="${pageCount > 1}">
                <c:set var="startPage" value="${currentPage - 2}"/>
                <c:if test="${startPage lt 1}">
                    <c:set var="startPage" value="1"/>
                </c:if>
                <c:set var="endPage" value="${currentPage + 2}"/>
                <c:if test="${endPage gt pageCount}">
                    <c:set var="endPage" value="${pageCount}"/>
                </c:if>
                <c:url value="/store/reviewStore.do" var="firstPageUrl">
                    <c:param name="page" value="1"/>
                    <c:param name="storeid" value="${param.storeid}"/>
                </c:url>
                ...
                <!-- Pagination logic continues here -->
                ...
            </c:if>
        </div>
    </c:if>
</div>
<script>
    function showForm(id) {
        document.getElementById('myForm' + id).style.display = 'block';
    }

    function cancelForm(id) {
        document.getElementById('myForm' + id).style.display = 'none';
    }
</script>
</body>
</html>

