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
	if("${ca}"=="[]"){
		console.log("경력이 빈값이다!");
		$("#com").html("");
		
	}
	if("${doList}"==""){
		console.log("저장한 첨부파일이 없다!");
		$("#doc").html("");
	}
	
})
function print(){
	const _tempHTML = document.getElementById("print").innerHTML;
	  const innerHTMLs = "<div class='printWrap' style='width:21cm; height: 29.7cm;'>" + _tempHTML + "</div>"; 
	  const popupWindow = window.open("", "_blank", "width=700,height=800");
	  popupWindow.document.write("<!DOCTYPE html>"+
				      "<html>"+
				        "<head>"+
				        	"<style type='text/css'>"+
				        		".endline{page-break-before:always}"+
				        	"</style>"+
				        	"<style type='text/css' media='print'>"+
					    		"@page {"+
					    		    "size: auto;  /* auto is the initial value */"+
					    		    "margin: 0px 100px 0px 100px;  /* this affects the margin in the printer settings */"+
					    		"}"+
					    	"</style>"+
				        "</head>"+
				        "<body>"+innerHTMLs+"</body>"+
				      "</html>");
	  popupWindow.document.close();
		popupWindow.focus();
	  //1초후 새 창 프린트
	  window.setTimeout(function () {
		 	popupWindow.print();
		 	popupWindow.close();
		}, 1000);
}
</script>
<title>pickList.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="/css/pickList.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400&display=swap" rel="stylesheet">
</head>
<body>
<div id="wrapper">
<div class="print_btn">
<div class="wdate">등록한 날짜: ${re.wDate}</div>
<a href="${pageContext.request.contextPath}/resume/update?userId=${si.userId}&resumeId=${re.resumeId}"><div class="rm-up">이력서 수정</div></a>
<button onclick="print()" class="btn btn-color btn-print">이력서 인쇄/PDF저장</button>
</div>
<div id="print">
  <h1 class="detail_title">${re.title }</h1>
  <hr>
<div class="mainInfo">
  <img alt="사진을 등록하세요" src="<%-- http://localhost:8080/img/photo/${photo} --%>" id="photo">
  <div class="text_start_wrap wd-tp">
  <p  class="text-start fw-bold fs-5">${si.name }<span class="text-center fs-6">${si.birthDate.year } (${age}세)</span></p>
  <p  class="text-start fs-6">${si.email }<span class="text-center fs-6">${si.tel }</span></p>
  <p  class="text-start fs-6 wd-bt">${si.address }</p>
  </div>
</div>
<!-- -----------------------------------------학력----------------------------------------------------- -->
<div class="edu_box mg-bt">
  <div class="fs-3">학력</div>
  <table class="table table-bordered">
  	<thead>
      <tr>
      	<th>최종학력</th>
        <th>재학기간</th>
        <th>구분</th>
        <th>학교명</th>
        <th>전공</th>
        <th>학점(평균학점/기준학점)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
      	<td>${re.finalEducation }</td>
        <td>${re.period }</td>
        <td>${re.state }</td>
        <td>${re.educationName }</td>
        <td>${re.major }</td>
        <td>${re.score }/${re.basicScore }</td>
      </tr>
    </tbody>
  </table>
</div>
<!-- -------------------------------------------경력--------------------------------------------------- -->	
<div id="com" class="mg-bt">
	<div class="fs-3">경력</div>
<c:forEach var="c" items="${ca}">
  <table class="table table-bordered">
  	<thead>
      <tr>
      	<th>근무기간</th>
        <th>회사명</th>
        <th>직책/직급</th>
        <th>연봉</th>
      </tr>
    </thead>
    <tbody>
      <tr>
      	<td>${c.careerPeriod}</td>
        <td>${c.company}</td>
        <td>${c.careerPosition}</td>
        <td>${c.careerSalary}</td>
      </tr>
      <tr class="tr-col">
      	<th colspan="4">경력기술서</th>
      </tr>
      <tr>
      	<td colspan="4">${c.description}</td>
      </tr>
    </tbody>
  </table>
</c:forEach>
</div>
<!-- -------------------------------------------자기소개서--------------------------------------------------- -->	
<div class="mg-bt">
 <div class="fs-3">자기소개서</div>
  <div class="info lh-lg">${re.myinfo }</div>
</div>
<!-- -------------------------------------------기타문서--------------------------------------------------- -->	
<div id="doc" class="mg-bt">
  <div class="fs-3">첨부문서</div>
<div class="outLine">
    <c:forEach var="doc" items="${doList}">
      <div class="inLine">
        <span class="doc-type">${doc.type}</span>
        <span class="doc-file-title">${doc.fileTitle}</span>
        <span class="doc-file-size">${doc.fileSize}</span>
        <span class="doc-file-wdate">${doc.wDate}</span>
      </div>
	</c:forEach>
</div>
</div>
</div>
</div>
</body>
</html>