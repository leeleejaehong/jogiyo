<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 점주정보페이지 -->
<jsp:include page="../header.jsp"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
	let ck=false;
	function check(){
		const jfrm = document.f;
		let length= jfrm.length -1;
		for(let i=0; i<length; i++){
			if(jfrm[i].value == "" || jfrm[i].value ==null){
				alert(jfrm[i].title + "를 입력해주세요.");
				jfrm[i].focus();
				return false;
			}
		}
		return true;
	}
	</script>
<html>
<
	<body>
		<div align="center">
			<h1>점주정보페이지</h1>
			<form name="f" method="post" action="/store/editOwner.do" onsubmit="return check()">
			아이디: <input type = text name="id" value="${owner.id}" readonly="readonly" title="id"><br>
			비밀번호:<input type = text name="passwd" value="${owner.passwd}" title="비밀번호"><br>
			이름:<input type = text name="name" value="${owner.name}" title="점주이름"><br>
			Mail:<input type = text name="mail" value="${owner.mail}" title="점주이메일"><br>
			Phone:<input type = text name="phone" value="${owner.phone}" title="점주 전화번호"><br>
			고객 / 점주:<input type=text name="grade" value=" ${owner.grade}"  title="grade" readonly="readonly"><br>
			<input type ="submit" value = "수정" >
			</form>
			<form name="f1" method="post" action="/store/deleteOwner.do">
			<input type ="submit" value = "회원탈퇴">
			</form>
		</div>
	</body>
</html>