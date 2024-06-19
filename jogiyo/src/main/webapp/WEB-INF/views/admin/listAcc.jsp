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
	var csrfToken = $("meta[name='_csrf']").attr("content");  // CSRF 토큰 값 가져오기
    var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // CSRF 헤더 이름 가져오기
	if(confirm("정말 삭제하시겠습니까?")){
		$.ajax({
	        url: "deleteUser.ajax",
	        type: "POST",
	        data: {
	        	"id" : id,
	        	"_csrf": csrfToken		
	        },
	        beforeSend: function(xhr) {
                // AJAX 요청 헤더에 CSRF 토큰 추가
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
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
	var csrfToken = $("meta[name='_csrf']").attr("content");  // CSRF 토큰 값 가져오기
    var csrfHeader = $("meta[name='_csrf_header']").attr("content");  // CSRF 헤더 이름 가져오기
	$.ajax({
		url : "listAcc.ajax",
		type : "post",
		data: {
	            "sel": sel,
	            "_csrf": csrfToken  // CSRF 토큰을 데이터에 추가
	        },
	        beforeSend: function(xhr) {
                // AJAX 요청 헤더에 CSRF 토큰 추가
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
		success : function(res) {
			 // JSON 데이터를 파싱
            var data = JSON.parse(res);
            // 테이블 초기화
            $("#accountTable").empty();
            // 테이블 헤더 추가
            $("#accountTable").append("<tr><th>ID</th><th>이름</th><th>메일</th><th>전화번호</th><th>고객분류</th><th>삭제</th></tr>");
            // JSON 데이터를 테이블에 추가
            $.each(data, function(index, item) {
//            	var row = "<tr><td>" + item.Id + "</td><td>" + item.Passwd + "</td><td>" + 
//              item.Name + "</td><td>" + item.Mail + "</td><td>" + item.Phone + "</td><td>" + 
//              item.Grade + "</td><td width='15%'><button onclick='editUser(\"" + item.Id + "\")'>수정</button>&nbsp<button onclick='deleteUser(\"" + item.Id + "\")'>삭제</button></td></tr>";
				var row = "<tr><td>" + item.Id + "</td><td>" + item.Name + "</td><td>" + item.Mail + "</td><td>" + item.Phone + "</td><td>" + 
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
		<option value="ROLE_2">점주</option>
		<option value="ROLE_3">이용객</option>
	</select>
	<input type="button" name="searchBtn" id="searchBtn" value="검색" onclick="accList()">
	<table id="accountTable">
	</table>
</div>
<jsp:include page="../footer.jsp" />
