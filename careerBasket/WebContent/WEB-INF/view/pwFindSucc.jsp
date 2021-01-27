<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
<title>pwFindSucc.jsp</title>
</head>
<body>
	<h1>비밀번호 찾기</h1>
	<i class="far fa-envelope"></i>
	<h2>이메일 인증 완료 후</h2> <br>
	<h2>비밀번호를 변경해주세요!</h2> <br>
	<h5>입력하신 ${showEmail}으로 <br> 인증번호가 발송될 예정입니다.</h5> <br>
	<form action="/user/sendMail" method="get">
		<input type="hidden" name="emailAddr" value="${email}"> 
		<input type="submit" value="인증번호 받기">
	</form>
</body>
</html>