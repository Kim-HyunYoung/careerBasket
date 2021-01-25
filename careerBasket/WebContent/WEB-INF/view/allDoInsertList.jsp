<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	
})

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
    <option value="이력서">이력서</option>
    <option value="경력기술서">경력기술서</option>
    <option value="자격증">자격증</option>
    <option value="증명서">증명서</option>
    <option value="추천서">추천서</option>
    <option value="기타">기타</option>
</select><br>
파일 찾기 <input type="file" name="document">
<button onclick="fileUpload(${si.userId})">추가하기</button>
</div>
<div id="doc"></div>
</body>
</html>