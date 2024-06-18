<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/table.css">
<style>
    /* 추가된 CSS 스타일 */
    body {
        font-family: Arial, sans-serif;
        background-color: #white;
    }
    
    .container {
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
        text-align: center; /* 가운데로 정렬 */
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
        height: 200px; /* 조정 가능한 높이 */
    }
    
    .form-table button {
        padding: 10px 20px;
        margin-top: 20px;
        border: none;
        border-radius: 5px;
        background-color: #white;
        color: white;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    
    .form-table button:hover {
        background-color: #darkred;
    }
    .form-heading {
    text-align: left;
    }
    tr:hover {
    background-color: #white;
}
</style>
<script type="text/javascript">
function check() {
if(mynotice.subject.value == ""){
    alert("제목을 입력하셔야합니다.");
    mynotice.subject.focus();
    return false;
    }
         
 if(mynotice.content.value.length == 0){
    alert("내용을 입력하셔야합니다.");
    mynotice.content.focus();
    return false;
    }
 
 str = "지금까지 작성한 것들은 : /n";
 str += mynotice.subject.value + "/n";
 str += mynotice.content.value + "/n";
 mynotice.submit();
 
}
 
</script>
<div class="container">
<h4><span style="font-weight: bold; font-family: 'Gothic A1', sans-serif;">게시판 글쓰기</span></h4> 
    <form action="/admin/insertNotice.do" method="post" name="mynotice" onsubmit="return check();"> 
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <table class="form-table">
            <tr>
                <td><input type="text" name="subject" placeholder="제목을 입력하세요"></td>
            </tr>
            <tr>
                <td><textarea name="content" rows="10" cols="50" placeholder="내용을 입력하세요"></textarea></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <button onclick="check()" value="입력되었습니다" type="button">등록</button>
                </td>
            </tr>
         
        </table>
    </form>
 <tr>
 </tr>
    <a href="/admin/listNotice.do">공지사항 목록 보기</a>
</div>
<jsp:include page="../footer.jsp"/>