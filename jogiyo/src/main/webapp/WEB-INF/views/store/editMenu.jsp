<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 메뉴수정페이지 -->
<jsp:include page="../header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
	<div align="center">
			메뉴수정페이지
	<form name="f" action="/store/editMenuPro.do" method ="post" enctype = "multipart/form-data">
		<table>
		<c:forEach var="dto" items="${getMenu}">
			<input type="hidden" name ="menuid" value="${dto.menuid}">
			<input type="hidden" name="storeid" value="${dto.storeid}">
		<tr>
			<th>카테고리:</th>
			<td><input type ="text" name ="jscateid" value="${dto.jscateid}" readonly="readonly"></td>
		<tr>
			<th>메뉴이름:</th>
			<td><input type ="text" name="menuname" value="${dto.menuname}"></td>
		</tr>
		<tr>
			<th>가게설명:</th>
			<td><textarea name="menucontent">${dto.menucontent}</textarea></td>
		</tr>
		<tr>
			<th>가격:</th>
			<td><input type="text" name="price" value="${dto.price}" pattern="\d*" title=",없이 숫자만 입력해주세요"></td>
		</tr>
		<tr>
			<th>가게이미지:</th>
			<td><img src="${pageContext.request.contextPath}/resources/img/${dto.img}" width="80" height="80"></td>
		</tr>
		<tr>
			<th>가게이미지수정하기:</th>
			<td><input type ="file" name="file"></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
			<input type ="submit" value="수정하기">
			<input type="reset" value="취소">
			</td>
		</tr>
		</c:forEach>
		</table>
	</form>
	</body>
	</div>
	</html>