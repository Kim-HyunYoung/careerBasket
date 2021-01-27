<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>applyListView.jsp</title>
</head>
<body>
	<!-- 지원 현황 테이블 -->
	<table border="1">
		<thead>
			<tr>
				<th>지원일</th>
				<th>지원 회사</th>
				<th>공고명/지원분야</th>
				<th>지원 제목</th>
				<th>마감일</th>
			</tr>			
		</thead>
		<tbody>
			<c:forEach var="apply" items="${applyList}">
			<tr>
				<td>
					<fmt:parseDate var="applyDate" value="${apply.applyDate}"
						pattern="yyyy-MM-dd'T'HH:mm" />
					<fmt:formatDate value="${applyDate}" pattern="yyyy-MM-dd HH:mm:ss" />
				</td>
				<td>${apply.companyName}</td>
				<td>${apply.hireTitle}</td>
				<td>${apply.title}</td>
				<td>
					<fmt:parseDate var="endDate" value="${apply.endDate}"
						pattern="yyyy-MM-dd'T'HH:mm" />
					<fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd HH:mm:ss" />
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	
</body>
</html>