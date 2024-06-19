<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    let ck = false;
    function check() {
        const jfrm = document.f;
        let length = jfrm.length - 1;
        for (let i = 0; i < length; i++) {
            if (jfrm[i].value == "" || jfrm[i].value == null) {
                alert(jfrm[i].title + "를 입력해주세요.");
                jfrm[i].focus();
                return false;
            }
        }
        return true;
    }
    
</script>

<div align="center">
    <form name="f" action="/store/AddStore.do" method="POST" enctype="multipart/form-data" onsubmit="return check()">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <table>
            <tr>
                <th>가게이름 :</th>
                <td><input type="text" name="storename" title="가게이름"></td>
            </tr>
            <tr>
                <th>카테고리(int)</th>
                <td>
                    <select name="cateid" title="카테고리">
                    <c:forEach items="${clist}" var="cate">
                        <option value="${cate.cateid}">${cate.catename}</option>
                    </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <th>가게설명 :</th>
                <td><textarea rows="5" cols="30" name="storecontent" title="가게설명"></textarea></td>
            </tr>
            <tr>
                <th>id</th>
                <td><input type="text" name="id" value="${jId}" readonly></td>
            </tr>
            <tr>
                <th>가게위치 (나중에 api로작업):</th>
                <td>
                    <input type="text" name="postcode" id="postcode" placeholder="우편번호" title="우편번호">
                    <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
                    <input type="text" name="address" id="address" placeholder="주소" title="주소"><br>
                    <input type="text" name="detailaddress" id="detailAddress" placeholder="상세주소" title="상세주소">
                    <input type="text" name="extraaddress" id="extraAddress" placeholder="참고항목" title="참고항목">
                </td>
            </tr>
            <tr>
                <th>가게이미지(필수) :</th>
                <td><input type="file" name="file" title="가게사진"></td>
            </tr>
            <tr>
                <th>쿠폰(없으면 0)</th>
                <td><input type="text" name="couponid" title="쿠폰"></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="확인">
                    <input type="reset" value="취소">
                </td>
            </tr>
        </table>
    </form>
</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete : function(data) {
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            if (data.userSelectedType === 'R') {
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraAddr += data.bname;
                }
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if (extraAddr !== '') {
                    extraAddr = ' (' + extraAddr + ')';
                }
                document.getElementById("extraAddress").value = extraAddr;
            } else {
                document.getElementById("extraAddress").value = '';
            }

            document.getElementById("postcode").value = data.zonecode;
            document.getElementById("address").value = addr;
            document.getElementById("detailAddress").focus();
        }
    }).open();
}
</script>
<jsp:include page="../footer.jsp" />
