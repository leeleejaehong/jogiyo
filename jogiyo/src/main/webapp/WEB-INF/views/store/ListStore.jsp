<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- ListStroe.jsp -->
<jsp:include page="../header.jsp"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

<meta charset="UTF-8">
 
 
	<div align="center">
	<table>
	<tr>
	<th>가게이미지</th>
	<th>가게이름</th>
	<th>가게카테고리</th>
	<th>가게위치</th>
	<th>가게 주인id</th>
	</tr>
	
	<c:forEach var="dto" items="${getStore}">
	<tr>
	
	<td><img src="${pageContext.request.contextPath}/resources/img/${dto.img}" width="80" height="80"></td>
	<td>${dto.storename}</td>
	<td>${dto.cateid}</td>
	<td>${dto.address}<br>
	${dto.detailaddress}
	${dto.extraaddress}</td>
	<td>${dto.id}</td>
	
	<form name ="f"  method="post"  action="/store/selectStore.do" onsubmit="return confirm('해당가게로 이동하시겠습니까?');">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" name ="storename" value="${dto.storename}">
	<input type="hidden" name = "storeid" value="${dto.storeid}">
	<td><input type="submit" value="이동하기"></td>
	</form>
	</tr>
	</c:forEach>
	
	</table>
	</div>

</html>