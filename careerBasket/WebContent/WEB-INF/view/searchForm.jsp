<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>searchForm.jsp</title>
<link rel="stylesheet" type="text/css" href="/css/pagenation.css">
<link rel="stylesheet" type="text/css" href="/css/detail.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
//ajax 비동기 방식으로 검색 버튼 누르면 리스트 보여주기!

		//ajax함수 선언
		function loadAjax(url, type, alldata) {
			//url 없애기
			
			$.ajax({
				url:"/hire/search",
				type:type,
				data:alldata,
				success:function(resp){
					//총 검색결과 개수
					var hireTotalCnt = resp.hireTotalCnt;
					//해당 페이지에 보여줄 목록
					var hireList = resp.hireList;
						console.log(hireList);
					//현재 페이지 
					var currentPage = resp.currentPageNum;
						console.log(currentPage);
					
					if(hireTotalCnt == 0){
						//가져온 데이터가 없으면 목록이 없다는 문구를 삽입.
						$("#rs").children().remove();
						$("#rs").append("<h1>죄송합니다.<br>해당하는 채용 공고가 없습니다.</h1>");
						$(".pagination").children().remove();
						
					}else{
						//가져온 데이터가 있으면 목록을 each로 반복해서출력!
						
						//append때문에 쌓이지 않도록 remove(초기화)시켜줌
						$("#rs").children().remove();
						
						for(var hire of hireList){
							console.log(hire);
							console.log("logoImg :"+hire.logoImg);
						var newSection = $("<section>");
						newSection.append("<img class='logo' src='http:/img/logo/"+hire.logoImg+"'>")
						//id 링크 -> hash
						newSection.append("<a value='"+currentPage+"' class='info' href='http://localhost:8080/hire/detail?id="+hire.id+"'>상세보기</a><br>")
							//쿼리스트링으로 해당 페이지로 연결 url~~~?변수1=값1&변수2=값2
							//http://localhost:8080/hire/detail
						newSection.append(hire.hireTitle+"<br>")
						newSection.append(hire.endDate+"<br>")
						newSection.append(hire.companyName+"<br>")
						newSection.append(hire.workPlace+"<br>")
						newSection.append(hire.workType+"<br>")
						newSection.append(hire.education+"<hr>")
							
						$("#rs").append(newSection);
					
						}
						
						//----------페이지네이션 처리하기--------------------------
							
							console.log("totBlock :"+resp.totBlock);
							console.log("curBlock :"+resp.curBlock);
							console.log("prevPage :"+resp.prevPage);
							console.log("nextPage :"+resp.nextPage);
							console.log("blockBegin :"+resp.blockBegin);
							console.log("blockEnd :"+resp.blockEnd);

						var blockBegin = resp.blockBegin;
						var blockEnd = resp.blockEnd;
						
						var pageTotalCnt = resp.pageTotalCnt;
							console.log("pageTotalCnt :"+pageTotalCnt);
						
						var newSection = $("<section>");
							
						//append때문에 쌓이지 않도록 remove(초기화)시켜줌
							$(".pagination").children().remove();
							
						//--------------첫번째 페이지로 가는 버튼----------------------------
						if(pageTotalCnt == 1 || pageTotalCnt == 2){ //페이지가 1 또는 2면
							//첫째 페이지로 가는 버튼 없애기
							$(".goFirstPage").children().remove();
						}else{  //페이지가 1또는 2가 아니면 
							// <<버튼 활성화
							newSection.append("<li class='goFirstPage' value='"+1+"'><a><<</a></li>");
						}
						
						//------------------뒤로가기 버튼---------------------------------
						if(pageTotalCnt == 1){ //전체 페이지가 1이면
							// <버튼 없애기
							$(".goBackPage").children().remove();
						}else {
							//전체 페이지가 2,3,4,,,,이면
							if(currentPage == 1){ //현재 페이지가 1일 경우 
								// <버튼 비활성화							
								newSection.append("<li class='disabled' value='"+currentPage+"'><a><</a></li>");
							}else {
								console.log("pageNumData-1="+(currentPage-1));
								newSection.append("<li class='goBackPage' value='"+(currentPage-1)+"'><a><<a></li>");
								
							}
						}
						
						//-----------------페이지 숫자 출력(3개씩)---------------------------
						for(var i =blockBegin; i<blockEnd+1; i++){
								console.log("페이지네이션"+i);
							newSection.append("<li class='p' value='"+i+"'><a>"+i+"</a></li>");
							
							$(".pagination").append(newSection);
						}
						
						//---------------------다음 버튼----------------------------------
						if (pageTotalCnt == 1) { //전체 페이지 블럭수가 1개 뿐일 때
							// >다음버튼 없애기
							$(".goNextPage").children().remove();
						}else {
							if(currentPage == pageTotalCnt){ //현재 페이지가 1일 경우 
								// >다음버튼 비활성화							
								newSection.append("<li class='disabled' value='"+currentPage+"'><a>></a></li>");
							}else {
								newSection.append("<li class='goNextPage' value='"+(currentPage+1)+"'><a>></a></li>");
							}
						}
							
						
						//----------------------마지막 페이지로 이동 버튼------------------------
						if(pageTotalCnt == 1 || pageTotalCnt == 2){
							$(".goLastPage").children().remove();
						
						}else {
							newSection.append("<li class='goLastPage' value='"+pageTotalCnt+"'><a>>></a></li>");	
						}
						
						/*
						fetch('listView').then(function(resp){
							document.querySelector('article').innerHTML = resp;
						})
						*/
					}
				},
				error:function(e){
					console.log(e);
				}
			});
		}
		
	
	//해쉬 체크하는 메서드 선언
	function checkForHash(){
		if(document.location.hash){
			var hash_str = document.location.hash;
			hash_str = hash_str.replace("#","");
			hash_str = decodeURI(hash_str);
			console.log(hash_str);
			//여기에 ajax함수로 해당 리스트 그리기
			//해당 리스트를 그리기 위해 필요한 값(가져올 값)
			arr_data = hash_str.split("&"); //데이터 쪼개서 배열로 담기
			var pageNumData = arr_data[0];
			console.log("pageNumData"+pageNumData);
			var careerData  = arr_data[1];
			console.log("careerData"+careerData);
			var workPlaceData = arr_data[2];
			//var workPlaceData = "hey"; ->영어는 나옴 한글 인코딩을 해야할 듯
			console.log("workPlaceData"+workPlaceData);
			var positionData = arr_data[3];
			console.log("positionData"+positionData);
			
			var allData = {"hireCareer":careerData, "workPlace":workPlaceData, "position":positionData,"page":pageNumData}
			
			loadAjax("/hire/search","get",allData); //post로 하면 1페이지만 나옴!! ,근데 get하니까 왜 사진 안나오지
			return false; 
		}
	}

//----------------문서 로드---------------------------------
 $(function(){ //$(document).ready(function(){ 와 같다
	 
	 //문서가 로드 될 때마다 hash 체크
	 checkForHash();
	 
	 //검색버튼 눌렀을 때 실행될 이벤트
	$("#f").on("submit",function(){
	
		var pageNumData = 1; //검색버튼 눌렀을 땐 -> 1페이지 보여줘야함
			console.log("pageNumData :" +pageNumData);
		//radio 체크된 값 가져오기
		var careerData = $('form [name="hireCareer"]:checked').val();
			console.log("careerData :" +careerData);
		var workPlaceData = $('form [name="workPlace"]').val();
			console.log("workPlaceData :" +workPlaceData);
		var positionData = $('form [name="position"]:checked').val();
			console.log("positionData :" +positionData);
			
		var allData = {"hireCareer":careerData, "workPlace":workPlaceData, "position":positionData,"page":pageNumData}
		
		
		//검색 조건3가지 중 하나라도 입력하지 않으면
		//(null,지역을 선택하세요,null)
		//안내문구 띄우기
		if(typeof careerData == "undefined" || workPlaceData == "선택" || typeof positionData == "undefined"){
			//document.write("<h1>검색할 조건을 선택해주세요</h1>")
			//loadAjax("/hire/check","post",allData);
			//return false; 
			$.ajax({
				url:"/hire/check",
				type:"post",
				success:function(){
					$("#rs").children().remove();
					$("#rs").append("<h1>검색 조건을 모두 선택해 주세요</h1>");
					$(".pagination").children().remove();
				},
				error:function(e){
					console.log(e);
				}
			
			});
			return false; 
			
		}else{
			
		
		//ajax함수 호출
		loadAjax("/hire/search","post",allData);
		return false; 
		}
		
	});
 	
	//click 이벤트를 걸어 이벤트가 발생할때마다 현재 페이지를 내부링크처럼 hash에 저장
 	//상세보기 버튼 눌렀을 때 hash에 해당 id값을 저장(뒤로 가기 했을 때 기존 리스트를 보여주기위해서)
 	 $(document).on("click",".info",function(){
 		 //현재페이지 번호!
 		 //alert("상세보기 버튼 클릭함!");
 		var pageNumData = $(this).attr("value");
			console.log("pageNumData :" +pageNumData);
		var careerData = $('form [name="hireCareer"]:checked').val();
			console.log("careerData :" +careerData);
		var workPlaceData = $('form [name="workPlace"]').val();
			console.log("workPlaceData :" +workPlaceData);
		var positionData = $('form [name="position"]:checked').val();
			console.log("positionData :" +positionData);
			
		//var allData = {"hireCareer":careerData, "workPlace":workPlaceData, "position":positionData,"page":pageNumData}
		
 		 document.location.hash = "#" + pageNumData +"&"+careerData +"&"+ workPlaceData+ "&"+ positionData;
		
 		 
 	 });
 
	 
	//클릭된 페이지에 해당하는 리스트 보여주는 이벤트
	 $(document).on("click",".p",function(){
			var pageNumData = $(this).attr("value");
				console.log("pageNumData :" +pageNumData);
			var careerData = $('form [name="hireCareer"]:checked').val();
				console.log("careerData :" +careerData);
			var workPlaceData = $('form [name="workPlace"]').val();
				console.log("workPlaceData :" +workPlaceData);
			var positionData = $('form [name="position"]:checked').val();
				console.log("positionData :" +positionData);
		
			var allData = {"hireCareer":careerData, "workPlace":workPlaceData, "position":positionData,"page":pageNumData}
			
			//ajax함수 호출
			loadAjax("/hire/search","get",allData);
			return false; 
			
	});
	
	
	//첫번째 페이지로 가기 버튼 이벤트
	$(document).on("click",".goFirstPage",function(){
		//alert("goFirstPage!");	
		var pageNumData = $(this).attr("value");
			console.log("pageNumData :" +pageNumData);
		var careerData = $('form [name="hireCareer"]:checked').val();
			console.log("careerData :" +careerData);
		var workPlaceData = $('form [name="workPlace"]').val();
			console.log("workPlaceData :" +workPlaceData);
		var positionData = $('form [name="position"]:checked').val();
			console.log("positionData :" +positionData);
	
		var allData = {"hireCareer":careerData, "workPlace":workPlaceData, "position":positionData,"page":pageNumData}
		
		//ajax함수 호출
		loadAjax("/hire/search","get",allData);
		return false; 
		
	});
	
	
	//이전 페이지로 가기 버튼 이벤트
	$(document).on("click",".goBackPage",function(){
		//alert("goBackPage!");
		//현재페이지!
		var pageNumData = $(this).attr("value");
		
		//pageNumData = pageNumData -1;
		//이전페이지로 가야하니까 currentPage에 -1을 해주기 
		console.log("pageNumData :" +pageNumData);
		//console.log("a :" + a);
		
		var careerData = $('form [name="hireCareer"]:checked').val();
		console.log("careerData :" +careerData);
		var workPlaceData = $('form [name="workPlace"]').val();
		console.log("workPlaceData :" +workPlaceData);
		var positionData = $('form [name="position"]:checked').val();
		console.log("positionData :" +positionData);
	
		var allData = {"hireCareer":careerData, "workPlace":workPlaceData, "position":positionData,"page":pageNumData}
		
		//ajax함수 호출
		loadAjax("/hire/search","get",allData);
		return false; 
		
	});
		
	
	//다음 페이지로 가기 버튼 이벤트
	$(document).on("click",".goNextPage",function(){
		//alert("goNextPage!");	
		var pageNumData = $(this).attr("value");
		
		//pageNumData = Number(pageNumData) + 1;
		//이전페이지로 가야하니까 currentPage에 +1을 해주기 
		console.log("pageNumData :" +pageNumData);
		//console.log("a :" + a);
		
		var careerData = $('form [name="hireCareer"]:checked').val();
		console.log("careerData :" +careerData);
		var workPlaceData = $('form [name="workPlace"]').val();
		console.log("workPlaceData :" +workPlaceData);
		var positionData = $('form [name="position"]:checked').val();
		console.log("positionData :" +positionData);
	
		var allData = {"hireCareer":careerData, "workPlace":workPlaceData, "position":positionData,"page":pageNumData}
		
		//ajax함수 호출
		loadAjax("/hire/search","get",allData);
		return false; 
		
	});
		
	//마지막 페이지로 가기 버튼 이벤트
	$(document).on("click",".goLastPage",function(){
		//alert("goLastPage!");	
		var pageNumData = $(this).attr("value");
		console.log("pageNumData :" +pageNumData);
		
		var careerData = $('form [name="hireCareer"]:checked').val();
		console.log("careerData :" +careerData);
		var workPlaceData = $('form [name="workPlace"]').val();
		console.log("workPlaceData :" +workPlaceData);
		var positionData = $('form [name="position"]:checked').val();
		console.log("positionData :" +positionData);
	
		var allData = {"hireCareer":careerData, "workPlace":workPlaceData, "position":positionData,"page":pageNumData}
		
		//ajax함수 호출
		loadAjax("/hire/search","get",allData);
		return false; 
		
	});
		
	//버튼 비활성화
	$(document).on("click",".disabled",function(){
		alert("disabled!");	
	});
	
 }); //여기가 ready 끝
 
 
</script>
</head>
<body>

<form id="f" action="/hire/search" method="post">
	<!-- 
	<input type="hidden" name="page" value="1" >
	 -->
	<input type="radio" name="hireCareer" value= 1> 경력
	<input type="radio" name="hireCareer" value= 2> 신입
	<hr>
	
	<label>지역</label>
	<select name="workPlace">
		<option value="선택"> 지역을 선택해주세요</option>
		<option value="서울">서울</option>
		<option value="대구">대구</option>
		<option value="부산">부산</option>
	</select>
	<hr>
	<!-- 특정 태그로 감싸서 onclick 이벤트(값 저장되도록) 걸어주기 -->
	<!-- 
	<a href="">자바 개발자 </a>  
	<a href='http://localhost:8080/hire/search?position='>자바 개발자</a><br>
	<br>
	<a href="">안드로이드 개발자</a>
	 
	 -->
	 <input type="radio" name="position" value="자바 개발자">자바 개발자
	 <input type="radio" name="position" value="안드로이드 개발자">안드로이드 개발자
	 <input type="radio" name="position" value="데이터 사이언티스트">데이터 사이언티스트
	<hr>
	<input type="submit" value="검색">
	
</form>
<hr>
	<!-- 결과 보여주는 부분 -->
		<div id="rs"></div>
		
	<!-- 페이지 네이션 -->
		<!--<section> 옆으로 플로팅 시키기  -->
		<ul class="pagination"></ul>

</body>
</html>