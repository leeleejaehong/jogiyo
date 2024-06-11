<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/table.css">
<div align="center">
<table>
	<tr>
		<th>제목</th>
		<th>내용</th>
		<th>작성날짜</th>
		<th>수정/삭제</th>
	</tr>
	<c:forEach items="${list}" var="dto">
		<tr>
			<td>${dto.subject}</td>
			<td>${dto.content}</td>
			<td>${dto.indate}</td>
			<td><button>수정</button><button>삭제</button></td>
		</tr>
	</c:forEach>
</table>
<hr>
</div>
<jsp:include page="../footer.jsp"/>