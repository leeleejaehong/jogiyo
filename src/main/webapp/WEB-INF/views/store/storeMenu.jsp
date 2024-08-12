<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/sMenu.css">
<jsp:include page="../header.jsp" />
<div class="store-container">
   <div class="toolbar">
      <ul>
         <li><a
            href="/store/selectStore.do?storeid=${storeid}&storename=${storename}">주문목록</a></li>
         <li><a
            href="/store/reviewStore.do?storeid=${storeid}&storename=${storename}">리뷰관리</a></li>
         <li><a
            href="/store/storeMenu.do?storeid=${storeid}&storename=${storename}">메뉴관리</a></li>
         <li><a
            href="/store/storeSales2.do?storeid=${storeid}&storename=${storename}">매출관리(기간별)</a></li>
         <li><a
            href="/store/storeSales.do?storeid=${storeid}&storename=${storename}">매출관리(메뉴별)</a></li>
         <li><a
            href="/store/addCate.do?storeid=${storeid}&storename=${storename}">카테고리추가</a></li>
         <li><a
            href="/store/stopStore.do?storeid=${storeid}&storename=${storename}">가게일시정지</a></li>
         <li><a
            href="/store/addCoupon.do?storeid=${storeid}&storename=${storename}">쿠폰추가하기</a></li>
      </ul>
   </div>
   <div class="content">
      <div align="center" style="margin-top: 10px;">
         <h1 class="tool-h1" align="center">가게 메뉴관리페이지</h1>
         <div style="margin-top: 40px;">
            <div class="button2">
               <a href="/store/addMenu.do?storeid=${storeid}">+메뉴 추가</a>
            </div>
            <div
               style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 40px; width: 70%; ">
               <c:forEach var="dto" items="${mlist}">
                  <div style="position: relative;  border: 1px solid #ddd; text-align:center; padding: 10px;">
                  
                     <img src="${pageContext.request.contextPath}/resources/img/${dto.img}"
                        width="150" height="150" align="left" "margin-right: 10px;">
               
                     <p>${dto.menuname}<c:if test="${dto.mqty==1}">[재고있음]</c:if>
                        <c:if test="${dto.mqty==0}">[품절]</c:if></p>
                     
                         
                     <p>${dto.jstorename}</p>

                      ${dto.menucontent}

                            <br>
                     <p></p>
                     <fmt:formatNumber type="number" maxFractionDigits="3"
                           value="${dto.price}"></fmt:formatNumber>￦
                     <br>
                     <p></p>
                 <form name="f" method="post" action="/store/editMenu.do"
                           onsubmit="return confirm('메뉴 수정페이지로 이동합니다');">
                           <input type="hidden" name="${_csrf.parameterName}"
                              value="${_csrf.token}" /> <input type="hidden"
                              value="${dto.menuid}" name="menuid"> <input
                              type="hidden" value="${dto.storeid}" name="storeid">
                           <button type="submit" class="button">수정</button>
                        </form>
                        <form name="ff" action="/store/deleteMenu.do"
                           onsubmit="return confirm('정말 메뉴를 삭제하시겠습니까?');">
                           <input type="hidden" name="${_csrf.parameterName}"
                              value="${_csrf.token}" /> <input type="hidden"
                              value="${dto.menuid}" name="menuid"> <input
                              type="hidden" value="${dto.storeid}" name="storeid">
                           <button type="submit" class="button">삭제</button>
                        </form>
                            
                            <form name="fff" action="/store/stopMenu.do"
                           onsubmit="return confirm('해당메뉴를 품절처리하시겠습니까?');">
                           <input type="hidden" value="${dto.menuid}" name="menuid">
                           <input type="hidden" value="${dto.storeid}" name="storeid">
                           <button type="submit" class="button">품절</button>
                        </form>
                        <form name="ffff" action="/store/startMenu.do"
                           onsubmit="return confirm('해당메뉴를 재개하시겠습니까?');">
                           <input type="hidden" value="${dto.menuid}" name="menuid">
                           <input type="hidden" value="${dto.storeid}" name="storeid">
                           <button type="submit" class="button">품절취소</button>
                        </form>      
                        
                            </div>
                            
                     
               </c:forEach>
            </div>
            
         </div>
      </div>
   </div>