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
	if("${ca}"!=null){
		console.log("휴..");
		var com = document.getElementById("com");
		
		com.innerHTML="<h1>경력</h1>";
		
		var t = document.createElement("table");
		var thead = documnet.createElement("thead");
		var tr = documnet.createElement("tr");
		var th1 = documnet.createElement("th");
		var th2 = documnet.createElement("th");
		var th3 = documnet.createElement("th");
		var th4 = documnet.createElement("th");
		
		t.style.border = "1";
		
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
		
		var tbody = documnet.createElement("tbody");
		var tr2 = documnet.createElement("tr");
		var td = documnet.createElement("td");
		
		td.innerHTML = "${ca[0].careerPeriod}";
		td.innerHTML = "${ca[0].company}";
		td.innerHTML = "${ca[0].position}";
		td.innerHTML = "${ca[0].salary}";
		
		tr2.appendChild(td);
		tbody.appendChild(tr2);
		t.appendChild(tbody);
	}else{
		console.log("경력없음");
	}
	
})
</script>
<title>pickList.jsp</title>
</head>
<body>
  <h1>${re.title }</h1>
  <hr>
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
        <th>재학기간</th>
        <th>구분</th>
        <th>학교명</th>
        <th>전공</th>
        <th>학점(평균학점/기준학점)</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>${re.period }</td>
        <td>${re.state }</td>
        <td>${re.educationName }</td>
        <td>${re.major }</td>
        <td>${re.score }/${re.basicScore }</td>
      </tr>
    </tbody>
  </table>
  <section id="com"></section>
  <%-- <h1>경력</h1>
  <table border="1">
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
        <td>${ca.careerPeriod }</td>
        <td>${ca.company }</td>
        <td>${ca.position }</td>
        <td>${ca.salary }</td>
      </tr>
      <tr>
        <th colspan="4">경력기술서</th>
      </tr>
      <tr>
        <td colspan="4">${ca.description }</td>
      </tr>
    </tbody>
  </table> --%>
  <h1>자기소개서</h1>
  <table border="1">
    <tbody>
      <tr>
        <td>${re.myinfo }</td>
      </tr>
    </tbody>
  </table>
  <h1>첨부문서</h1>
  <table border="1">
    <tbody>
      <tr>
        <td>{do.type}</td>
      </tr>
      <tr>
        <td>{do.type}</td>
      </tr>
      <tr>
        <td>{do.type}</td>
      </tr>
    </tbody>
  </table>
  </body>
</html>