<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detailView.jsp</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
</script>
<link rel="stylesheet" type="text/css" href="/css/imgstyle.css">
</head>
<body>
<!-- 
채용공고 상세페이지 고유 id : ${param.id}<br>
 -->

<!-- id에 해당하는 채용공고 내용 뿌려줄 부분 -->
채용공고 id : ${detail.id} <br>
회사명 : ${detail.companyName}<br>
채용공고 제목: ${detail.hireTitle}<br>
포지션 : ${detail.position}<br>
경력/신입 : ${detail.hireCareer}<br>
학력 : ${detail.education}<br>
근무 형태 : ${detail.workType}<br>
급여 : ${detail.salary}<br>
근무 지역 : ${detail.workPlace}<br>
상세 정보(이미지) : ${detail.detailImg}
<br>
<img id="info" alt="상세이미지" src="/img/detail/${detail.detailImg}">
<br>

<hr>
<h1>회사 정보</h1>
회사명 : ${company.companyName}<br>
<img class="logo" alt="회사 로고" src="http:/img/logo/${company.companyLogo}">
<br>
기업 형태 : ${company.companyType}<br>
설립일 : ${company.startDate}<br>
대표자명 : ${company.bossName}<br>
기업 주소 : ${company.companyAddress}<br>

</body>
</html>