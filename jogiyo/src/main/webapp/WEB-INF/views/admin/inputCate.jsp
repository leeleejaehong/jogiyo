<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/table.css">
<div align="center" style="margin-top: 50px;">
<h4><span style="font-weight: bold; font-family: 'Gothic A1', sans-serif;">카테고리 추가</span></h4>
<div align="center" style="margin-top: 20px;">
    <form action="/admin/insertCateOk.do" method="post" enctype="multipart/form-data" style="border: 1px solid #ddd; padding: 20px; width: 50%; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);"> 
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <div style="margin-bottom: 20px;">
            <label for="catename" style="font-weight: bold; display: block; ">카테고리 이름</label>
            <input type="text" name="catename" id="catename" style="margin-left: 10px; padding: 5px; border-radius: 5px; border: 1px solid #ccc; width: calc(100% - 32px);">
        </div>
        <div style="margin-bottom: 20px;">
            <label for="file" style="font-weight: bold;">카테고리 이미지</label>
            <input type="file" name="file" id="file" style="margin-left: 10px; padding: 5px; border-radius: 5px; border: 1px solid #ccc;;">
        </div>
        <div>
            <button type="submit" style="padding: 10px 20px; background-color: #fa0050; color: #fff; border: none; border-radius: 5px; cursor: pointer;margin-right: 10px;">등록</button>
            <button type="submit" style="padding: 10px 20px; background-color: #fa0050; color: #fff; border: none; border-radius: 5px; cursor: pointer;">임시등록</button>
        </div>
    </form>
</div style="margin-bottom: 20px;">
<div align ="center" style="margin-bottom: 50px;">
</div>
<jsp:include page="../footer.jsp"/>
