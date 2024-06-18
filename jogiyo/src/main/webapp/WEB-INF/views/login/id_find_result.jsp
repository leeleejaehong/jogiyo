<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 비밀번호 찾기 결과 페이지 -->
<jsp:include page="../header.jsp"/>
<html>
	<head>
		<title>아이디 찾기 페이지</title>
	</head>
	<body>
		<form name="f" method="post" action="/login/id_find_ff.do">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<table width="600" align="center" class="outline">
			<td align="center">
			<h4>아이디 찾기</h4>
			<p>고객님의 정보와 일치하는 아이디 목록입니다.</p>
			
			<!-- <strong> -->
			
			<!-- <input type="radio" name="select"> -->
			<label>"${id}"</label>
			<!-- <span>가입 : </span> -->
			
			<!-- </strong> -->
			
			</td>
			
			<tr>
			<td colsapn="2" align="center">
			
			<!-- <a href="#" onclick="location.href="login.do">
			<sapn class="blind">로그인</sapn>
			</a> -->
			<button type="button" onclick="alert('로그인 페이지로 이동합니다.');
			window.location.href='login.do';">로그인</button>
			
			<button type="button" onclick="alert('비밀번호 찾기 페이지로 이동합니다.');
			window.location.href='pw_find.do';">비밀번호 찾기</button>
			
			</td>
			</tr>
			
		</table>
		</form>
	</body>
</html>
<jsp:include page="../footer.jsp"/>