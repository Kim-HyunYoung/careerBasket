<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
<title>succFindId.jsp</title>
</head>
<body>
<h1>아이디 찾기</h1>
<i class="fas fa-user-check"></i> <br>
<h2>고객님의</h2><br> <h2>아이디 찾기가 완료되었습니다!</h2> <br>
<h5>아이디 : ${userId}</h5> <br>
<button><a href="/user/findPwForm">비밀번호 찾기</a></button> <br>
<button><a href="/user/loginForm">로그인하기</a></button> <br>
</body>
</html>