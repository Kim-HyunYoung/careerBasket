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
	if("${re.finalEducation}"!=""){
		$("input[value='${re.finalEducation}']").prop("checked", true);
	}
	if("${re.career}"!=""){
		$("input[value=${re.career}]").prop("checked", true);
	}
	if("${re.state}"!=""){
		if("${re.state}"=="검정고시"){
			$("input[name=state]").prop("checked", true);
			$("select[name=state]").val("검정고시");
			$("input[name=educationName]").prop("disabled", true);
			$("input[name=period]").prop("disabled", true);
			$("input[name=major]").prop("disabled", true);
			$("input[name=score]").prop("disabled", true);
			$("input[name=basicScore]").prop("disabled", true); 
		}else{
			$("select[name=state]").val("${re.state}");
			$("input[name=educationName]").val("${re.educationName}");
			$("input[name=period]").val("${re.period}");
			$("input[name=major]").val("${re.major}");
			$("input[name=score]").val("${re.score}");
			$("input[name=basicScore]").val("${re.basicScore}");
		}
	}
	if("${ca}"!=""){
		<c:forEach var="c" items="${ca}">
		var com = document.getElementById("com");
		
		$("#com").append("<h1 class='title'>경력</h1>");
		 $("#com").append("<div class='info_wrapper' style='padding-bottom: 6%;'>"
				 +"<p class='ed_title'>회사 정보 입력</p>"
				 +"<div class='row'><label for='colFormLabel' class='col-sm-2 col-form-label'>회사명</label>"
				 +"<div class='col-sm-10'><input type='text' name='company' class='colFormLabel2' id='colFormLabel' value='${c.company}'></div></div>"
				 +"<div class='row'><label for='colFormLabel' class='col-sm-2 col-form-label'>재직기간</label>"
				 +"<div class='col-sm-10'><input type='text' name='careerPeriod' value='${c.careerPeriod}' placeholder=' 예시)2016-03-02~2020-02-09' class='colFormLabel2' id='colFormLabel'></div></div>"
				 +"<div class='row'><label for='colFormLabel' class='col-sm-2 col-form-label'>직책</label>"
				 +"<div class='col-sm-10'><input type='text' name='careerPosition' value='${c.careerPosition}' class='colFormLabel2' id='colFormLabel'></div></div>"
				 +"<div class='row'><label for='colFormLabel' class='col-sm-2 col-form-label'>연봉</label>"
				 +"<div class='col-sm-10'><input type='text' name='careerSalary' value='${c.careerSalary}' class='colFormLabel2' id='colFormLabel'></div></div>"
				 +"<div class='form-floating'>"
				 +"<textarea name='description' class='form-control' id='floatingTextarea2' style='height: 100px;margin: 1%;'>${c.description}</textarea>"
				 +"<label for='floatingTextarea2' style='margin: 1%;'>직무기술서</label></div>"
				 +"<input type='hidden' name='careerId' value='${c.careerId}'>"
				 +"<button type='button' onclick='addCareer()' class='btn btn-color btn-sm'>+경력추가</button>"
				 +"<button type='button' onclick='del()' class='btn btn-color btn-sm' style='margin-right: 2%;'>-삭제</button>"
				 +"</div>");
		  </c:forEach>
	}
	if("${docSel}"!="[]"){
		<c:forEach var="doc" items="${docSel}">
		$("input[value=${doc.documentId}]").prop("checked", true);
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
		$("select[name=state]").val("검정고시");
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
 	 
 	$("#com").append("<h1 class='title'>경력</h1>");
	 $("#com").append("<div class='info_wrapper' style='padding-bottom: 6%;'>"
			 +"<p class='ed_title'>회사 정보 입력</p>"
			 +"<div class='row'><label for='colFormLabel' class='col-sm-2 col-form-label'>회사명</label>"
			 +"<div class='col-sm-10'><input type='text' name='company' class='colFormLabel2' id='colFormLabel'></div></div>"
			 +"<div class='row'><label for='colFormLabel' class='col-sm-2 col-form-label'>재직기간</label>"
			 +"<div class='col-sm-10'><input type='text' name='careerPeriod' placeholder=' 예시)2016-03-02~2020-02-09' class='colFormLabel2' id='colFormLabel'></div></div>"
			 +"<div class='row'><label for='colFormLabel' class='col-sm-2 col-form-label'>직책</label>"
			 +"<div class='col-sm-10'><input type='text' name='careerPosition' class='colFormLabel2' id='colFormLabel'></div></div>"
			 +"<div class='row'><label for='colFormLabel' class='col-sm-2 col-form-label'>연봉</label>"
			 +"<div class='col-sm-10'><input type='text' name='careerSalary' class='colFormLabel2' id='colFormLabel'></div></div>"
			 +"<div class='form-floating'>"
			 +"<textarea name='description' class='form-control' id='floatingTextarea2' style='height: 100px;margin: 1%;'></textarea>"
			 +"<label for='floatingTextarea2' style='margin: 1%;'>직무기술서</label></div>"
			 +"<button type='button' onclick='addCareer()' class='btn btn-color btn-sm'>+경력추가</button>"
			 +"<button type='button' onclick='del()' class='btn btn-color btn-sm' style='margin-right: 2%;'>-삭제</button>"
			 +"</div>");
 }
 function del(){
	 var com = document.getElementById("com");
	 com.removeChild( com.firstChild ); 
	 com.removeChild( com.firstChild );
 }
</script>
<title>updateForm.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="/css/resumeUpdateForm.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400&display=swap" rel="stylesheet">
</head>
<body>
<div id="resume_form_wrapper">
<form action="/resume/update" method="post">
	<input type="text" name="title" placeholder="이력서의 제목을 적어주세요(필수)" value="${re.title }" style="width:600px;margin-top: 0.3%" required="required">
    <input type="submit" class="btn btn-color btn-sm"  value="이력서 저장">
<h1 class="title">기본정보</h1>
<div class="info_wrapper">
<img alt="사진을 등록하세요" src=""  style="width:100px;height:140px;float:right;margin-bottom: 5%;" class="img-thumbnail">
<p class="ms">기본정보 수정은 마이페이지 기본정보 수정페이지에서 가능합니다</p>
<input type="hidden" name="userId" value="${si.userId }">
<div class="row">
  <label for="colFormLabel" class="col-sm-2 col-form-label">이름</label>
  <div class="col-sm-10">
    <input type="text" name="name" class="colFormLabel" id="colFormLabel" readonly="readonly" value="${si.name }">
  </div>
</div>
<div class="row">
  <label for="colFormLabel" class="col-sm-2 col-form-label">생년월일</label>
  <div class="col-sm-10">
    <input type="date" name="birth_date" class="colFormLabel" id="colFormLabel" readonly="readonly" value="${si.birthDate }">
  </div>
</div>
<div class="row">
  <label for="colFormLabel" class="col-sm-2 col-form-label">이메일</label>
  <div class="col-sm-10">
    <input type="text" name="email" class="colFormLabel" id="colFormLabel" readonly="readonly" value="${si.email }">
  </div>
</div>
<div class="row">
  <label for="colFormLabel" class="col-sm-2 col-form-label">주소</label>
  <div class="col-sm-10">
    <input type="text" name="address" class="colFormLabel" style="width: 500px;" id="colFormLabel" readonly="readonly" value="${si.address }">
  </div>
</div>
<hr>
<a href="${pageContext.request.contextPath}/resume/infoUpdateForm?userId=${si.userId}"><button type="button" class="btn btn-color btn-sm" >기본정보 수정하기</button></a><br>
</div>
<h1 class="title">학력정보</h1>
<div class="info_wrapper">
<div class="btn-group" role="group" aria-label="Basic radio toggle button group" style="width:100%">
  <input type="radio" class="btn-check" name="finalEducation" id="btnradio1" autocomplete="off" value="초등학교" required="required">
  <label class="btn btn-outline-primary" for="btnradio1">초등학교</label>

  <input type="radio" class="btn-check" name="finalEducation" id="btnradio2" autocomplete="off" value="중학교" required="required">
  <label class="btn btn-outline-primary" for="btnradio2">중학교</label>

  <input type="radio" class="btn-check" name="finalEducation" id="btnradio3" autocomplete="off" value="고등학교" required="required">
  <label class="btn btn-outline-primary" for="btnradio3">고등학교</label>
  
  <input type="radio" class="btn-check" name="finalEducation" id="btnradio4" autocomplete="off" value="대학교/대학원" required="required">
  <label class="btn btn-outline-primary" for="btnradio4">대학교/대학원</label>
</div>
<hr>
<p class="ed_title">학교정보입력<span style="font-size: 11px;color: red;margin-left: 1%;">필수</span></p>
<label class="ed_ch"><input type="checkbox" name="state" onclick="check()" value="검정고시" required="required">검정고시</label><br>
<div class="row">
  <label for="colFormLabel" class="col-sm-2 col-form-label">학교명</label>
  <div class="col-sm-10">
    <input type="text" name="educationName" class="colFormLabel" id="colFormLabel">
  </div>
</div>
<div class="row">
  <label for="colFormLabel" class="col-sm-2 col-form-label">재학기간</label>
  <div class="col-sm-10">
    <input type="text" name="period" class="colFormLabel" id="colFormLabel" placeholder="예시)2016-03-02~2020-02-09">
    <select name="state" required="required">
    <option value="">상태</option>
    <option value="재학">재학</option>
    <option value="졸업">졸업</option>
    <option value="휴학">휴학</option>
    <option value="중퇴">중퇴</option>
    <option value="졸업예정">졸업예정</option>
    <option value="검정고시">검정고시</option>
</select>
  </div>
</div>
<div class="row">
  <label for="colFormLabel" class="col-sm-2 col-form-label">전공</label>
  <div class="col-sm-10">
    <input type="text" name="major" class="colFormLabel" id="colFormLabel">
  </div>
</div>
<div class="row">
	<label for="colFormLabel" class="col-sm-2 col-form-label">학점</label>
  <div class="col-sm-3">
    <input type="text" class="form-control" name="score" placeholder="평균학점 예시)3.9" aria-label="First name">
  </div>
  <div class="col-sm-3">
    <input type="text" class="form-control" name="basicScore" placeholder="기준학점 예시)4.5" aria-label="Last name">
  </div>
</div>
</div>
<h1 class="title">경력정보<span style="font-size: 11px;color: red;margin-left: 1%;">필수</span></h1>
<div class="info_wrapper" style="padding-bottom: 6%;">
<div class="btn-group" role="group" aria-label="Basic radio toggle button group" style="width:100%">
  <input type="radio" class="btn-check" name="career" id="btnradio5" autocomplete="off" value="신입" required="required">
  <label class="btn btn-outline-primary" for="btnradio5">신입</label>
  
  <input type="radio" class="btn-check" name="career" id="btnradio6" autocomplete="off" value="경력" required="required">
  <label class="btn btn-outline-primary" for="btnradio6">경력</label>
</div>
<hr>
<button type="button" onclick="addCareer()" class="btn btn-color btn-sm">+경력추가</button>
</div>
<div id="com"></div>
<h1 class="title">자기소개서</h1>
<div class="info_wrapper">
<div class="form-floating">
  <textarea name="myinfo" class="form-control" placeholder="Leave a comment here" id="floatingTextarea2" style="height: 100px">${re.myinfo}</textarea>
  <label for="floatingTextarea2">자기소개서</label>
</div>
</div>
<h1 class="title">기타서류</h1>
<div class="info_wrapper">
<p class="ed_title">첨부파일 선택</p>
<c:forEach var="doc" items="${doList}">
<div class="form-check">
  <input class="form-check-input" type="checkbox" value="${doc.documentId}" name ="document" id="flexCheckDefault">
  <label class="form-check-label" for="flexCheckDefault">
	<span class="doc_date">${doc.wDate}</span>
	<span class="doc_type">${doc.type}</span> 
	<span class="doc_fileTitle">${doc.fileTitle}</span> 
	<span class="doc_fileSize">${doc.fileSize}</span>
  </label>
</div>
</c:forEach>
</div>
<input type="submit" class="btn btn-color btn-sm" style="margin-top:2%;" value="이력서 저장">
</form>
</div>
</body>
</html>