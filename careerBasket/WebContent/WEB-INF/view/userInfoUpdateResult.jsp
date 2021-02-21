<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	window.location="${pageContext.request.contextPath}/user/main?userId="+${userId};
})
</script>
<title>userInfoUpdateResult.jsp</title>
</head>
<body>

</body>
</html>