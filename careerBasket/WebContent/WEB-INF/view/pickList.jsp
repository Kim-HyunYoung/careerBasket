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
	if("${ca}"!="[]"){
		console.log("휴..");
		var com = document.getElementById("com");
		
		com.innerHTML="<h1>경력</h1>";
		
		<c:forEach var="c" items="${ca}">
		var t = document.createElement("table");
		t.setAttribute("border", "1");
		var thead = document.createElement("thead");
		var tr = document.createElement("tr");
		var th1 = document.createElement("th");
		var th2 = document.createElement("th");
		var th3 = document.createElement("th");
		var th4 = document.createElement("th");
		
		th1.innerHTML = "근무기간";
		th2.innerHTML = "회사명";
		th3.innerHTML = "직책/직급";
		th4.innerHTML = "연봉";
		
		tr.appendChild(th1);
		tr.appendChild(th2);
		tr.appendChild(th3);
		tr.appendChild(th4);
		thead.appendChild(tr);
		t.appendChild(thead);
		
		var tbody = document.createElement("tbody");
		var tr2 = document.createElement("tr");
		var td1 = document.createElement("td");
		var td2 = document.createElement("td");
		var td3 = document.createElement("td");
		var td4 = document.createElement("td");
		
		td1.innerHTML = "${c.careerPeriod}";
		td2.innerHTML = "${c.company}";
		td3.innerHTML = "${c.careerPosition}";
		td4.innerHTML = "${c.careerSalary}";
		
		tr2.appendChild(td1);
		tr2.appendChild(td2);
		tr2.appendChild(td3);
		tr2.appendChild(td4);
		tbody.appendChild(tr2);
		
		var tr3 = document.createElement("tr");
		var th5 = document.createElement("th");
		th5.setAttribute("colspan", "4");
		
		th5.innerHTML = "경력기술서";
		
		tr3.appendChild(th5);
		tbody.appendChild(tr3);
		
		var tr4 = document.createElement("tr");
		var td5 = document.createElement("td");
		td5.setAttribute("colspan", "4");
		
		td5.innerHTML = "${c.description}";
		
		tr4.appendChild(td5);
		tbody.appendChild(tr4);
		
		t.appendChild(tbody);
		com.append(t);
		
		</c:forEach>
	}else{
		console.log("경력없음");
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
<button onclick="print()">이력서 인쇄/PDF저장</button>
<div id="print">
  <h1>${re.title }</h1>
  <hr>
  <img alt="사진을 등록하세요" src="http://localhost:8080/img/photo/${photo}" style="width:150px;height:210px;">
  <table>
  	<thead>
  		<tr>
  			<th>${si.name }</th>
  			<td>${si.birthDate.year } (${age}세)</td>
  		</tr>
  	</thead>
  	<tbody>
  		<tr>
  			<td>${si.email }</td>
  			<td>${si.tel }</td>
  		</tr>
  		<tr>
  			<td>${si.address }</td>
  		</tr>
  	</tbody>
  </table>
  <h1>학력</h1>
  <table border="1">
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
  <div id="com"></div>
  <h1>자기소개서</h1>
  <table border="1">
    <tbody>
      <tr>
        <td>${re.myinfo }</td>
      </tr>
    </tbody>
  </table>
  <h1>첨부문서</h1>
  <table >
    <tbody>
    <c:forEach var="doc" items="${doList}">
      <tr>
        <td>${doc.type}</td>
        <td>${doc.fileTitle}</td>
        <td>${doc.fileSize}</td>
      </tr>
	</c:forEach>
    </tbody>
  </table>
</div>
</body>
</html>