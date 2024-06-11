<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container">
        <div class="categories">
            <a href="#" class="category all">
                <p>전체보기</p>
            </a>
		<c:forEach items="${cateList}" var="dto">
			<a href="#" class="category"> <img src="${pageContext.request.contextPath}/resources/img/${dto.img}"
				alt="${dto.catename}">
				<p>${dto.catename}</p>
			</a>
		</c:forEach>


	</div>
    </div>
   <jsp:include page="footer.jsp"/>