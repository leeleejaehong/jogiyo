<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 회원가입 페이지 -->
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
					        title: '딸기 치즈 케익',
					        description: '#케익 #딸기 #삼평동 #카페 #분위기 #소개팅',
					        image_url:
					          'https://mud-kage.kakao.com/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png',
					        link: {
					          web_url: 'https://developers.kakao.com',
					          mobile_web_url: 'https://developers.kakao.com',
					        },
					      },
					      item_content: {
					        profile_text: 'Kakao',
					        profile_image_url: 'https://mud-kage.kakao.com/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png',
					        title_image_url: 'https://mud-kage.kakao.com/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png',
					        title_image_text: 'Cheese cake',
					        title_image_category: 'Cake',
					        items: [
					          {
					            item: 'Cake1',
					            item_op: '1000원',
					          },
					          {
					            item: 'Cake2',
					            item_op: '2000원',
					          },
					          {
					            item: 'Cake3',
					            item_op: '3000원',
					          },
					          {
					            item: 'Cake4',
					            item_op: '4000원',
					          },
					          {
					            item: 'Cake5',
					            item_op: '5000원',
					          },
					        ],
					        sum: 'Total',
					        sum_op: '15000원',
					      },
					      social: {
					        like_count: 100,
					        comment_count: 200,
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
<a href="https://kauth.kakao.com/oauth/authorize?client_id=
faae190fd5bb60c910724b6781aeda60&redirect_uri=http://localhost:7080/login/join_membership.do&response_type=code&scope=talk_message">테스트버튼</a>
<button onclick="sendToMe()">테스트버튼</button>
<form name="f1" method="post" onsubmit="return check()"
	action="/login/join_membership_ok.do">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<table width="600" align="center" class="outline">
		<tr>
			<td colspan="2" align="center" class="m2">회원가입</td>
		</tr>
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
			<td width="150" class="m3">전화번호</td>
			<td class="m3"><input type="text" title="전화번호" name="phone1"
				class="box" size="3" maxlength="3"> - <input type="text"
				title="전화번호" name="phone2" class="box" size="3" maxlength="4">
				- <input type="text" title="전화번호" name="phone3" class="box" size="3"
				maxlength="4"></td>
		</tr>
		</form>
		<tr>
			<td colspan="3" align="center"><input type="submit" value="확인">
				<button type="button"
					onclick="alert('로그인 페이지로 이동합니다.');
				window.location.href='login.do';">취소</button>
				<input type="button" value="카카오인증"></td>
		</tr>
	</table>
</form>
<jsp:include page="../footer.jsp" />