<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- ListStroe.jsp -->
<jsp:include page="../header.jsp"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

<meta charset="UTF-8">
 
 <script type="text/javascript" contentType="text/html;">
	function goStore() {
		
		if (confirm("해당 가게페이지로 이동하시겠습니까?") == true){    //확인

		    location.href ="/store/selectStore.do"

		 }else{   //취소

		     return false;

		 }
	} 
 </script>
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
	
	<td><img src="${path}/${dto.img}" width="80" height="80"></td>
	<td>${dto.storename}</td>
	<td>${dto.cateid}</td>
	<td>${dto.lat}+${dto.har}</td>
	<td>${dto.id}</td>
	<td><input type="button" value="이동하기" onclick="goStore()"></td>
	
	</tr>
	</c:forEach>
	
	</table>
	</div>

</html>