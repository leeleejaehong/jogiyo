<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- 비밀번호찾기 페이지 -->
<jsp:include page="../header.jsp"/>
    
<html>
<head>
	<title>아이디찾기</title>
</head>
	<body>
		<form name="f" method="post" action="/login/pw_find_ok.do">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<table width="600" align="center" class="outline">
		<tr>
			<td colspan="2" align="center" class="m2">비밀번호찾기</td>
		</tr>
		
		<tr>
			<td width="150" class="m3">이름</td>
			<td class="m3">
				<input type="text" name="name" class="box">
			</td>
		</tr>
		
		<tr>
			<td width="150" class="m3">아이디</td>
			<td class="m3">
				<input type="text" name="id" class="box">
			</td>
		</tr>
		
		<tr>
			<td width="150" class="m3">전화번호</td>
			<td class="m3">
				<input type="text" name="phone1" class="box" size="3" maxlength="3"> -
				<input type="text" name="phone2" class="box" size="3" maxlength="4"> -
				<input type="text" name="phone3" class="box" size="3" maxlength="4">
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
			<input type="submit" value="확인">
			<button type="button" onclick="alert('로그인 페이지로 이동합니다');
			window.location.href='login.do';">취소</button>
			<button type="submit">카카오인증</button>
			</td>
		</tr>
		</table>	
		</form>	
	</body>
</html>
<jsp:include page="../footer.jsp"/>