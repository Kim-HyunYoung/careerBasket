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
	if("${doList}"=="[]"){
		$("#document").html("<section>등록된 문서가 없습니다</section>");
	}
	if("${list}"=="[]"){
		$("#resume").html("<section>등록된 이력서가 없습니다</section>")
	}
	
	$('#btn-upload').click(function (e) {
	    e.preventDefault();
	    $('#file').click();
	});
})
function infoUpdate(userId){
	console.log("onclick메서드 실행!");
	var form = document.creatElement("form");
	form.setAttribute("action", "${pageContext.request.contextPath}/resume/infoUpdateForm");
	form.setAttribute("method", "get");
	form.setAttribute("value", userId);
	form.submit();
}

function changeValue(obj){
	document.signform.submit();
	}
</script>
<title>main.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/css/header.css">
<link rel="stylesheet" type="text/css" href="/css/main.css">
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
		<div class="ms">${userId}님의 취업을 응원합니다!</div>
		<button class="logOut"><a href="/user/logout">로그아웃</a></button>
	</div>
</div>

로그인했을 때 메인화면 <br>
<%
	String userId = (String)session.getAttribute("userId");
%>

<div id="wrap">
<div>
<form name="signform" method="POST" ENCTYPE="multipart/form-data" action="/resume/photoUpdate">
    <input type="file" id="file" name="file" style="display:none;" onchange="changeValue(this)">
    <button style="border: none;outline: none;background: none;" id="btn-upload"><img src="<%-- http://localhost:8080/img/photo/${photo} --%>" style="width:150px;height:210px;"></button>
</form>
${info.name }<br>
${info.email }<br>
${info.tel }<br>
<a href="${pageContext.request.contextPath}/resume/infoUpdateForm?userId=${userId}"><button type="button">기본정보 수정</button></a>
<button><a href="/user/logout">로그아웃</a></button>
</div>
<div><a href="http://localhost:8080/hire/applyInfo?userId=${userId}">지원현황: ${applyCnt}</a></div>
<div>등록된 이력서: ${count}</div>
<div id="resume">
<c:forEach var="re" items="${list}">
<section>
${re.title}
${re.wDate}
</section>
</c:forEach>
</div>
<form action="${pageContext.request.contextPath}/resume/listAll" method="get">
<input type="hidden" name="userId" value="${userId}">
<button>전체보기</button>
</form>

<div id="document">
<c:forEach var="doc" items="${doList}">
<section>
${doc.type}
${doc.fileTitle}
</section>
</c:forEach>
</div>
<form action="${pageContext.request.contextPath}/resume/documentList?userId=${userId}" method="get">
<input type="hidden" name="userId" value="${userId }">
<button>전체보기</button>
</form>
</div>
</body>
</html>