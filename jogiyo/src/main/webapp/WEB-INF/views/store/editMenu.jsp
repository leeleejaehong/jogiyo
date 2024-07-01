<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 메뉴수정페이지 -->
<jsp:include page="../header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="store-container2">
    <div class="toolbar">
        <ul>
            <strong><li>현재가게:${storename}</li></strong>
            <li><a href="/store/selectStore.do?storeid=${storeid}">주문목록</a></li>
            <li><a href="/store/reviewStore.do?storeid=${storeid}">리뷰관리</a></li>
            <li><a href="/store/storeMenu.do?storeid=${storeid}">메뉴관리</a></li>
            <li><a href="/store/storeSales2.do?storeid=${storeid}">매출관리(기간별)</a></li>
            <li><a href="/store/storeSales.do?storeid=${storeid}">매출관리(메뉴별)</a></li>
            <li><a href="/store/addCate.do?storeid=${storeid}">카테고리추가</a></li>
            <li><a href="/store/stopStore.do?storeid=${storeid}">가게일시정지</a></li>
            <li><a href="/store/addCoupon.do?storeid=${storeid}">쿠폰추가하기</a></li>
        </ul>
    </div>
 <style>
 .store-container2 {
    display: flex;
    flex-direction: row; /* 기본 방향을 가로로 설정 */
    justify-content: center; /* 가운데 정렬 */
    align-items: flex-start; /* 세로 방향 정렬을 위해 flex-start 설정 */
    height: 100vh; /* 화면 전체 높이 사용 */

    /* 추가적으로 필요한 스타일들 */
}
.toolbar {
    width: 150px;
    background-color: #f1f1f1;
    padding: 15px 0;
    height: 100%; /* 컨테이너 전체 높이에서의 비율 설정 */
    overflow-y: auto; /* 스크롤이 필요한 경우에만 스크롤 표시 */
}

.toolbar ul {
    list-style-type: none;
    padding: 0;
    margin: 0;
}

.toolbar ul li {
    text-align: center;
    margin-bottom: 10px;
}

.toolbar ul li a {
    display: block;
    padding: 10px;
    color: black;
    text-decoration: none;
}

.toolbar ul li a:hover {
    background-color: #ccc;
}

.content {
    flex: 1; /* 남은 공간을 모두 차지하도록 설정 */
    padding: 20px; /* 내용 여백 설정 */
    text-align: center; /* 가운데 정렬 */
}

h2 {
    margin-top: 20px;
    margin-bottom: 10px;
    margin-left: -390px; /* 주문목록 제목의 상단 여백을 없앱니다. */
}   
</style>

<script>
   let ck=false;
   function check(){
      const jfrm = document.f;
      let length= jfrm.length -3;
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
         메뉴수정페이지
   <form name="f" action="/store/editMenuPro.do" method ="post" enctype = "multipart/form-data" onsubmit="return check()">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      <input type="hidden" name ="menuid" value="${getMenu[0].menuid}">
         <input type="hidden" name="storeid" value="${getMenu[0].storeid}">
      <table>   
      <tr>
         <th>카테고리:</th>
         <td>
          <select name="jscateid" title="카테고리">
           <c:forEach var="dto" items="${cateList}">
           <option value="${dto.jscateid}">${dto.jstorename}</option>
           </c:forEach>
           </select>
         </td>
      <tr>
         <th>메뉴이름:</th>
         <td><input type ="text" name="menuname" value="${getMenu[0].menuname}" title="메뉴이름"></td>
      </tr>
      <tr>
         <th>가게설명:</th>
         <td><textarea name="menucontent" title="메뉴설명">${getMenu[0].menucontent}</textarea></td>
      </tr>
      <tr>
         <th>가격:</th>
         <td><input type="text" name="price" title="메뉴가격" value="${getMenu[0].price}" pattern="\d*" title=",없이 숫자만 입력해주세요"></td>
      </tr>
      <tr>
         <th>가게이미지:</th>
         <td><img src="${pageContext.request.contextPath}/resources/img/${getMenu[0].img}" width="80" height="80"></td>
      </tr>
      <tr>
         <th>가게이미지수정하기:</th>
         <td><input type ="file" name="file"></td>
      </tr>
      <tr>
         <td colspan="2" align="center">
         <input type ="submit" value="수정하기">
         <input type="reset" value="취소">
         </td>
      </tr>

      </table>
   </form>
   </body>
   </div>
   </html>