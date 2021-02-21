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
		$("#doc").append("<p style='text-align: center;margin-bottom: 10%;padding-top: 10%;'>저장된 문서가 없습니다</p>");
	}
})

function del(documentId, userId){
	console.log(documentId+userId);
	
	  //삭제전에 확인창 띄우기
	 if (confirm("정말 삭제하시겠습니까??") == true){    //확인
		  var form = document.createElement("form");
		  form.setAttribute("method", "get");
		  form.setAttribute("action", "${pageContext.request.contextPath}/resume/deleteDocument");
		  
		//파라미터 넘겨주기 위해 히든타입으로 input id값 입력
		  var hiddenField=document.createElement("input");
		  hiddenField.setAttribute("type", "hidden");
		  hiddenField.setAttribute("name", "documentId");
		  hiddenField.setAttribute("value", documentId);
		  form.appendChild(hiddenField);
		  
		  var hiddenField=document.createElement("input");
		  hiddenField.setAttribute("type", "hidden");
		  hiddenField.setAttribute("name", "userId");
		  hiddenField.setAttribute("value", userId);
		  form.appendChild(hiddenField);
		  
		  //동적 form은 꼭 append해줘야 submit가능
		  document.querySelector("body").appendChild(form);
		  form.submit();
		}else{   //취소
		    return;
		}
}

function download(filePath, fileTitle){
	console.log(filePath+fileTitle);
    $.ajax({
        url: "http://localhost:8080/img/"+filePath,
        method: 'GET',
        xhrFields: {
            responseType: 'blob'
        },
        success: function (data) {
            var a = document.createElement('a');
            var url = window.URL.createObjectURL(data);
            a.href = url;
            a.download = fileTitle;
            document.body.append(a);
            a.click();
            a.remove();
            window.URL.revokeObjectURL(url);
        }
    })
}

function fileUpload(userId){	
	
		var files = document.querySelector("input[type=file]").files;
		var type = $("select[name=type]").val();
		console.dir(files);
		console.log(type);
		console.log(userId);
		
		//file을 전송하기 위해 FormData라는 객체에 넣어야한다
		var formData = new FormData();
		
		//폼에 보낼 내용을 추가
		for(file of files){
			console.dir(file);
			formData.append("files",file);
		}
		
			formData.append("type", type);
			formData.append("userId", userId);
		
		//비동기로 파일을 서버로 보냄
		$.ajax({
			url:"/resume/documentList",
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
<title>allDoInsertList</title>
<!-- ----------------------------부트스트랩 CDN-------------------------------- -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

<!-- ---------------------------------------폰트 CDN---------------------------------------------- -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">


<link rel="stylesheet" type="text/css" href="/css/header.css">
<link rel="stylesheet" type="text/css" href="/css/allDoinsertList.css">
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

<!-- --------------------------메인화면-------------------------- -->
<div id="wrap">
<div class="title_wrapper">
<h1 class="document_title">업로드된 기타문서 목록</h1>
<div class="fileUpload-wrapper">
<div class="fileUpload-title">첨부 파일 등록</div>
<div class="file_wrapper">
<label for="formFileSm" class="form-label">파일 선택</label>
<select name="type" class="form-select form-select-sm" aria-label=".form-select-sm example">
    <option value="">구분선택</option>
    <option value="포트폴리오">포트폴리오</option>
    <option value="경력기술서">경력기술서</option>
    <option value="자격증">자격증</option>
    <option value="증명서">증명서</option>
    <option value="추천서">추천서</option>
    <option value="기타">기타</option>
</select><br>
<div class="mb-3">
  <label for="formFileSm" class="form-label">파일 선택</label>
  <button onclick="fileUpload('${userId}')" class="btn btn-color1 btn-sm btn-file">추가하기</button>
  <input class="form-control form-control-sm" id="formFileSm" type="file" name="document" accept=".jpg, .png, .pdf">
</div>
</div>
</div>
<hr>
</div>
<div id="doc"></div>
<c:forEach var="doc" items="${doList}">
	<div class="fileList_outLine">
		<div class="float">
		<button type="button" class="btn btn-color1 btn-sm" onclick="mydelete('${doc.documentId}', '${userId}')">삭제</button>
		</div>
		<p class="docList-wrap">
		<span class="date">${doc.wDate }</span>
		<span class="type">${doc.type }</span>
		<span class="title">${doc.fileTitle }</span>
		</p>
	</div>
</c:forEach>
</div>
</body>
</html>