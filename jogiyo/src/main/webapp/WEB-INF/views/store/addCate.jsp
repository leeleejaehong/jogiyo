<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 가게카테고리추가 페이지 -->
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
<div align="center">
	<h2>가게 카테고리 추가</h2>
	<table>
		<form name="f" method="post" action="addCateOk.do" onsubmit="return check()">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type = "hidden" name="storeid" value="${storeid}">
		<input type = "text" name= "jstorename" placeholder="메뉴카테고리 이름" title="카테고리이름">
		<input type="submit" value="확인">
		<input type="reset" value="취소">
		</form>
	</table>

</div>

</body>
</html>