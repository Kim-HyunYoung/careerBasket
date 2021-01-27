<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pwFindForm.jsp</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("input[name=email]").blur(function(){
			if($("input[name=userId]").val() == "" || $("input[name=name]").val() == "" ||
				$("input[name=email]").val() == ""){
				$("#message").text("정보가 모두 입력되지 않았습니다. 다시 확인해주세요.");
			}else{
				$("#message").text("");
			}
		})

	})
</script>
</head>
<body>
<h1>비밀번호 찾기</h1> <br>
<form action="/user/findEmail" method="post">
	아이디<br>
	<input type="text" name="userId" placeholder="아이디를 입력해주세요."> <br>
	이름<br>
	<input type="text" name="name" placeholder="이름을 입력해주세요."> <br>
	이메일<br>
	<input type="text" name="email" placeholder="가입 시 등록하신 이메일 주소를 입력해주세요."> <br>
	<span id="message"></span> <br>
	<input type="submit" value="확인">
</form>

</body>
</html>