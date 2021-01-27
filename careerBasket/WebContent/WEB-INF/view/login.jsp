<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- 구글 로그인 api -->
<html lang="kr" xmlns="http://www.w3.org/1999/xhtml">
<html>
<head>
<!-- 구글 로그인 api 설정 -->
<meta charset="utf-8" />
<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id" content="343762072746-e19hdtmdj9anhjmppiivg0gs68bn4ktc.apps.googleusercontent.com">
<script src="https://apis.google.com/js/platform.js" async defer></script>

<meta charset="UTF-8">
<title>login.jsp</title>
<!-- 네아로(네이버 아이디로 로그인)  설정 -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){	//로드가 끝났다면
		
		$("#login").on("click", function(){	//로그인 버튼을 클릭했을 때
			var id = $("input[name=userId]").val();
			var pw = $("input[name=password]").val();
			
			//아이디 또는 비밀번호 입력을 안했을 경우
			if(id =="" || pw ==""){
				$("#message").text("아이디 또는 비밀번호가 입력되지 않았습니다.");
				return false;	//text 덮어쓰기 안되게 하기 위해서
			}
			
			$.ajax({
				url:"${pageContext.request.contextPath}/user/login?userId="+id+"&password="+pw,
				type:"get",
				success:function(resp){
					if(resp == 1){
						window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/user/main?userId="+id);
					}else{
						$("#message").text("가입하지 않은 아이디이거나, 잘못된 비밀번호 입니다.");
					}
				},
				error:function(e){
					console.log(e);
				}
			})
			return false;	//form에서 전송 못하게 하기위해
			
		})
	})
</script>
</head>
<body>
	<h1>LOGIN</h1>
	<form>
		<input type="text" name="userId" placeholder="아이디를 입력해주세요"> <br> 
		<input type="password" name="password" placeholder="비밀번호를 입력해주세요"><br>
		<span id="message"></span> <br>
		<button type="button" id="login">로그인</button>
	</form>
	<hr>
	<button><a href="/user/findIdForm">아이디 찾기</a></button>/<button><a href="/user/findPwForm">비밀번호 찾기</a></button>
	<hr>
	
	<!-- 네이버 아이디 로그인 api -->
	
	<!-- 네이버아이디로로그인 버튼 노출 영역 -->
	<div id="naverIdLogin"></div>
	
	<!-- 네이버아디디로로그인 초기화 Script -->
	<script type="text/javascript">
		var naverLogin = new naver.LoginWithNaverId(
			{
				clientId: "MRPOLZ1RsUFfZwKNeAWg",
				callbackUrl: "http://localhost:8080/user/callback",
				isPopup: false, /* 팝업을 통한 연동처리 여부 */
				loginButton: {color: "white", type: 3, height: 60} /* 로그인 버튼의 타입을 지정 */
			}
		
		);
		
		/* 설정정보를 초기화하고 연동을 준비 */
		naverLogin.init();
		
	</script>
	<!-- // 네이버아이디로로그인 초기화 Script -->
	
	<!-- 구글 로그인 api -->
    <div class="g-signin2" data-onsuccess="onSignIn" data-theme="dark"></div>
    <script>
    
        function onSignIn(googleUser) {
            // Useful data for your client-side scripts:
            var profile = googleUser.getBasicProfile(); //구글 유저 정보 가져오기
          
            var userId = profile.getName();	//유저 정보 중 아이디 가져오기
            var email = profile.getEmail();	//유저 정보 중 이메일 가져오기
            	
            //form 생성후에 동적으로 보내주기
            var form = document.createElement("form");
            form.setAttribute("method", "get");
            form.setAttribute("action", "${pageContext.request.contextPath}/user/googleInfo");
           
            //input userId를 hidden으로 설정
            var field = document.createElement("input");
            field.setAttribute("type", "hidden");
            field.setAttribute("name", "userId");
            field.setAttribute("value", userId);
            form.appendChild(field);
            
            //input email를 hidden으로 설정
            var field2 = document.createElement("input");
            field2.setAttribute("type", "hidden");
            field2.setAttribute("name", "email");
            field2.setAttribute("value", email);
            form.appendChild(field2);
            
            document.querySelector("body").appendChild(form);
            form.submit();	//submit 해주기
            
        };
    </script>
	
</body>
</html>