<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	if("${list}"=="[]"){
		$("#ms").append("<p style='text-align: center;margin-bottom: 10%;padding-top: 10%;'>등록된 이력서가 없습니다</p>");
	}else{
		$("#ms").text("");
	}
})
function myinsert(userId){
	 console.log(userId)
	//form생성후에 동적으로 보내주기
	 var form = document.createElement("form");
	  form.setAttribute("method", "get");
	  form.setAttribute("action", "${pageContext.request.contextPath}/resume/addresume");
	  
	  
	//파라미터 넘겨주기 위해 히든타입으로 input id값 입력
	  var hiddenField=document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "userId");
	  hiddenField.setAttribute("value", userId);
	  form.appendChild(hiddenField);
	  
	  //동적 form은 꼭 append해줘야 submit가능
	  document.querySelector("body").appendChild(form);
	  form.submit();
}
function mydelete(resumeId, userId){
	  //console.log(id);
	  //삭제전에 확인창 띄우기
	 if (confirm("정말 삭제하시겠습니까??") == true){    //확인
		  var form = document.createElement("form");
		  form.setAttribute("method", "get");
		  form.setAttribute("action", "${pageContext.request.contextPath}/resume/delete");
		  
		//파라미터 넘겨주기 위해 히든타입으로 input id값 입력
		  var hiddenField=document.createElement("input");
		  hiddenField.setAttribute("type", "hidden");
		  hiddenField.setAttribute("name", "userId");
		  hiddenField.setAttribute("value", userId);
		  form.appendChild(hiddenField);
		  
		//파라미터 넘겨주기 위해 히든타입으로 input id값 입력
		  var hiddenField=document.createElement("input");
		  hiddenField.setAttribute("type", "hidden");
		  hiddenField.setAttribute("name", "resumeId");
		  hiddenField.setAttribute("value", resumeId);
		  form.appendChild(hiddenField);
		  
		  //동적 form은 꼭 append해줘야 submit가능
		  document.querySelector("body").appendChild(form);
		  form.submit();
		}else{   //취소
		    return;
		} 			
}
function myupdate(resumeId, userId){
	  console.log(resumeId);
	  var form = document.createElement("form");
	  form.setAttribute("method", "get");
	  form.setAttribute("action", "${pageContext.request.contextPath}/resume/update");
	  
	  //파라미터 넘겨주기 위해 히든타입으로 input하고 submit함
	  var hiddenField=document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "resumeId");
	  hiddenField.setAttribute("value", resumeId);
	  form.appendChild(hiddenField);
	  
		//파라미터 넘겨주기 위해 히든타입으로 input id값 입력
	  var hiddenField=document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "userId");
	  hiddenField.setAttribute("value", userId);
	  form.appendChild(hiddenField);
	  
	  //동적 form은 꼭 append해줘야 submit가능
	  document.querySelector("body").appendChild(form);
	  form.submit();
}
</script>
<title>allList.jsp</title>
<!-- ----------------------------부트스트랩 CDN-------------------------------- -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">


<!-- ---------------------------------------폰트 CDN---------------------------------------------- -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="/css/header.css">
<link rel="stylesheet" type="text/css" href="/css/allList.css">

</head>
<body>
<!-- 상단바 -->
<div class="top">
	<div class="top_left"><a style="color:#82B6ED" href="/user/main?userId=${userId}">careerBasket</a></div>	<!-- 로고 -->
	<div class="top_middle">
		<a href="/hire/list?userId=${userId}">탐색</a>
		<a href="/resume/addresume?userId=${userId}">이력서</a>
	</div>
	<div class="top_right">
		<div class="ms">
			<span style="font-size: 13px; color: gray;">
				<span style="color:#82B6ED;">${userId}</span>
					님의 취업을 응원합니다!</span>
		</div>
		<button class="btn btn-color" style="float:left; margin-top: 15px; margin-left: 12px;">
			<a href="/user/logout">로그아웃</a>
		</button>
	</div>
</div>


로그인했을 때 메인화면 <br>
<%
	String userId = (String)session.getAttribute("userId");
%>

<!-- --------------------------메인화면-------------------------- -->
<div id="wrap">
<div class="title_wrapper">
<h1 class="resume_title">이력서 현황</h1>
<p class="text_box">- 이력서 등록은 최대 10개까지 권장드립니다.</p>
<p class="text_box">- 이력서 항목을 모두 입력 후 "이력서 저장" 버튼을 클릭하여 등록을 완료하여야 합니다.</p>
</div>
<div id="allList_wrapper">
<button type="button" class="btn btn_color btn-lg" onclick="myinsert('${userId}')">이력서 등록</button>
<!-- 저장된 이력서 목록 전체 보여주기 -->
<div class="resume_wrapper">
<div id="ms"></div>
<c:forEach var="re" items="${list}">
<div class="resume_outLine">
<button type="button" class="btn btn_color btn-sm" onclick="mydelete('${re.resumeId}', '${re.userId}')">삭제</button>
<button type="button" class="btn btn_color btn-sm" onclick="myupdate('${re.resumeId}', '${re.userId}')" style="margin-right: 2%;">수정</button>
<p class="date">${re.wDate}<p>
<p class="title"><a href="${pageContext.request.contextPath}/resume/details?userId=${userId}&resumeId=${re.resumeId}">${re.title}</a></p>
</div>
</c:forEach>
<a href="${pageContext.request.contextPath}/resume/addresume?userId=${userId}"><div class="resume_outLine" style="text-align: center; background: #82B6ED;color: #ffffff;">이력서 등록<i class="fa fa-pencil-square-o" aria-hidden="true" style="margin-left:1%;"></i></div></a>
</div>
</div>
</div>
</body>
</html>