<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>emailConfirm.jsp</title>

<!-- css 관련 파일 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="/css/header.css">
<link rel="stylesheet" type="text/css" href="/css/emailConfirm.css">

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
		<h1>비밀번호 찾기</h1>
		<div class="bottom">
			<form action="/user/emailSucc" method="post">
				<span id="text">이메일 주소 인증</span> <br>
				<input type="hidden" name="email" value="${email}">
				<input type="hidden" name="name" value="${name}"> 
				<input type="hidden" name="userId" value="${userId}"> 
				<input type="hidden" name="confirmNum" value="${confirmNum}">
				<input type="text" name="userConfirm" placeholder="전송된 인증번호를 입력해주세요."> <br>
				<input id="confirm" type="submit" id="confirm" value="확인">
			</form>
		</div>
	</div>
</body>
</html>