<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myInfoUpdateForm.jsp</title>
</head>
<body>
<form action="/resume/userInfoUpdate" >
<input type="text" name="userId" value="${info.userId }" readonly="readonly">
<input type="text" name="password" value="${info.password }">
<input type="text" name="name" value="${info.name }">
<input type="date" name="birthDate" value="${info.birthDate }">
<input type="text" name="sex" value="${info.sex }">
<input type="text" name="email" value="${info.email }">
<input type="tel" name="tel" value="${info.tel }">
<input type="text" name="address" value="${info.address }">
</form>
</body>
</html>