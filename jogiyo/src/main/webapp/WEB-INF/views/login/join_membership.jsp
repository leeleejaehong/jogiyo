<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 회원가입 페이지 -->
<jsp:include page="../header.jsp"/>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
		let ck = false;
		function idCheck(){
			let id =$("#jid").val();
			if (id == ""){
				alert("아이디를 입력해주세요");
				$("#jid").focus();
				return;
			}
			
			$.ajax({
				url : "idCheck.do",
				type : "post",
				data : {"jid" : id},
				success : function(res){
					if (res == "OK"){
						alert("사용가능한 아이디 입니다.")
						ck = true;
					}else{
						alert("이미 사용중인 아이디 입니다.")
						$("#jid").val("");
						$("#jid").focus();
						ck = false;
					}
				},
				error : function(err){
					console.log(err);
					ck = false;
				}
				
			})
		}
		function check(){
			if (ck == false){
				alert("아이디 중복확인을 먼저 해주세요.")
				return false;
			}
			

			const jfrm = document.f1;
			let length = jfrm.length-2;
			for (let i=0; i<length; i++){	
				if (jfrm[i].value == "" || jfrm[i].value == null){
					alert(jfrm[i].title +"을 입력해 주세요");
					jfrm[i].focus();
					return false;
				}
			}
			return true;
		}
	</script>

		<form name="f1" method="post" onsubmit="return check()" action="/login/join_membership_ok.do">
			<table width="600" align="center" class="outline">
		<tr>
			<td colspan="2" align="center" class="m2">회원가입</td>
		</tr>
		<tr>
			<td width="150" class="m3">이름</td>
			<td class="m3">
				<input type="text" name="name" class="box">
			</td>	
		</tr>
		<tr>
			<td width="150" class="m3">아이디</td>
			<td class="m3">
				<input type="text" name="id" id="jid" title="아이디">
				<input type="button" value="중복확인" onclick="idCheck()">
			</td>
		</tr>
		<tr>
			<td width="150" class="m3">비밀번호</td>
			<td class="m3">
				<input type="password" name="passwd" title="비밀번호">
			</td>
		</tr>
		<tr>
			<td width="150" class="m3">이메일</td>
			<td class="m3">
				<input type="text" name="mail" title="이메일">
			</td>
		</tr>
		<tr>
			<td width="150" class="m3">전화번호</td>
			<td class="m3">
				<input type="text" title="전화번호" name="phone1" class="box" size="3" maxlength="3"> -
				<input type="text" title="전화번호"name="phone2" class="box" size="3" maxlength="4"> -
				<input type="text" title="전화번호"name="phone3" class="box" size="3" maxlength="4"> 
			</td>
		</tr>
		</form>
		<tr>
			<td colspan="3" align="center">
				<input type="submit" value="확인">
				<button type="button" onclick="alert('로그인 페이지로 이동합니다.');
				window.location.href='login.do';">취소</button>
				<input type="button" value="카카오인증">
			</td>
		</tr>
			</table>
			</form>
<jsp:include page="../footer.jsp"/>