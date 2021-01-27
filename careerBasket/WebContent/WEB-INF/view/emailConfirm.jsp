<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>emailConfirm.jsp</title>
</head>
<body>
<h1>비밀번호 찾기</h1>
<form action="/user/emailSucc" method="post">
	이메일 주소 인증 <br>
	<input type="hidden" name="email" value="${email}">
	<input type="hidden" name="confirmNum" value="${confirmNum}">
	<input type="text" name="userConfirm" placeholder="전송된 인증번호를 입력해주세요."> <br>
	<span id="message"></span>
	<input type="submit" id="confirm" value="확인">
</form>
</body>
</html>