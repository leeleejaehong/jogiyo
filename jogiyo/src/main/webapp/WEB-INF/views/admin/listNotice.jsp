<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/table.css">
<script type="text/javascript">
function viewNotice(id) {
    var form = document.createElement('form');
    form.method = 'POST';
    form.action = '/admin/viewNotice.do';

    var idInput = document.createElement('input');
    idInput.type = 'hidden';
    idInput.name = 'notiid';
    idInput.value = id;
    form.appendChild(idInput);

    document.body.appendChild(form);
    form.submit();
}
</script>
<div align="center">
<table>
   <tr>
      <th style="width: 30%;font-size: 20px; text-align: center;">제목</th>
      <th style="width: 5%;font-size: 20px; text-align: center;">작성날짜</th>    
   </tr>
   <c:forEach items="${list}" var="dto">
      <tr>
         <td><a onclick="viewNotice(${dto.notiid})" href="#">${dto.subject}</a></td>
         <td>${dto.indate}</td>
      </tr>
   </c:forEach>
</table>
<hr>
</div>
<style>
    table {
        width: 60%; /*테이블 폭 늘리고 줄이기 */
        border-collapse: collapse;
        margin: auto; /*테이블의 여백 */
    }
    th, td {
        padding: 50px; /* 셀 크기 늘리고 줄이기 */
        text-align: center;
        border: 1px solid #ddd;
        height: 40px;
        margin: auto;
    }
</style>
<jsp:include page="../footer.jsp"/>