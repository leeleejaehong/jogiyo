<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<div align="center">
	<form action="/admin/insertNotice.do" method="post">
	제목 : <input type="text" name="subject"><br>
	내용 : <input type="text" name="content"><br>
	<button type="submit">등록</button>
	<button type="reset">삭제</button>
	</form>
	<a href="/admin/listNotice.do">공지사항 목록 보기</a>
</div>
<jsp:include page="../footer.jsp"/>