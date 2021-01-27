<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>changePwForm.jsp</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("input[name=rePw]").blur(function(){
			var pw = $("input[name=pw]").val();
			var rePw = $("input[name=rePw]").val();
			
			if(pw == "" || rePw == ""){		//비밀번호를 입력하지 않았을 때
				$("#message").text("비밀번호를 입력해주세요");
				$("#changePw").prop("disabled",true);
				return false;
			}
			if(pw == rePw){
				$("#message").text("비밀번호가 동일합니다.");
				$("#changePw").prop("disabled",false);
			}else{
				$("#message").text("비밀번호가 다릅니다. 다시 입력해주세요");
				$("#changePw").prop("disabled",true);
			}
		})
	})
</script>
</head>
<body>
<h1>비밀번호 변경</h1><br> <hr>
<form action="/user/changePw" method="post">
	비밀번호 <input type="password" name="pw" placeholder="비밀번호를 입력해주세요."> <br>
	비밀번호 확인 <input type="password" name="rePw" placeholder="비밀번호를 한번 더 입력해주세요."> 
	<span id="message"></span> <br>
	<input type="hidden" name="email" value="${email}">
	<input type="submit" id="changePw" value="비밀번호 변경">
</form>
</body>
</html>