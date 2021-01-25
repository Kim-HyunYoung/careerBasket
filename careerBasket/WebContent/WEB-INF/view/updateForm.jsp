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
	if("${re.finalEducation}"!=null){
		$("input[value='${re.finalEducation}']").prop("checked", true);
	}
	if("${re.career}"!=null){
		$("input[value=${re.career}]").prop("checked", true);
	}
	if("${re.state}"!=null){
		if("${re.state}"==$("input[name=state]").val()){
			$("input[name=state]").prop("checked", true);
			$("input[name=educationName]").prop("disabled", true);
			$("input[name=period]").prop("disabled", true);
			$("input[name=major]").prop("disabled", true);
			$("input[name=score]").prop("disabled", true);
			$("input[name=basicScore]").prop("disabled", true); 
		}else{
			$("select[name=state]").val("${re.state}").prop("selected", true);
		}
	}
	if("${ca}"!=""){
		<c:forEach var="c" items="${ca}">
		var com = document.getElementById("com");
	 	 
	 	 //타이틀 삽입
	 	  var h = document.createElement("h2");
	 	  h.innerHTML="경력";
	 	 com.append(h);
	 	  
	 	  //fieldset 삽입
	 	  var f = document.createElement("fieldset");
	 	  com.append(f);
	 	  
	 	  var h5 = document.createElement("h5");
	 	  h5.innerHTML="회사 정보 입력"
	 	  f.append(h5);
	 	  
	 	  var sec = document.createElement("section");
	 	  f.append(sec);
	 	  
	 	  sec.innerHTML="회사명: ";
	 	  
	 	  var input = document.createElement("input");
	 	  input.setAttribute("type", "text");
	 	  input.setAttribute("name", "company");
	 	 input.setAttribute("value", "${c.company}");
	 	  sec.append(input);
	 	  
	 	 var sec2 = document.createElement("section");
		  f.append(sec2);
	 	  
	 	  sec2.innerHTML="재직기간: ";
	 	  
	 	  var input2 = document.createElement("input");
		  input2.setAttribute("type", "text");
		  input2.setAttribute("name", "careerPeriod");
		  input2.setAttribute("placeholder", "예시)2016-03-02~2020-02-09");
		  input2.setAttribute("value", "${c.careerPeriod}");
		  sec2.append(input2);
		  
		  var sec3 = document.createElement("section");
		  f.append(sec3);
	 	  
	 	  sec3.innerHTML="직책: ";
	 	  
	 	  var input3 = document.createElement("input");
		  input3.setAttribute("type", "text");
		  input3.setAttribute("name", "position");
		  input3.setAttribute("value", "${c.careerPosition}");
		  sec3.append(input3);
		  
		  var sec4 = document.createElement("section");
		  f.append(sec4);
	 	  
	 	  sec4.innerHTML="연봉: ";
	 	  
	 	  var input4 = document.createElement("input");
		  input4.setAttribute("type", "number");
		  input4.setAttribute("name", "salary");
		  input4.setAttribute("value", "${c.careerSalary}");
		  sec4.append(input4);
		  
		  var sec5 = document.createElement("section");
		  f.append(sec5);
	 	  
	 	  sec5.innerHTML="직무기술서: ";
	 	  
	 	  var input5 = document.createElement("input");
		  input5.setAttribute("type", "text");
		  input5.setAttribute("name", "description");
		  input5.setAttribute("value", "${c.description}");
		  sec5.append(input5);
		  
		  var input6 = document.createElement("input");
		  input6.setAttribute("type", "hidden");
		  input6.setAttribute("name", "careerId");
		  input6.setAttribute("value", "${c.careerId}");
		  sec5.append(input6);
	 	  
		  f.append(document.createElement("hr"));
		  
		  var button = document.createElement("input");
		  button.setAttribute("type", "button");
		  button.setAttribute("value", "+경력추가");
		  button.setAttribute("onclick", "addCareer()");
		  f.append(button);
		  
		  var button2 = document.createElement("input");
		  button2.setAttribute("type", "button");
		  button2.setAttribute("value", "-삭제");
		  button2.setAttribute("onclick", "del()");
		  f.append(button2);
		  </c:forEach>
	}
})
function check(){
	if($("input[type=checkbox]").is(":checked") == true){
		$("input[name=educationName]").val(""); 
		$("input[name=period]").val(""); 
		$("input[name=major]").val(""); 
		$("input[name=score]").val(""); 
		$("input[name=basicScore]").val(""); 
		$("select[name=state]").val("");
  		$("input[name=educationName]").prop("disabled", true);
		$("input[name=period]").prop("disabled", true);
		$("input[name=major]").prop("disabled", true);
		$("input[name=score]").prop("disabled", true);
		$("input[name=basicScore]").prop("disabled", true); 
	}else{
 		$("input[name=educationName]").prop("disabled", false);
		$("input[name=period]").prop("disabled", false);
		$("input[name=major]").prop("disabled", false);
		$("input[name=score]").prop("disabled", false);
		$("input[name=basicScore]").prop("disabled", false);
		$("select[name=state]").prop("disabled", false);
	}
}
 function addCareer(){
	 /* //실행되면 확인
	 console.log("휴.."); */
 	 var com = document.getElementById("com");
 	 
 	 //타이틀 삽입
 	  var h = document.createElement("h2");
 	  h.innerHTML="경력";
 	 com.append(h);
 	  
 	  //fieldset 삽입
 	  var f = document.createElement("fieldset");
 	  com.append(f);
 	  
 	  var h5 = document.createElement("h5");
 	  h5.innerHTML="회사 정보 입력"
 	  f.append(h5);
 	  
 	  var sec = document.createElement("section");
 	  f.append(sec);
 	  
 	  sec.innerHTML="회사명: ";
 	  
 	  var input = document.createElement("input");
 	  input.setAttribute("type", "text");
 	  input.setAttribute("name", "company");
 	  sec.append(input);
 	  
 	 var sec2 = document.createElement("section");
	  f.append(sec2);
 	  
 	  sec2.innerHTML="재직기간: ";
 	  
 	  var input2 = document.createElement("input");
	  input2.setAttribute("type", "text");
	  input2.setAttribute("name", "careerPeriod");
	  input2.setAttribute("placeholder", "예시)2016-03-02~2020-02-09");
	  sec2.append(input2);
	  
	  var sec3 = document.createElement("section");
	  f.append(sec3);
 	  
 	  sec3.innerHTML="직책: ";
 	  
 	  var input3 = document.createElement("input");
	  input3.setAttribute("type", "text");
	  input3.setAttribute("name", "careerPosition");
	  sec3.append(input3);
	  
	  var sec4 = document.createElement("section");
	  f.append(sec4);
 	  
 	  sec4.innerHTML="연봉: ";
 	  
 	  var input4 = document.createElement("input");
	  input4.setAttribute("type", "number");
	  input4.setAttribute("name", "careerSalary");
	  sec4.append(input4);
	  
	  var sec5 = document.createElement("section");
	  f.append(sec5);
 	  
 	  sec5.innerHTML="직무기술서: ";
 	  
 	  var input5 = document.createElement("input");
	  input5.setAttribute("type", "text");
	  input5.setAttribute("name", "description");
	  sec5.append(input5);
	  
	  var input6 = document.createElement("input");
	  input6.setAttribute("type", "hidden");
	  input6.setAttribute("name", "careerId");
	  input6.setAttribute("value", "0");
	  sec5.append(input6);
 	  
	  f.append(document.createElement("hr"));
	  
	  var button = document.createElement("input");
	  button.setAttribute("type", "button");
	  button.setAttribute("value", "+경력추가");
	  button.setAttribute("onclick", "addCareer()");
	  f.append(button);
	  
	  var button2 = document.createElement("input");
	  button2.setAttribute("type", "button");
	  button2.setAttribute("value", "-삭제");
	  button2.setAttribute("onclick", "del()");
	  f.append(button2);
 }
 function del(){
	 var com = document.getElementById("com");
	 while ( com.hasChildNodes() ){
		 com.removeChild( com.firstChild ); 
		 }
 }
</script>
<title>updateForm.jsp</title>
</head>
<body>
<form action="/resume/update" method="post">
<input type="submit" value="이력서 저장">
<input type="text" name="title" placeholder="이력서의 제목을 적어주세요" value="${re.title }">
<h2>기본정보</h2>
<fieldset>
<h5>기본정보 수정은 마이페이지 기본정보 수정페이지에서 가능합니다</h5>
<button type="button" >기본정보 수정하기</button><br>
<input type="hidden" name="userId" value="${si.userId }">
<input type="hidden" name="resumeId" value="${re.resumeId }">
이름: <input type="text" name="name" readonly="readonly" value="${si.name }"><br>
생년월일: <input type="date" name="birth_date" readonly="readonly" value="${si.birthDate }"><br>
이메일: <input type="email" name="email" readonly="readonly" value="${si.email }"><br>
전화번호: <input type="tel" name="tel" readonly="readonly" value="${si.tel }"><br>
주소: <input type="text" name="address" readonly="readonly" value="${si.address }"><br>
<hr>
</fieldset>
<h2>학력정보</h2>
<fieldset>
<label><input type="radio" name="finalEducation" value="초등학교">초등학교</label>
<label><input type="radio" name="finalEducation" value="중학교">중학교</label>
<label><input type="radio" name="finalEducation" value="고등학교">고등학교</label>
<label><input type="radio" name="finalEducation" value="대학교/대학원">대학교/대학원</label>
<hr>
<h5>학교정보입력</h5>
<label><input type="checkbox" name="state" onclick="check()" value="검정고시">검정고시</label><br>
학교명: <input type="text" name="educationName" value="${re.educationName }"><br>
재학기간: <input type="text" name="period" placeholder="예시)2016-03-02~2020-02-09" value="${re.period }">
<select name="state">
    <option value="">상태</option>
    <option value="재학">재학</option>
    <option value="졸업">졸업</option>
    <option value="휴학">휴학</option>
    <option value="중퇴">중퇴</option>
</select><br>
전공: <input type="text" name="major" value="${re.major }"><br>
학점: <input type="text" name="score" placeholder="평균학점 예시)3.9" value="${re.score }">
<input type="text" name="basicScore" placeholder="기준학점 예시)4.5" value="${re.basicScore }">
</fieldset>
<h2>경력선택</h2>
<fieldset>
<label><input type="radio" name="career" value="신입">신입</label>
<label><input type="radio" name="career" value="경력">경력</label>
<hr>
<button type="button" onclick="addCareer()">+경력추가</button>
</fieldset>
<section id="com"></section>
<h2>자기소개서</h2>
<fieldset>
<input type="text" name="myinfo" placeholder="자유양식" value="${re.myinfo }">
</fieldset>
<h2>기타서류</h2>
<fieldset>
<h5>첨부파일선택</h5>
</fieldset>
<input type="submit" value="이력서 저장">
</form>
</body>
</html>