<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>findIdForm.jsp</title>

<!-- css 관련 파일 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="/css/header.css">
<link rel="stylesheet" type="text/css" href="/css/idFindForm.css">

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
	<!-- 상단바 -->
	<div class="top">
		<div class="top_left"><a href="/user/logout" style="color:#82B6ED">careerBasket</a></div>	<!-- 로그아웃 했을 때 첫 화면으로 가기 -->
		<div class="top_middle">
			<a href="/hire/list">탐색</a>
			<a href="/user/loginForm">이력서</a>
		</div>
		<div class="top_right">
			<button class="btn btn-color"><a href="/user/signup">회원가입</a></button>
			<button class="btn btn-color"><a href="/user/loginForm">로그인</a></button>
		</div>
	</div>
	
	<div class="all">
		<h1>아이디 찾기</h1>
		<form action="/user/findId" method="post">
			<span id="name">이름</span> <br>
			<input type="text" name="name" placeholder="이름을 입력해주세요."> <br>
			<span id="email">이메일</span> <br>
			<input type="text" name="email" placeholder="가입 시 등록하신 이메일 주소를 입력해주세요."> <br>
			<span id="message"></span> <br>
			<input id="confirm" type="submit" value="확인">
		</form>
	</div>
</body>
</html>