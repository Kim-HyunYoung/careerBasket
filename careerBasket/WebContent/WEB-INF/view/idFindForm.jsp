<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>findIdForm.jsp</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){	//로드가 끝나면
		$("input[name=email]").blur(function(){		//이메일 폼에서 마우스 커서가 떠나면
			if($("input[name=name]").val() == "" || $("input[name=email]").val() ==""){		//이름 또는 이메일 입력을 안한 경우
				$("#message").text("이름 또는 이메일이 입력되지 않았습니다.");
			}else{		//입력이 다 한 경우
				$("#message").text("");
			}
		})
	})
</script>
</head>
<body>
	<h1>아이디 찾기</h1>
	<form action="/user/findId" method="post">
		이름 <br>
		<input type="text" name="name" placeholder="이름을 입력해주세요."> <br>
		이메일 <br>
		<input type="text" name="email" placeholder="가입 시 등록하신 이메일 주소를 입력해주세요."> <br>
		<span id="message"></span> <br>
		<input type="submit" value="확인">
	</form>
</body>
</html>