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
	if("${doList}"!="[]"){
		<c:forEach var="doc" items="${doList}">
		var doc = document.getElementById("doc");
		
		var f = document.createElement("fieldset");
	 	doc.append(f);
	 	
	 	f.innerHTML="${doc.wDate} ${doc.type} ${doc.fileTitle} ${doc.fileSize}";
	 	
	 	var b = document.createElement("input");
		b.setAttribute("type", "button");
		b.setAttribute("value", "삭제");
		b.setAttribute("onclick", "del('${doc.documentId}', '${doc.userId}')");
		f.append(b);
		
		var b2 = document.createElement("input");
		b2.setAttribute("type", "button");
		b2.setAttribute("value", "파일저장");
		b2.setAttribute("onclick", "download('${doc.filePath}', '${doc.fileTitle}')");
		f.append(b2);
		
		
	 	  
		</c:forEach>
	}else{
		document.getElementById("doc").innerHTML = "저장된 문서가 없습니다";
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
		userId="durumi";
		
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
</head>
<body>
<div>
파일 구분 
<select name="type">
    <option value="">구분선택</option>
    <option value="포트폴리오">포트폴리오</option>
    <option value="경력기술서">경력기술서</option>
    <option value="자격증">자격증</option>
    <option value="증명서">증명서</option>
    <option value="추천서">추천서</option>
    <option value="기타">기타</option>
</select><br>
파일 찾기 <input type="file" name="document" accept=".jpg, .png, .pdf">
<button onclick="fileUpload(${si.userId})">추가하기</button>
</div>
<div id="doc"></div>
</body>
</html>