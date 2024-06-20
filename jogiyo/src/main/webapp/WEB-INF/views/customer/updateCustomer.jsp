<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
function checkPass() {
	let id = $("#id").val();
	let passwd = $("#passwd").val();
	let passwd1 = $("#passwd1").val();
	let passwd2 = $("#passwd2").val();
	var csrfToken = $("meta[name='_csrf']").attr("content");
    var csrfHeader = $("meta[name='_csrf_header']").attr("content");
    $.ajax({
		url : "checkPasswd.ajax",
		type : "post",
		data : {
			"id" : id,
			"passwd" : passwd1,
			"_csrf": csrfToken
		},
		beforeSend: function(xhr) {
            xhr.setRequestHeader(csrfHeader, csrfToken);
        },
        success : function(res) {
        	if(res == 'ok'){
	            if(passwd != passwd2 || passwd ==''){
	            	alert('변경할 비밀번호가 일치하지 않습니다!');
	            	return;
	            }
	            alert('비밀번호 확인 완료!');
	            document.getElementById('btn').disabled = false;
        	}else{
        		alert('입력하신 비밀번호와 현재 비밀번호가 일치 하지 않습니다!');
        		return;
        	}
        },
        error : function(err) {
			console.log(err);
		}
	})
}
</script>
<div align="center">
	<form action="/customer/updateOk.do" method="post" >
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	 	 <h1>회원 정보 수정</h1>
    
        <label for="id">ID:</label>
        <input type="text" id="id" name="id" value="${customer.id}" readonly="readonly"><br>
        
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" value="${customer.name}"><br>
        
        <label for="mail">Email:</label>
        <input type="text" id="mail" name="mail" value="${customer.mail}"><br>
        
        <label for="phone">Phone:</label>
        <input type="text" id="phone" name="phone" value="${customer.phone}"><br>
        
        <label for="passwd1">현재 비밀번호:</label>
        <input type="password" id="passwd1" name="passwd1" value="" >
        <input type="button" onclick="checkPass()" name="checkPasswd" id="checkPasswd" value="비밀번호확인"><br>
        
        <label for="passwd2">변경할 비밀번호:</label>
        <input type="password" id="passwd2" name="passwd2" value="" ><br>
        
        <label for="passwd">변경할 비밀번호 확인:</label>
        <input type="password" id="passwd" name="passwd" value="" ><br>
        
        <button type="submit" id="btn" disabled="disabled">Update</button>
        
	</form>
</div>
<jsp:include page="../footer.jsp"/>

