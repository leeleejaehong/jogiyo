<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/table.css">
<style>
body {
font-family: Arial, sans-serif;
background-color: #white;
}
.container {
    width: 50%;
    margin: 0 auto;
    padding: 20px;
    margin-top: 50px;
}

.form-table {
    width: 100%;
    background-color: #white;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border: 1px solid #white; /*테이블 테두리 색*/
}

.form-table td {
    padding: 10px;
    text-align: center;
}

.form-table input[type="text"],
.form-table textarea {
    width: 100%;
    padding: 8px;
    /* border: 1px #black */;
    border-width: 0;
    border-radius: 5px;
    box-sizing: border-box;
    background-color: #DDD /*회색배경*/
}

.form-table textarea {
    resize: 200px;
}

.button-container {
    text-align: center;
    margin-top: 20px;
}

.button-container button {
    background-color: #fa0050; 
    border: none;
    border-radius: 5px;
    background-color: #white;
    color: white;
    padding: 10px 20px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    border-radius: 5px;
}
</style>
<script type="text/javascript">

function resetNotice(id) {
	if()
    
}
document.addEventListener("DOMContentLoaded", function() {
    document.querySelector("form").addEventListener("submit", function(event) {
        // 등록 전 확인 메시지 표시
        var confirmMessage = "등록하시겠습니까?";
        if (!confirm(confirmMessage)) {
            event.preventDefault(); // 제출을 중지
        }  
    });
});


</script>
<div class="container">
<form method="post" action="/admin/updateNotice.do">
<input type="hidden" name="notiid" value="${dto.notiid}">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <table class="form-table">
        <tr>
            <td><input type="text" name="subject" placeholder="제목을 입력해 주세요." value="${dto.subject}"></td>
        </tr>
        <tr>
            <td><textarea name="content" placeholder="내용을 입력하세요." rows="10" cols="50">${dto.content}</textarea></td>
        </tr>
        <tr>
            <td class="button-container">
                <button style="color: white"; type="submit">등록</button>
            </td>
       </tr>
            
    </table>
    </form>
</div>
<jsp:include page="../footer.jsp"/>
