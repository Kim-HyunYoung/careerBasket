<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
<title>pwFindSucc.jsp</title>

<!-- css 관련 파일 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="/css/header.css">
<link rel="stylesheet" type="text/css" href="/css/pwFindSucc.css">

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
		<div id="icon">
			<i class="far fa-envelope"></i>
		</div>
		<div id="bottom">
			<h2>이메일 인증 완료 후</h2> <br>
			<h2>비밀번호를 변경해주세요!</h2> <br>
			<h5>입력하신 ${showEmail}으로 </h5> <br>
			<h5 id="next"> 인증번호가 발송될 예정입니다.</h5> <br>
			<form action="/user/sendMail" method="get">
				<input type="hidden" name="emailAddr" value="${email}">
				<input type="hidden" name="name" value="${name}"> 
				<input type="hidden" name="userId" value="${userId}"> 
				<input id="confirmNum" type="submit" value="인증번호 받기">
			</form>
		</div>
	</div>
</body>
</html>