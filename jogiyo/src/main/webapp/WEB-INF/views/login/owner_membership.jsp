<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 점주 회원가입 페이지 -->
<jsp:include page="../header.jsp" />
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
   // 버튼 비활성화
   function out(){
      let code = document.getElementById('code').value;
      let random = ${random};
      if (random == code){
         console.log("aa")}
         //const target = 
         //   document.getElementById('ok');
         //   target.disabled=false;
         //}else
         //   console.log("error");
   //   }
   
   

</script> 

<!--  <a href="https://kauth.kakao.com/oauth/authorize?client_id=
faae190fd5bb60c910724b6781aeda60&redirect_uri=http://localhost:7080/login/join_membership.do&response_type=code&scope=talk_message">테스트버튼</a>-->
<!-- <button onclick="sendToMe()">테스트버튼</button> -->
<form name="f1" method="post" onsubmit="return check()"
   action="/login/owner_membership_ok.do">
   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
   <table width="600" align="center" class="outline">
   
      <tr>
         <td colspan="2" align="center" class="m2">회원가입</td>
      </tr>
      <!-- <div align="center">
      <select id="select" name="grade">
      login.xml에 grade를 추가  후 jsp에서 name=grade로 값을 보낸다.
      밑에  value 마다 ROLE_2,3 은 점주, 고객으로 지정을 해놨기에
      점주 클릭하고 회원가입시 ROLE_2 으로 저장되고
      고객 클릭하고 회원가입시 ROLE_3 으로 저장된다
        <option value="ROLE_2">점주</option>
         <option value="ROLE_3">고객</option>
      </select>
      </div> -->
      <tr>
         <td width="150" class="m3">이름</td>
         <td class="m3"><input type="text" name="name" class="box">
         </td>
      </tr>
      <tr>
         <td width="150" class="m3">아이디</td>
         <td class="m3"><input type="text" name="id" id="jid" title="아이디">
            <input type="button" value="중복확인" onclick="idCheck()"></td>
      </tr>
      <tr>
         <td width="150" class="m3">비밀번호</td>
         <td class="m3"><input type="password" name="passwd" title="비밀번호">
         </td>
      </tr>
      <tr>
         <td width="150" class="m3">이메일</td>
         <td class="m3"><input type="text" name="mail" title="이메일">
         </td>
      </tr>
      <tr>
         <td width="150">인증번호</td>
         <td class="m3"><input type="text" name="code" title="인증번호" placeholder="(필수)인증번호 입력" id="code">
         <button type="button" onclick="out()">인증번호 확인</button>
         </td>
      </tr>
   
      <tr>
         <td width="150" class="m3">전화번호</td>
         <td class="m3"><input type="text" title="전화번호" name="phone1"
            class="box" size="3" maxlength="3"> - <input type="text"
            title="전화번호" name="phone2" class="box" size="3" maxlength="4">
            - <input type="text" title="전화번호" name="phone3" class="box" size="3"
            maxlength="4"></td>
      </tr>
      </form>
      <tr>
         <td colspan="4" align="center">
         <input type="submit" value="확인" id="ok">
            <button type="button"
               onclick="alert('로그인 페이지로 이동합니다.');
            window.location.href='login.do';">취소</button>
            <button type="button" onclick="sendToMe()">카카오인증</button>
            <a href="https://kauth.kakao.com/oauth/authorize?client_id=
faae190fd5bb60c910724b6781aeda60&redirect_uri=http://localhost:7080/login/join_membership.do&response_type=code&scope=talk_message">인증번호 받기</a>
         </td>
      </tr>
   </table>
</form>
<jsp:include page="../footer.jsp" />