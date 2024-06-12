<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 메뉴추가페이지 -->
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
	<div align="center">
		<h2>메뉴 추가페이지</h2>
 			<table>
 			<form name="f" action ="/store/addMenuPro.do" method="post" enctype="multipart/form-data"
 			 onsubmit="return check()">
 			<input type ="hidden" name="storeid" value="${storeid}">
 			<tr>
 				<th> 가게 카테고리:</th>
 					<td> <input type ="text" name ="jscateid" value="${cateid}" readonly="readonly"></td>
 			</tr>
			<tr>
				<th>메뉴이름:</th>
					<td> <input type="text" name = "menuname" title="메뉴이름"></td>
			</tr>
			<tr>
				<th>
				메뉴설명:</th>
				<td><textarea name="menucontent" title="메뉴설명">메뉴설명을 적어주세요.</textarea></td>
			</tr>
			<tr>
				<th>메뉴가격:</th>
				<td><input type="text" name="price" placeholder=",없이 입력해주세요" title="가격"></td>
			</tr>
			<tr>
				<th>메뉴사진:(메뉴사진은 필수입니다)</th>
				<td><input type ="file" name="file" title="메뉴사진"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="submit" value="추가하기">
				<input type="reset" value="취소하기"></td>
			</tr>
			</form>
 		</table>
		</body>
	</div>
</html>