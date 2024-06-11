<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/table.css">
<div class="container">
	<table class="form-table">
            <tr>
                
                <td><input type="text" name="subject" value="${dto.subject}"></td>
            </tr>
            <tr>
                
                <td><textarea name="content" rows="10" cols="50">${dto.content}</textarea></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <button type="submit" style="color:white;">등록</button>
                    <button type="reset" style="color:white;">삭제</button>
                </td>
            </tr>
        </table>
</div>
<jsp:include page="../footer.jsp"/>