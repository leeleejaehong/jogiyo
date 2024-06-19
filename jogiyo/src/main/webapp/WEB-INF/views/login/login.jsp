<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/table.css">
<div align="center" style="margin-top: 90px;">
<h4><span style="font-weight: bold; font-family: 'Gothic A1', sans-serif;">죠기요 로그인</span></h4>
<div align="center" style="margin-top: 20px;">
    <form action="/login/loginOk.do" method="post" style="margin-bottom: 20px; ">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <div style="margin-bottom: 20px; width:70%;">
            <label for="id"></label>
            <input type="text" name="id" placeholder="아이디 입력(필수)"> 
        </div>
        <div style="margin-bottom: 20px;">
            <label for="passwd"></label>
            <input type="password" name="passwd" placeholder="비밀번호 입력(필수)">
        </div> <button type="submit" style="background-color: #DDD; color: white; border: none; padding: 7px 150px; cursor: pointer; border-radius: 5px;">로그인</button>
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