<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/table.css">
<script type="text/javascript">
/* function editUser(id) {
    var form = document.createElement('form');
    form.method = 'POST';
    form.action = '/admin/editUser.do';

    var idInput = document.createElement('input');
    idInput.type = 'hidden';
    idInput.name = 'id';
    idInput.value = id;
    form.appendChild(idInput);

    document.body.appendChild(form);
    form.submit();
} */

function deleteUser(id) {
	if(confirm("정말 삭제하시겠습니까?")){
		$.ajax({
	        url: "deleteUser.ajax",
	        type: "POST",
	        data: {"id" : id },
	        success: function(response) {
	        	alert("삭제 하였습니다.");
	        	accList();
	        },
	        error: function(xhr, status, error) {
	            console.error("Error editing user: " + error);
	        }
	    });
	}
}
function accList(){
	let sel = $("select").val();
	$.ajax({
		url : "listAcc.ajax",
		type : "post",
		data : {"sel" : sel},
		success : function(res) {
			 // JSON 데이터를 파싱
            var data = JSON.parse(res);
            // 테이블 초기화
            $("#accountTable").empty();
            // 테이블 헤더 추가
            $("#accountTable").append("<tr><th>ID</th><th>비밀번호</th><th>이름</th><th>메일</th><th>전화번호</th><th>고객분류</th><th>삭제</th></tr>");
            // JSON 데이터를 테이블에 추가
            $.each(data, function(index, item) {
//            	var row = "<tr><td>" + item.Id + "</td><td>" + item.Passwd + "</td><td>" + 
//              item.Name + "</td><td>" + item.Mail + "</td><td>" + item.Phone + "</td><td>" + 
//              item.Grade + "</td><td width='15%'><button onclick='editUser(\"" + item.Id + "\")'>수정</button>&nbsp<button onclick='deleteUser(\"" + item.Id + "\")'>삭제</button></td></tr>";
				var row = "<tr><td>" + item.Id + "</td><td>" + item.Passwd + "</td><td>" + 
                item.Name + "</td><td>" + item.Mail + "</td><td>" + item.Phone + "</td><td>" + 
                item.Grade + "</td><td width='15%'><button onclick='deleteUser(\"" + item.Id + "\")'>삭제</button></td></tr>";
				$("#accountTable").append(row);
            });
		},
		error : function(err) {
			console.log(err);
		}
	})
}

</script>
<div align="center">
	<select id="select">
		<option value="2">점주</option>
		<option value="3">이용객</option>
	</select>
	<input type="button" name="searchBtn" id="searchBtn" value="검색" onclick="accList()">
	<table id="accountTable">
	</table>
</div>
<jsp:include page="../footer.jsp" />
