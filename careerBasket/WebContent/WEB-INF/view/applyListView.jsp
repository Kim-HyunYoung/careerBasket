<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>applyListView.jsp</title>

<!-- 부트스트랩 버전 3으로 해야 select 잘 적용됨 
	-->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
	integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu"
	crossorigin="anonymous">

<!-- 부트스트랩 select css -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/css/bootstrap-select.min.css">

<!-- ajax CDN -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- query스크립트는 부트스트랩 스크립드 위에 넣어줘야해 -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<!-- select보다 부트스트랩이 더 먼저와야함 -->
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"
	integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd"
	crossorigin="anonymous"></script>
<!-- 부트스트랩 select 스크립트 -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/js/bootstrap-select.min.js"></script>

<link rel="stylesheet" type="text/css" href="/css/header.css">

<script type="text/javascript">
	/*
	$(function() {
		if ("${applyList}" == "[]") {
			$("body").html("<div>아직 지원한 회사가 없습니다.</div>");
		}
	})
	 */
</script>
</head>
<body>

	<!-- 로그아웃일 때 상단바 -->
	<div class="top">
		<c:if test="${empty userId}">
			<div class="top_left">
				<a href="/user/logout" style="color: #82B6ED">careerBasket</a>
			</div>
			<div class="top_middle">
				<a href="/hire/list">탐색</a> <a href="/user/loginForm">이력서</a>
			</div>
			<div class="top_right">
				<button class="btn btn-color">
					<a href="/user/signup">회원가입</a>
				</button>
				<button class="btn btn-color">
					<a href="/user/loginForm">로그인</a>
				</button>
			</div>
		</c:if>
		<!-- 로그인일 때 상단바 -->
		<c:if test="${not empty userId}">
			<div class="top_left">
				<a style="color: #82B6ED" href="/user/main?userId=${userId}">careerBasket</a>
			</div>
			<!-- 로고 -->
			<div class="top_middle">
				<a href="/hire/list?userId=${userId}">탐색</a> <a
					href="/resume/addresume?userId=${userId}">이력서</a>
			</div>
			<div class="top_right">
				<div class="ms">${userId}님의취업을응원합니다!</div>
				<button class="logOut">
					<a href="/user/logout">로그아웃</a>
				</button>
			</div>
		</c:if>
	</div>
	<!-- //상단바 -->

	<c:if test="${empty applyList}">
		<div
			style="background-color: #f2f3f5; border-radius: 15px; width: 500px; height: 200px; /* margin: 155px; */ margin-top: 200px; margin-left: -250px; left: 50%; position: absolute; text-align: center;">
			<div>
				<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50"
					fill="red" class="bi bi-file-earmark-x" viewBox="0 0 16 16"
					style="top: 45px; position: relative;">
				  <path d="M6.854 7.146a.5.5 0 1 0-.708.708L7.293 9l-1.147 1.146a.5.5 0 0 0 .708.708L8 9.707l1.146 1.147a.5.5 0 0 0 .708-.708L8.707 9l1.147-1.146a.5.5 0 0 0-.708-.708L8 8.293 6.854 7.146z" />
				  <path d="M14 14V4.5L9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2zM9.5 3A1.5 1.5 0 0 0 11 4.5h2V14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h5.5v2z" />
				</svg>
			</div>
			<div style="height: 200px; top: 80px; position: relative;">
			아직 지원한 회사가 없습니다.</div>
		</div>

	</c:if>

	<c:if test="${not empty applyList}">


		<div style="position: absolute;/* margin: 72px; */width: 920px;left: 50%;margin-left: -490px;margin-top: 100px;">
			<!-- 지원 현황 테이블 -->
			<table class="table table-sm" style="margin: 40px;">
				<thead style="font-weight: 500; color: #82B6ED">
					<tr>
						<th scope="col">지원일</th>
						<th scope="col">지원 회사</th>
						<th scope="col">공고명/지원분야</th>
						<th scope="col">지원 제목</th>
						<th scope="col">마감일</th>
					</tr>
				</thead>
				<tbody style="font-size: smaller;">
					<c:forEach var="apply" items="${applyList}">
						<tr>
							<td><fmt:parseDate var="applyDate"
									value="${apply.applyDate}" pattern="yyyy-MM-dd'T'HH:mm" /> <fmt:formatDate
									value="${applyDate}" pattern="yyyy-MM-dd" /></td>
							<td>${apply.companyName}</td>
							<td>${apply.hireTitle}</td>
							<td>${apply.title}</td>
							<td><fmt:parseDate var="endDate" value="${apply.endDate}"
									pattern="yyyy-MM-dd'T'HH:mm" /> <fmt:formatDate
									value="${endDate}" pattern="yyyy-MM-dd" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

	</c:if>


</body>
</html>