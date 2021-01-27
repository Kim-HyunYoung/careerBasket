<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myInfoUpdateForm.jsp</title>
</head>
<body>
<input type="text" name="userId" value="${si.userId }" readonly="readonly">
<input type="text" name="password" value="${si.password }">
<input type="text" name="name" value="${si.name }">
<input type="date" name="birthDate" value="${si.birthDate }">
<input type="text" name="sex" value="${si.sex }">
<input type="text" name="email" value="${si.email }">
<input type="tel" name="tel" value="${si.tel }">
<input type="text" name="address" value="${si.address }">
</body>
</html>