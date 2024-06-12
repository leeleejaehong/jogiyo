<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- AddStore.jsp -->
<html>
<meta charset="UTF-8">
<jsp:include page="../header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<table>
	<form name="f" action="/store/AddStore.do" method="POST" enctype = "multipart/form-data"
		onsubmit ="return check()">
	<tr>
	<th>가게이름 :</th> 
	<td><input type="text" name="storename" title="가게이름"></td>
	</tr>
	<tr>
	<th>카테고리(int)</th>
	<td>
	<select name="cateid" title="카테고리">
	<option value="1">한식</option>
	<option value="2">양식</option>
	<option value="3">일식</option>
	<option value="4">중식</option>
	<option value="5">치킨</option>
	<option value="6">햄버거</option>
	<option value="7">피자</option>
	<option value="8">디저트</option>
	<option value="9">전체</option>
	</select>
	<td>
	<tr>
	<th>
	가게설명 :</th> 
	<td>
	<textarea rows="5" cols="30" name="storecontent" title="가게설명"></textarea>
	</td>
	<tr>
	<th>id</th>
	<td>
	<input type="text" name="id" value="${jId.id}" readonly></td>
	</tr>
	<tr>
	<th>가게위치 (나중에 api로작업): </th>
		<!-- db에 가게상세주소도 저장? -->
	<td>
<input type="text" name="postcode" id="postcode" placeholder="우편번호" title="우편번호">
<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
<input type="text" name="address" id="address"  placeholder="주소" title="주소"><br>
<input type="text" name="detailaddress" id="detailAddress" placeholder="상세주소" title="상세주소">
<input type="text" name ="extraaddress" id="extraAddress" placeholder="참고항목" title="참고항목">

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("postcode").value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
   

  
</script></td>
	</tr>
	<tr>
	<th>가게이미지(필수) : </th>
	<td>
	<input type="file" name="file" title="가게사진">
	</td>
	</tr>
	<tr>
	<th>쿠폰(없으면 0)</th>
	<td><input type ="text" name="couponid" title="쿠폰"></td>
	</tr>
	<tr>
	<td colspan="2" align="center">
	<input type="submit" value="확인">
	<input type="reset" value= "취소">
	
	</td>
	</tr>
	</table>
	</form>
	</body>
	</div>
</body>
</html>