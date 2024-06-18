<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 리스트에서 가게눌렀을때page -->
<jsp:include page="../header.jsp"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<body>
		<div align="center">
		<table>
		<tr>
    	  <th><a href="/store/selectStore.do?storeid=${storeid}">주문목록</a> </th>
    	  <th><a href="/store/reviewStore.do?storeid=${storeid}">/리뷰관리</a></th> 
    	  <th><a href="/store/storeMenu.do?storeid=${storeid}">/메뉴관리</a> </th>
    	  <th><a href="/store/storeSales2.do?storeid=${storeid}">/매출관리(기간별)</a></th>
    	  <th><a href="/store/storeSales.do?storeid=${storeid}">/매출관리(메뉴별)</a></th>
    	  <th><a href="/store/addCate.do?storeid=${storeid}">/카테고리추가</a>
    	   </tr>	
    	   <tr>
    	  <td colspan = "4">
    	storeid=${storeid}
    	  </td></tr>
    	  </table>
    	  <h2>주문목록</h2>
    	  <table width="80%">
    	  <tr>
    	  <th>고객id(phone)</th>
    	  <th>주문일자</th>
    	  <th>주문메뉴</th>
    	  <th>수량</th>
    	  <th>총 가격</th>
    	  <th>주문받기/주문취소</th>
    	  </tr>
    	 <c:if test="${empty orderList}">
    	  <tr>
    	  <th colspan="6" rowspan="4"><br><br><br>최근 주문내역이 없습니다.</th>
    	  </tr>
    	  </c:if>
    	  
    	  <c:forEach var="dto" items="${orderList}">
    	  
    	  <tr align="center">
    		<td>${dto.id}<br>${dto.phone}</td>
    		<td>${dto.indate}</td>
    		<td>${dto.menuname}</td>
    		<td>${dto.qty}개</td>
    		<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${dto.totprice}"></fmt:formatNumber>￦</td>
    	 <td> <input type="button" value="주문받기"/>
    	  <input type="button" value="주문취소"/></td>
    	  </tr>
    	  </c:forEach>
    	  </table>
    	</div>
</body>
</html>