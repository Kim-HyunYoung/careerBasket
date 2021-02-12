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
		$("#document").html("<div class='none-text'>등록된 문서가 없습니다</div>");
	}
	if("${list}"=="[]"){
		$("#resume").html("<div class='none-text'>등록된 이력서가 없습니다</div>")
	}
	if("${info.photoPath}"==""){
		$("#photo").attr("src", "http://localhost:8080/photo/image.png")
	}
})

function fileUpload(userId){	
	
		var files = document.querySelector("input[type=file]").files;
		console.dir(files);
		console.log(userId);
		
		//file을 전송하기 위해 FormData라는 객체에 넣어야한다
		var formData = new FormData();
		
		//폼에 보낼 내용을 추가
		for(file of files){
			console.dir(file);
			formData.append("files",file);
		}
		
			formData.append("userId", userId);
		
		//비동기로 파일을 서버로 보냄
		$.ajax({
			url:"/resume/photoUpdate",
			processData: false,//쿼리스트링으로 보내지는 방식을 사용하지 않겠다
			contentType: false,//"multipart/form-data"로 보내기 위함
			data: formData,//보낼 데이타
			type: "post",//보내는 방식
			success: function(result){
				console.log(result)
			},
			error: function(e){
				console.log(e)
			}
		})
}

</script>
<title>main.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">

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

<div id="wrap">
	<div class="fs-4 title">MY BASKET</div>
	<div class="info-wrap">
			<div><label for="input-file"><img src="/photo/${info.photoPath}" style="width: 100px;height: 120px;object-fit:contain;" id="photo"></label></div>
		    <input type="file" id="input-file" name="file" style="display:none;" multiple accept=".jpg, .png">
		    <button onclick="fileUpload('${userId}')" class="btn btn-outline-primary btn-sm btn-photo">사진저장</button>
		<p class="info-name fw-bold">${info.name }</p>
		<p class="info-email fw-light">${info.email }</p>
		<p class="info-tel fw-light">${info.tel }</p>
		<a href="${pageContext.request.contextPath}/resume/infoUpdateForm?userId=${userId}"><button type="button" class="btn btn-outline-primary btn-info-update">기본정보 수정</button></a>
	</div>
	<div class="logout-wrap">
		<a href="/user/logout" style="color:#82B6ED;">로그아웃</a>
	</div>
	<div class="board-wrap">
		<ul class="top-list">
			<li style="margin-left: 1rem;font-size: 12px;"><a href="http://localhost:8080/hire/applyInfo?userId=${userId}" style="color: white;">지원현황<span class="count">${applyCnt}</span></a></li>
			<li style="margin-left: 2rem;font-size: 12px;">등록된 이력서<span class="count">${count}</span></li>
			<li style="margin-left: 6.27rem;"><a href="${pageContext.request.contextPath}/resume/addresume?userId=${userId}"><button type="button" class="btn btn-outline-primary btn-sm btn-adrm">이력서 등록</button></a></li>
		</ul>
		<div class="resume-borad">
			<div class="resume-wrap">
				<div class="sub-title-font">등록된 이력서</div>
				<div class="all-list-bnt"><a href="${pageContext.request.contextPath}/resume/listAll?userId=${userId}">전체보기</a></div>
				<div id="resume">
				<c:forEach var="re" items="${list}">
					<div class="detail-t-tp">${re.wDate}</div>
					<div class="detail-t-bt">${re.title}</div>
				</c:forEach>
				</div>
			</div>
		<div class="doc-wrap">
			<div class="sub-title-font">업로드한 기타문서</div>
				<div class="all-list-bnt"><a href="${pageContext.request.contextPath}/resume/documentList?userId=${userId}">전체보기</a></div>
				<div id="document">
				<c:forEach var="doc" items="${doList}">
					<div class="detail-t-tp">${doc.type}</div>
					<div class="detail-t-bt">${doc.fileTitle}</div>
				</c:forEach>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>