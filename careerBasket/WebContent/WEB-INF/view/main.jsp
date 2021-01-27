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
	if("${doList}"==null){
		$("#document").html("<section>등록된 문서가 없습니다</section>");
	}
	
	$('#target_img').click(function (e) {
	    document.signform.target_url.value = document.getElementById( 'target_img' ).src;
	    e.preventDefault();
	    $('#file').click();
	});
})
function infoUpdate(){
	var form = document.creatElement("form");
	form.setAttribute("action", "${pageContext.request.contextPath}/resume/infoUpdate")
}

function changeValue(obj){
	   document.signform.submit();
	}
</script>
<title>main.jsp</title>
<link rel="stylesheet" type="text/css" href="/css/header.css">
</head>
<body>
<div class="top">
	<div class="top_left"><a style="color:#82B6ED" href="/user/main?userId=${userId}">careerBasket</a></div>
	<div class="top_middle">
		<a href="/hire/list?userId=${userId}">탐색</a>
		<a>이력서</a>
	</div>
	<div class="top_right">
		<div calss="ms">${userId}님의 취업을 응원합니다!</div>
		<button><a href="/user/logout">로그아웃</a></button>
	</div>
</div>
로그인했을 때 메인화면 <br>
<%
	String userId = (String)session.getAttribute("userId");
%>

<div>
<div>
    <img id = "target_img"  src="" style="width:150px;height:210px;">
</div>
<form name="signform" method="POST" ENCTYPE="multipart/form-data" action="/resume/photoUpdate">
    <input type="file" id="file" name="file" style="display:none;" onchange="changeValue(this)">
    <input type="hidden" name = "target_url">
</form>
${info.name }<br>
${info.email }<br>
${info.tel }<br>
<button type="button" onclik="infoUpdate()">기본정보 수정</button>
<button><a href="/user/logout">로그아웃</a></button>
</div>
<div><a href="http://localhost:8080/hire/applyInfo?userId=${userId}">지원현황: ${applyCnt}</a></div>
<div>등록된 이력서: ${count}</div>
<div>
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

<div>
<c:forEach var="doc" items="${doList}">
<section id="document">
${doc.type}
${doc.fileTitle}
</section>
</c:forEach>
</div>
<form action="${pageContext.request.contextPath}/resume/documentList?userId=${userId}" method="get">
<input type="hidden" name="userId" value="${userId }">
<button>전체보기</button>
</form>
</body>
</html>