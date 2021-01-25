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
})
</script>
<title>list.jsp</title>
</head>
<body>
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