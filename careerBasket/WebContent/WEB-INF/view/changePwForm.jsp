<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>changePwForm.jsp</title>

<!-- css 관련 파일 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="/css/header.css">
<link rel="stylesheet" type="text/css" href="/css/changePwForm.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("input[name=rePw]").blur(function(){
			var pw = $("input[name=pw]").val();
			var rePw = $("input[name=rePw]").val();
			
			if(pw == "" || rePw == ""){		//비밀번호를 입력하지 않았을 때
				$("#message").text("비밀번호를 입력해주세요");
				$("#changePw").prop("disabled",true);
				return false;
			}
			if(pw == rePw){
				$("#message").text("비밀번호가 동일합니다.");
				$("#changePw").prop("disabled",false);
			}else{
				$("#message").text("비밀번호가 다릅니다. 다시 입력해주세요");
				$("#changePw").prop("disabled",true);
			}
		})
	})
</script>
</head>
<body>
	<!-- 상단바 -->
	<div class="top">
		<div class="top_left"><a href="/user/logout" style="color:#82B6ED">careerBasket</a></div>	<!-- 로그아웃 했을 때 첫 화면으로 가기 -->
		<div class="top_middle">
			<a href="/hire/list">탐색</a>
			<a href="/user/loginForm">이력서</a>
		</div>
		<div class="top_right">
			<button class="btn btn-color"><a href="/user/signup">회원가입</a></button>
			<button class="btn btn-color"><a href="/user/loginForm">로그인</a></button>
		</div>
	</div>
	<div class="all">
		<h1>비밀번호 변경</h1><br> <hr>
		<div class="bottom">
			<form action="/user/changePw" method="post">
				<span id="text1">비밀번호</span> <input id="pwForm" type="password" name="pw" placeholder="비밀번호를 입력해주세요."> <br>
				<span id="text2">비밀번호 확인</span> <input id="repwForm" type="password" name="rePw" placeholder="비밀번호를 한번 더 입력해주세요."> <br>
				<span id="message"></span> <br>
				<input type="hidden" name="email" value="${email}">
				<input type="hidden" name="name" value="${name}"> 
				<input type="hidden" name="userId" value="${userId}"> 
				<input type="submit" id="changePw" value="비밀번호 변경">
			</form>
		</div>
	</div>
</body>
</html>