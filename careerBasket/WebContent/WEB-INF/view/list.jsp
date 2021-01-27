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
<title>list.jsp</title>
</head>
<body>
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
<button type="button" onclik="logOut()">로그아웃</button>
</div>
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
<form action="${pageContext.request.contextPath}/resume/documentList" method="get">
<button>전체보기</button>
</form>
</body>
</html>