<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="../header.jsp"/>
<div align="center">
	<form action="/" method="post" enctype="multipart/form-data">
	 	 <h1>My Page</h1>
    
    
    <!-- 사용자 정보 수정 폼 -->
         <label for="name">ID:</label>
        <input type="text" id="id" name="id" value="${customer.id}" readonly="readonly"><br>
        
        <label for="name">PASSWD:</label>
        <input type="password" id="passwd" name="passwd" value="${customer.passwd}" ><br>
        
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" value="${customer.name}"><br>
        
        <label for="mail">Email:</label>
        <input type="text" id="mail" name="mail" value="${customer.mail}"><br>
        
        <label for="phone">Phone:</label>
        <input type="text" id="phone" name="phone" value="${customer.phone}"><br>
        
        <button type="submit">Update</button>
    
	 	
	</form>
</div>
<jsp:include page="../footer.jsp"/>
