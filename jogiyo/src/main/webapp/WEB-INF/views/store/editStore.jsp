<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 가게선택해서 수정하는페이지 -->
<jsp:include page="../header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<div align="center">
	<h2>가게정보</h2>
	<c:forEach var="dto" items="${findStore}">
	<form name="f" action="/store/editStorePro.do" method="post" enctype="multipart/form-data" >
		<input type="hidden" name="storeid" value="${dto.storeid}">
		<input type="hidden" name="img" value="${dto.img}">
		<table>
		<tr>
			<th>가게이름:<th> 
			<td><input type="text" value="${dto.storename}" name="storename"></td>
		</tr>
		<tr>
			<th>카테고리:</th>
			<td>
				<select name="cateid">
				<option value="1"<c:if test="${dto.cateid eq '1'}">selected</c:if>>한식</option>
				<option value="2" <c:if test="${dto.cateid eq '2'}">selected</c:if>>양식</option>
				<option value="3" <c:if test="${dto.cateid eq '3'}">selected</c:if>>일식</option>
				<option value="4" <c:if test="${dto.cateid eq '4'}">selected</c:if>>중식</option>
				<option value="5" <c:if test="${dto.cateid eq '5'}">selected</c:if>>치킨</option>
				<option value="6" <c:if test="${dto.cateid eq '6'}">selected</c:if>>햄버거</option>
				<option value="7" <c:if test="${dto.cateid eq '7'}">selected</c:if>>피자</option>
				<option value="8" <c:if test="${dto.cateid eq '8'}">selected</c:if>>디저트</option>
				<option value="9" <c:if test="${dto.cateid eq '9'}">selected</c:if>>전체</option>
				</select>
				</td>
		</tr>
		<tr>
 			<th>가게설명:<th>
 			<td><textarea rows="5" cols="20" name="storecontent">${dto.storecontent}</textarea></td>
 		</tr>
 		<tr>
 			<th>점주ID:</th>
 			<td><input type="text" value="${dto.id}" readonly="readonly"></td>
		</tr>
		<tr>
			<th>가게위치 (나중에 api로작업): </th>
		<!-- db에 가게상세주소도 저장? -->
			<td>
			<input type="text" name ="postcode" id="postcode" placeholder="우편번호" value="${dto.postcode}" >
			<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" name ="address" id="address"  placeholder="주소" value="${dto.address}"><br>
			<input type="text" name="detailaddress" id="detailAddress" placeholder="상세주소" value="${dto.detailaddress}">
			<input type="text" name="extraaddress" id="extraAddress" placeholder="참고항목" value="${dto.extraaddress}">

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

           
                if (data.userSelectedType === 'R') { 
                    addr = data.roadAddress;
                } else { 
                    addr = data.jibunAddress;
                }

          
                if(data.userSelectedType === 'R'){
                   
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                 
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                   
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                   
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

          
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
   </script></td>
		</tr>
		<tr>
			<th colspan="2">가게사진:<img src="${pageContext.request.contextPath}/resources/img/${dto.img}" width="100" height="100"></th>
		</tr>
		<tr>
			<th>가게 이미지 수정하기:</th>
			<td><input type="file" name="file"></td>
		</tr>
		<tr>
			<th colspan="2" align="center">
				<input type ="hidden" name ="storeid" value="${storeid}">
				<input type="submit" value="수정">
				<input type="reset" value="취소"></th>
		</tr>
		</table>
	</form>
		<form name ="ff" action="/store/deleteStore.do">
		<input type="hidden" value="${dto.storename}" name="storename">
		<input type ="submit" value="회원탈퇴">
		</form>
	</c:forEach>
</div>
</body>
</html>