<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 가게 메뉴관리페이지 -->
<jsp:include page="../header.jsp"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<div align="center">
	가게 메뉴관리페이지
	storeid=${storeid}
	<br>
		<a href = "/store/addMenu.do?storeid=${storeid}">메뉴추가</a> 
	
	
	
	<table>
	<tr>
	<th>메뉴이름</th>
	<th>카테고리</th>
	<th>메뉴설명</th>
	<th>메뉴가격</th>
	<th>메뉴사진</th>
	<th>수정/삭제</th>
	<th></th>
	</tr>
	<c:forEach var="dto" items="${mlist}">
	<tr>
	<td>${dto.menuname}</td>
	<td>${dto.jscateid}</td>
	<td>${dto.menucontent}</td>
	
	<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${dto.price}"></fmt:formatNumber>￦</td>
	<td><img src="${pageContext.request.contextPath}/resources/img/${dto.img}" width="80" height="80"></td>
	<td colspan="2" align="center">
	<form name="f" method="post" action="/store/editMenu.do" onsubmit="return confirm('메뉴 수정페이지로 이동합니다');">
	<input type="hidden" value="${dto.menuid}" name="menuid">
	
	<input type="submit" value="수정">
	</form>
	<form name="ff" action="/store/deleteMenu.do" onsubmit="return confirm('정말 메뉴를 삭제하시겠습니까?');">
	<input type="hidden" value="${dto.menuid}" name="menuid">
	<input type="hidden" value="${dto.storeid}" name="storeid">
	<input type ="submit" value="삭제">
	</form>
	
	</tr>
	</c:forEach>
	</table>
	</div>
	
	
	<br>

</body>
</html>