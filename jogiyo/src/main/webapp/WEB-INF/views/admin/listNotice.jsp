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
<div align="center" style="margin-top: 60px">
<table style="background-color: #white; border: 0px solid #FFFFFF;">
   <tr>
     <th style="background-color: #DDD; width: 30%;font-size: 20px; text-align: center; border-: none;">Total</th>
     <th style="background-color: #DDD; width: 5%;font-size: 20px; text-align: center; border-right: none;">Date</th>
     <th style="background-color: #DDD; width: 3%;font-size: 20px; text-align: center; border-right: none;">Delete</th>  
   </tr>
   <c:forEach items="${list}" var="dto">
      <tr>
         <td><a onclick="viewNotice(${dto.notiid})" href="#">${dto.subject}</a></td>
         <td>${dto.indate}</td>
         <td><button onclick="deleteNotice(${dto.notiid})">삭제</button></td>
      </tr>
   </c:forEach>
</table>
<hr>
</div>
<style>
    table {
        width: 50%; /*테이블 폭 늘리고 줄이기 */
        border-collapse: separate; /*선을 개별적으로 그리도록 설정 */
        margin: auto; /*테이블의 여백 */
        border-radius: 10px; /* 테이블을 동그랗게 만듦 */
        overflow: hidden; /* 테이블을 동그랗게 만들기 위해 필요한 속성 */
    }
    th, td {
        padding: 50px; /* 셀 크기 늘리고 줄이기 */
        text-align: center;
        border: none; /* 선 제거 */
        height: 40px;
        margin: auto;
        border-bottom: 2px solid #ddd; /* 아래쪽 선 추가 */
    }
    th:first-child, td:first-child {
        border-left: 2px solid #ddd; /* 왼쪽 선 추가 */
    }
    th:last-child, td:last-child {
        border-right: 2px solid #ddd; /* 오른쪽 선 추가 */
    }
</style>
<jsp:include page="../footer.jsp"/>