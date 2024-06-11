<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<div align="center">
	<form action="/admin/insertCateOk.do" method="post" enctype="multipart/form-data">
		카테고리 이름 : <input type="text" name="catename">
                카테고리 이미지 : <input type="file" name="file">
        <button type="submit">등록</button>
	</form>
</div>
<jsp:include page="../footer.jsp"/>