<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
function myinsert(userId){
	 console.log(userId)
	//form생성후에 동적으로 보내주기
	 var form = document.createElement("form");
	  form.setAttribute("method", "get");
	  form.setAttribute("action", "${pageContext.request.contextPath}/resume/addresume");
	  
	  
	//파라미터 넘겨주기 위해 히든타입으로 input id값 입력
	  var hiddenField=document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "userId");
	  hiddenField.setAttribute("value", userId);
	  form.appendChild(hiddenField);
	  
	  //동적 form은 꼭 append해줘야 submit가능
	  document.querySelector("body").appendChild(form);
	  form.submit();
}
function picklist(id, userId){
	console.log("실행")
	//form생성후에 동적으로 보내주기
	var form = document.createElement("form");
	  form.setAttribute("method", "get");
	  form.setAttribute("action", "${pageContext.request.contextPath}/resume/details");
	  
	//파라미터 넘겨주기 위해 히든타입으로 input id값 입력
	  var hiddenField=document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "id");
	  hiddenField.setAttribute("value", id);
	  form.appendChild(hiddenField);
	  
	//파라미터 넘겨주기 위해 히든타입으로 input id값 입력
	  var hiddenField=document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "userId");
	  hiddenField.setAttribute("value", userId);
	  form.appendChild(hiddenField);
	  
	  //동적 form은 꼭 append해줘야 submit가능
	  document.querySelector("body").appendChild(form);
	  form.submit();
}
function mydelete(resumeId, userId){
	  //console.log(id);
	  //삭제전에 확인창 띄우기
	 if (confirm("정말 삭제하시겠습니까??") == true){    //확인
		  var form = document.createElement("form");
		  form.setAttribute("method", "get");
		  form.setAttribute("action", "${pageContext.request.contextPath}/resume/delete");
		  
		//파라미터 넘겨주기 위해 히든타입으로 input id값 입력
		  var hiddenField=document.createElement("input");
		  hiddenField.setAttribute("type", "hidden");
		  hiddenField.setAttribute("name", "userId");
		  hiddenField.setAttribute("value", userId);
		  form.appendChild(hiddenField);
		  
		//파라미터 넘겨주기 위해 히든타입으로 input id값 입력
		  var hiddenField=document.createElement("input");
		  hiddenField.setAttribute("type", "hidden");
		  hiddenField.setAttribute("name", "resumeId");
		  hiddenField.setAttribute("value", resumeId);
		  form.appendChild(hiddenField);
		  
		  //동적 form은 꼭 append해줘야 submit가능
		  document.querySelector("body").appendChild(form);
		  form.submit();
		}else{   //취소
		    return;
		} 			
}
function myupdate(resumeId, userId){
	  console.log(resumeId);
	  var form = document.createElement("form");
	  form.setAttribute("method", "get");
	  form.setAttribute("action", "${pageContext.request.contextPath}/resume/update");
	  
	  //파라미터 넘겨주기 위해 히든타입으로 input하고 submit함
	  var hiddenField=document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "resumeId");
	  hiddenField.setAttribute("value", resumeId);
	  form.appendChild(hiddenField);
	  
		//파라미터 넘겨주기 위해 히든타입으로 input id값 입력
	  var hiddenField=document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "userId");
	  hiddenField.setAttribute("value", userId);
	  form.appendChild(hiddenField);
	  
	  //동적 form은 꼭 append해줘야 submit가능
	  document.querySelector("body").appendChild(form);
	  form.submit();
}
</script>
<title>allList.jsp</title>
</head>
<body>
<div>
<button onclick="myinsert('${userId}')">이력서 등록</button>
<fieldset>
<c:forEach var="re" items="${list}">
<!-- 저장된 이력서 목록 전체 보여주기 -->
<section >
<a onclick="picklist('${re.resumeId}', '${re.userId}')">${re.title}</a>
${re.wDate}
</section>
<section>
<button onclick="myupdate('${re.resumeId}', '${re.userId}')">수정</button>
<button onclick="mydelete('${re.resumeId}', '${re.userId}')">삭제</button>
</section>
</c:forEach>
</fieldset>
</div>
</body>
</html>