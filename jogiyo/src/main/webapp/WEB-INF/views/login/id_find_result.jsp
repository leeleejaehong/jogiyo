<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 비밀번호 찾기 결과 페이지 -->
<jsp:include page="../header.jsp"/>
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css"> --%>

<style>
    /* 기본 스타일 */
    .form-container {
        margin: 0 auto;
        border-collapse: collapse;
        width: 25%;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-shadow: 0 8px 16px rgba(1, 1, 1, 0.2);
        background-color: #f9f9f9;
        padding: 20px;
        }
        
	  .form-container button { /* 인증번호, 취소, 인증번호 전송 버튼  */
        background-color: #fa0050;
        color: white;
        border: none;
        padding-top: 4px; /* 위쪽 padding 설정 */
   		padding-bottom: 4px; /* 아래쪽 padding 설정 */
   		padding-left: 5px; /* 왼쪽 padding 설정 */
    	padding-right: 5px; /* 오른쪽 padding 설정 */
        cursor: pointer;
        border-radius: 5px;
        width: calc(80% - 10px); /* 버튼 넓이 */
        display: block;
        margin: 10px auto;
        font-size: 16px;
    }

</style>


		<form name="f" method="post" action="/login/id_find_ff.do" class="form-container">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<div align="center" style="margin-top: 20px;""margin-bottom: 20px;">
		<h1><span style="font-weight: bold; color:#fa0050; font-family: 'Gothic A1', sans-serif;">아이디 찾기</span></h1>
		<h4><span style="font-weight: bold; color:#black; font-family: 'Gothic A1', sans-serif;">고객님의 정보와 일치하는 아이디 목록입니다.</span></h4>
		</div>	

			
		<div align="center" style="margin-top: -5px;""margin-bottom: 30px;" "border-radius: 8px;">
			<label>고객님의 아이디 :${id}</label>
	
			
			<table>
			<tr>
			<td><button type="button" style="width: 80px;" onclick="alert('로그인 페이지로 이동합니다.');
			window.location.href='login.do';">로그인</button></td>
			<td style="width: 50px;"></td>
			<td><button type="button" style="width: 120px;" onclick="alert('비밀번호 찾기 페이지로 이동합니다.');
			window.location.href='pw_find_two.do?id=+${id}'">비밀번호 찾기</button></td>
			<!-- 'pw_find_two.do?id=+${id}'" 찾은 아이디를 비밀번호 찾기 페이지 아이디 입력란이 저장 -->
			</tr>
			</table>
			</div>
		</form>
<jsp:include page="../footer.jsp"/>