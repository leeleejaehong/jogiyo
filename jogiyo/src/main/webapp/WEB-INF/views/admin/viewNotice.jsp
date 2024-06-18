<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/table.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
.container {
    width: 50%;
    margin: 0 auto;
    margin-top: 50px;
    padding: 20px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); /* 그림자 설정 */
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
.form-table button:hover {
    background-color: #darkred;
}
tr:hover {
    background-color: white;
}
.button-container {
    text-align: center;
    margin-top: 20px;
}

.button-container button {
    background-color: #fa0050; 
    border: none;
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
    
}
function deleteNotice() {
    if (confirm("정말로 삭제하시겠습니까?")) {
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = '/admin/deleteNotice.do';

        var idInput = document.createElement('input');
        idInput.type = 'hidden';
        idInput.name = 'notiid';
        idInput.value = ${dto.notiid};
        form.appendChild(idInput);
        
        var csrfToken = $("meta[name='_csrf']").attr("content");
        
        var idInput2 = document.createElement('input');
        idInput2.type = 'hidden';
        idInput2.name = '_csrf';
        idInput2.value = csrfToken;
        form.appendChild(idInput2);

        document.body.appendChild(form);
        form.submit();
    }
}
function editNotice() {
	var form = document.createElement('form');
    form.method = 'POST';
    form.action = '/admin/editNotice.do';

    var idInput = document.createElement('input');
    idInput.type = 'hidden';
    idInput.name = 'notiid';
    idInput.value = ${dto.notiid};
    form.appendChild(idInput);
    
	var csrfToken = $("meta[name='_csrf']").attr("content");
    
    var idInput2 = document.createElement('input');
    idInput2.type = 'hidden';
    idInput2.name = '_csrf';
    idInput2.value = csrfToken;
    form.appendChild(idInput2);

    document.body.appendChild(form);
    form.submit();
}
</script>

<%-- <form method="post" action="/admin/editNotice.do">
<input type="hidden" name="notiid" value="${dto.notiid}">
</form> --%>
<div class="container">
    <table class="form-table">
        <tr>
            <td><input type="text" name="subject" value="${dto.subject}" disabled></td>
        </tr>
        <tr>
            <td><textarea name="content" rows="10" cols="50" disabled>${dto.content}</textarea></td>
        </tr>
        <tr>
            <td class="button-container">
                <button style="color: white"; onclick="javascript: editNotice()">수정</button>
                <button style="color: white"; onclick="javascript: deleteNotice()">삭제</button>
               
       
            </td>
        </tr>
    </table>
</div>
<jsp:include page="../footer.jsp"/>
