<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!-- 회원가입 페이지 -->
<jsp:include page="../header.jsp" />

<style>
    /* 기본 스타일 */
    .form-container {
        margin: 0 auto;
        border-collapse: collapse;
        width: 25%;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-shadow: 0 8px 16px rgba(1, 1, 1, 0.2);
        background-color: #f9f9f9;
        padding-left: 20px;
    	padding-right: 20px;
        padding-top: 35px;
   		padding-bottom: 60px;
    }
    
   .form-row {
    display: flex;
    align-items: center; /* 세로 중앙 정렬 */
}
    
    /*테이블 세로 길이 줄임  */
    .form-container td {
        padding: 1px;
    }

    .form-container input[type="text"]
    .form-container input[type="password"] {
        width: calc(110% - 20px);
        padding: 8px;
        border-radius: 5px;
        border: 1px solid #ccc;
        display: block;
        margin: 10px auto;
        font-size: 14px;
    }

    .form-container button { /* 인증번호, 취소, 인증번호 전송 버튼  */
        background-color: #fa0050;
        color: white;
        border: none;
        padding-top: 4px; /* 위쪽 padding 설정 */
   		padding-bottom: 4px; /* 아래쪽 padding 설정 */
   		padding-left: 5px; /* 왼쪽 padding 설정 */
    	padding-right: 5px; /* 오른쪽 padding 설정 */
        cursor: pointer;
        border-radius: 5px;
        width: calc(80% - 10px); /* 버튼 넓이 */
        display: block;
        margin: 10px auto;
        font-size: 16px;
    }
    
    table {
    border-spacing: 3px; /* 테이블 셀 사이의 간격을 설정함 */
	}

	table, tr, td {
	    padding: 7px; /* 테이블과 각 행, 셀의 내부 여백을 설정하여 간격을  줌 */
	}
    
  	.form-container input[type="submit"]{	/* 확인 submit */
  		background-color: #fa0050;
        color: white;
        border: none;
        padding-top: 4px; /* 위쪽 padding 설정 */
   		padding-bottom: 4px; /* 아래쪽 padding 설정 */
   		padding-left: 2px; /* 왼쪽 padding 설정 */
    	padding-right: 2px; /* 오른쪽 padding 설정 */
        cursor: pointer;
        border-radius: 5px;
        width: calc(130% - 10px); /* 버튼 넓이 */
        display: block;
        margin: 10px auto;
        font-size: 16px;
  	}
    

    .form-container .actions form {
        display: inline;
    }

    .form-container .actions button {
        background-color: #fa0050;
        color: white;
        border: none;
        padding: 10px 20px;
        cursor: pointer;
        border-radius: 5px;
        margin: 5px 0;
    }

    .form-container a {
        color: #fa0050;
        text-decoration: none;
        font-size: 14px;
    }

    .form-container a:hover {
        text-decoration: underline;
    }

    /* 반응형 스타일 */
    @media (max-width: 768px) {
        .form-container {
            width: 80%;
        }
        .form-container input[type="text"],
        .form-container input[type="password"],
        .form-container button {
            width: 100%;
            margin: 10px 0;
        }
    }

    @media (max-width: 480px) {
        .form-container {
            width: 100%;
        }
    } 
</style>



<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
   let ck = false;
   function idCheck() {
      let id = $("#jid").val();
      if (id == "") {
         alert("아이디를 입력해주세요");
         $("#jid").focus();
         return;
      }
      var csrfToken = $("meta[name='_csrf']").attr("content");
       var csrfHeader = $("meta[name='_csrf_header']").attr("content");  
      $.ajax({
         url : "idCheck.do",
         type : "post",
         data : {
            "jid" : id,
            "_csrf": csrfToken
         },
         beforeSend: function(xhr) {
                // AJAX 요청 헤더에 CSRF 토큰 추가
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
         success : function(res) {
            if (res == "OK") {
               alert("사용가능한 아이디 입니다.")
               ck = true;
            } else {
               alert("이미 사용중인 아이디 입니다.")
               $("#jid").val("");
               $("#jid").focus();
               ck = false;
            }
         },
         error : function(err) {
            console.log(err);
            ck = false;
         }

      })
   }
   function check() {
      if (ck == false) {
         alert("아이디 중복확인을 먼저 해주세요.")
         return false;
      }

      /* const jfrm = document.f1;
      let length = jfrm.length - 2;
      for (let i = 0; i < length; i++) {
         if (jfrm[i].value == "" || jfrm[i].value == null) {
            alert(jfrm[i].title + "을 입력해 주세요");
            jfrm[i].focus();
            return false;
         }
      } */
      return true;
   }
   </script>
   <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.2/kakao.min.js"
  integrity="sha384-TiCUE00h649CAMonG018J2ujOgDKW/kVWlChEuu4jK2vxfAAD0eZxzCKakxg55G4" crossorigin="anonymous"></script>
   <script>
   Kakao.init('faae190fd5bb60c910724b6781aeda60');
   Kakao.isInitialized();
   
   function sendToMe() {
      var url = new URL(window.location.href);
      // AJAX 요청 예시
      $.ajax({
          url: 'https://kauth.kakao.com/oauth/token',
          type: 'POST',
          data: {
              grant_type: 'authorization_code',
              client_id: 'faae190fd5bb60c910724b6781aeda60',
              redirect_url: 'http://localhost:7080/login/join_membership.do',
              code : url.searchParams.get('code')
          },
          success: function(response) {
              console.log(response)
                accessToken = response.access_token;
              console.log('추출된 access_token:', accessToken);
              Kakao.Auth.setAccessToken(accessToken);
            Kakao.API.request({
                 url: '/v2/api/talk/memo/default/send',
                 data: {
                   template_object: {
                     object_type: 'feed',
                     content: {
                       title: '${random}',
                       description: '회원가입을 위한 인증 코드를 확인해주세요.',
                             image_url:
                                'https://developers.kakao.com',
                             link: {
                               web_url: 'https://developers.kakao.com',
                               mobile_web_url: 'https://developers.kakao.com',
                       },
                     },
                    
                     buttons: [
                       {
                         title: '웹으로 보기',
                         link: {
                           mobile_web_url: 'https://developers.kakao.com',
                           web_url: 'https://developers.kakao.com',
                         },
                       },
                       {
                         title: '앱으로 보기',
                         link: {
                           mobile_web_url: 'https://developers.kakao.com',
                           web_url: 'https://developers.kakao.com',
                         },
                       },
                     ],
                   },
                 },
               })
                 .then(function(response) {
                   console.log(response);
                   // 인증 코드를 서버에 전송하여 검증
                         $.ajax({
                             url: 'verifyCode.do',
                             type: 'POST',
                             data: {
                                 access_token: accessToken,
                                 auth_code: response.auth_code // 인증 코드 전송
                             },
                             success: function(verificationResult) {
                                 if (verificationResult === 'success') {
                                     alert('인증이 성공적으로 완료되었습니다.');
                                 } else {
                                     alert('인증에 실패했습니다.');
                                 }
                             },
                             error: function(err) {
                                 console.error('서버 오류:', err);
                             }
                         });
                 })
                 .catch(function(error) {
                   console.log(error);
                 });
          },
          error: function(xhr, status, error) {
              console.error('에러 발생:', error);
          }
      });
   } 
</script>
<script type="text/javascript">

    function out() {
            // 사용자가 입력한 인증번호
   	 		var code = document.getElementById("code").value;
            // 서버에서 받은 랜덤 값
            var random = <%= request.getAttribute("random") %>;
        	 // 유효성 검사
            if (code == random) {
                // 인증 성공 메시지 표시
                document.getElementById("message").innerHTML = "인증이 완료되었습니다.";
                // 확인 버튼 활성화
                // 카카오톡 인증 코드가 맞으면 모든 text 값 활성화
                document.getElementById("ok").disabled = false;
                document.getElementById("name").disabled = false;
                document.getElementById("jid").disabled = false;
                document.getElementById("pw").disabled = false;
                document.getElementById("mail").disabled = false;
                document.getElementById("p1").disabled = false;
                document.getElementById("p2").disabled = false;
                document.getElementById("p3").disabled = false;
                
                
            } else {
                // 인증 실패 메시지 표시
                document.getElementById("message").innerHTML = "인증번호가 일치하지 않습니다. 다시 시도해 주세요.";
                // 확인 버튼 비활성화
                // 카카오 인증 코드가 틀렸을시 모든 text 값 비활성화
                document.getElementById("ok").disabled = true;
                document.getElementById("name").disabled = true;
                document.getElementById("jid").disabled = true;
                document.getElementById("pw").disabled = true;
                document.getElementById("mail").disabled = true;
                document.getElementById("p1").disabled = true;
                document.getElementById("p2").disabled = true;
                document.getElementById("p3").disabled = true;
     
            }
   	 }
   

</script> 

<div align="center" style="margin-top: 20px;""margin-bottom: 20px;">
<h1><span style="font-weight: bold; color:#fa0050; font-family: 'Gothic A1', sans-serif;">회원가입</span></h1>
</div>
<form name="f1" method="post" onsubmit="return check()"
   action="/login/join_membership_ok.do">
   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
   

      <tr>
         <td>이름</td>
         <td><input type="text" name="name" id="name" disabled>
         </td>
      </tr>
      <tr>
         <td>아이디</td>
         <td><input type="text" name="id" id="jid" title="아이디" disabled>
            <input type="button" value="중복확인" onclick="idCheck()"></td>
      </tr>
      <tr>
         <td>비밀번호</td>
         <td><input type="password" name="passwd" id="pw" title="비밀번호" disabled>
         </td>
      </tr>
      <tr>
         <td>이메일</td>
         <td><input type="text" name="mail" id="mail" title="이메일" disabled>
         </td>
      </tr>
      <tr>
         <td>인증번호</td>
         <td><input type="text" name="code" id="code" placeholder="(필수)인증번호 입력">
         <button type="button" onclick="out()">인증번호 확인</button>
          <p id="message"></p>
         </td>
      </tr>
   
      <tr>
         <td>전화번호</td>
         <td>
         <input type="text" title="전화번호" name="phone1" id="p1"size="3" maxlength="3" disabled> -
         <input type="text"title="전화번호" name="phone2" id="p2" size="3" maxlength="4" disabled> -
         <input type="text" title="전화번호" name="phone3" id="p3" size="3"maxlength="4" disabled>
         </td>
      </tr>
      <tr>
         <td>
         <input type="submit" value="확인" id="ok" disabled>
            <button type="button"
               onclick="alert('로그인 페이지로 이동합니다.');
            window.location.href='login.do';">취소</button>
              <a href="https://kauth.kakao.com/oauth/authorize?client_id=
				faae190fd5bb60c910724b6781aeda60&redirect_uri=http://localhost:7080/
				login/join_membership.do&response_type=code&scope=talk_message">카카오 로그인</a>
            <button type="button" onclick="sendToMe()">인증번호 전송</button>
          
         </td>
      </tr>
</form>
<jsp:include page="../footer.jsp" />