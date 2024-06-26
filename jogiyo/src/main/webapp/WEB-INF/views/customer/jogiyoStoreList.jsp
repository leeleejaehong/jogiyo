<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jogiyoStoreList.css">
<jsp:include page="../js/jogiyoStoreList_js.jsp"/>   
    <div class="container">
        <div class="order-header">
            <h2>Store List</h2>
        </div>
       <div class="sorting">
        <label for="cateid">Choose a category:</label>
        <select name="cateid" id="select" >
            <c:forEach items="${cateList}" var="cate">
                <option value="${cate.cateid}" >${cate.catename}</option>
            </c:forEach>
        </select>
        <input type="button" name="searchBtn" id="searchBtn" value="선택" onclick="cateList()">
        </div>
        <div class="listings" id="storeList" >
            <c:if test="${not empty storeList}" >
            <c:forEach items="${storeList}" var="store">
            <c:if test="${store.run==1}">
                  <div class="listing">
                        <img src="${pageContext.request.contextPath}/resources/img/${store.img}" width="80" height="80">
                        <div class="details">
                            <h2><a onclick="viewStore(${store.storeid})" href="#"> ${store.storename} </a></h2>
                            <div class="rating">4.8 ★</div>
                            <div class="reviews">리뷰 3537 | 사장님댓글 2694</div>
                            <div class="min_order">가게설명 | ${store.storecontent}</div>
                            <div class="discount">쿠폰 | ${store.couponid}</div>
                            <div class="time">22-37분</div>
                        </div>
                    </div>
      		</c:if>
      		<c:if test="${store.run==0}">
                  <div class="listing active">
                        <img src="${pageContext.request.contextPath}/resources/img/${store.img}" width="80" height="80" >
                        <div class="details">
                            <h2> ${store.storename}  </h2>
                            	<br>
                            <div class="rating">4.8 ★</div>
                            <div class="reviews">리뷰 3537 | 사장님댓글 2694</div>
                            <div class="min_order">가게설명 | ${store.storecontent}</div>
                            <div class="discount">쿠폰 | ${store.couponid}</div>
                            <div class="time">22-37분</div>
                        </div>
                    </div>
      		</c:if>
            </c:forEach>
            </c:if>
       </div>
          <a onclick="viewStore(${store.storeid})" href="#"></a>
    </div>
<jsp:include page="../footer.jsp"/>

