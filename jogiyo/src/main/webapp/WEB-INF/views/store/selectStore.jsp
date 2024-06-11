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
    	  <th><a href="/store/selectStore.do">주문목록</a> </th>
    	  <th><a href="/store/reviewStore.do">/리뷰관리</a></th> 
    	  <th><a href="/store/storeMenu.do">/메뉴관리</a> </th>
    	  <th><a href="/store/storeSales.do">/매출관리</a></th>
    	   </tr>	
    	   <tr>
    	  <td colspan = "4">
    	
    	  </td><tr>
    	  <td colspan = "4">
    	
    	  </td><tr>
    	  <td colspan = "4">
    	 
    	  </td>   
    	  <tr>
    	  <td colspan = "4">
    	  여기에는 주문목록 나오게하기
    	  </td>
    	 </tr>
    	  </table>
    	</div>
</body>
</html>