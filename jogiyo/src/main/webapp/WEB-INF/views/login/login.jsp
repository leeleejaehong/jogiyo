<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="../header2.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
body {
font-family: Arial, sans-serif;
background-color: #DDD;
}
.container {
    width: 50%;
    margin: 0 auto;
    padding: 20px;
    margin-top: 50px;
}

.form-table {
    width: 100%;
    background-color: #white;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border: 1px solid #white; /*테이블 테두리 색*/
}

.form-table td {
    padding: 10px;
    text-align: center;
}

.form-table input[type="text"],
.form-table textarea,
.form-table input[type="password"] {
    width: 100%;
    padding: 8px;
    /* border: 1px #black */;
    border-width: 0;
    border-radius: 5px;
    box-sizing: border-box;
    background-color: #DDD /*회색배경*/
}

.form-table textarea {
    resize: vertical;/*세로 크기 조절 가능*/
}

.button-container {
    text-align: center;
    margin-top: 20px;
}

.button-container button {
    background-color: #666; /* 변경된 배경색 */
        border: none;
        border-radius: 10px;
        color: white;
        padding: 10px 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 4px 2px;
        cursor: pointer;
        border-radius: 5px;
}
.button-container form {
margin-right: 10px;
}
</style>

<div align="center" style="margin-top: 60px">
    <form action="/login/loginOk.do" method="post" style="margin-bottom: 20px; ">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <div style="margin-bottom: 0px;">
            <label for="id"></label>
            <input type="text" name="id" placeholder="이메일 주소 입력(필수)">
        </div>
        <div style="margin-bottom: 20px;">
            <label for="passwd"></label>
            <input type="password" name="passwd" placeholder="비밀번호 입력(필수)">
        </div>
        <button type="submit" style="background-color: #DDD; color: white; border: none; padding: 7px 150px; cursor: pointer; border-radius: 5px;">로그인</button>
    </form>
    
    <div style="display: flex; justify-content: space-around; margin-bottom: 60px;">
        <form action="/login/join_membership.do" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <button type="submit" style="background-color: #fa0050; color: white; border: none; padding: 7px 20px; cursor: pointer; border-radius: 5px;">회원가입</button>
        </form>
        
        <form action="/login/id_find.do" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <button type="submit" style="background-color: #fa0050; color: white; border: none; padding: 7px 20px; cursor: pointer; border-radius: 5px;">아이디 찾기</button>
        </form>
        
        <form action="/login/pw_find.do" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <button type="submit" style="background-color: #fa0050; color: white; border: none; padding: 7px 20px; cursor: pointer; border-radius: 5px;">비밀번호 찾기</button>
        </form>
    </div>
</div>

<jsp:include page="../footer.jsp"/>