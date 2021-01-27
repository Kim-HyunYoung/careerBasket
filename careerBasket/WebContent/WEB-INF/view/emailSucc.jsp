<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
<title>emailSucc.jsp</title>
</head>
<body>
	<h1>비밀번호 찾기</h1>
	<i class="fas fa-user-check"></i> <br>
	<h1>이메일 인증이 완료되었습니다!</h1>
	<button><a href="/user/loginForm">로그인 하기</a></button> <br>
	
	<form action="/user/changePwForm" method="get">
		<input type="hidden" name="email" value="${email}">
		<input type="submit" value="비밀번호 변경하기">
	</form>
</body>
</html>