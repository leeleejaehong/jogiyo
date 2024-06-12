<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="../header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div align="center">
	<form action="/login/loginOk.do" method="post">
		아이디 : <input type="text" name="id"><br>
		비밀번호 : <input type="text" name="passwd"><br>
		<td rowspan="2" width="30%" valign="middle">
		<button type="submit">로그인</button>
		</td>
	</form>
	
	<table>
	<form action="/login/join_membership.do" method="post">
		<button type="submit">회원가입</button>
	</form>
	
	<form action="/login/id_find.do" method="post">
		<button type="submit">아이디찾기</button>
	</form>
	
	<form action="/login/pw_find.do" method="post">
		<button type="submit">비밀번호찾기</button>
	</form>
	</table>
</div>
<jsp:include page="../footer.jsp"/>