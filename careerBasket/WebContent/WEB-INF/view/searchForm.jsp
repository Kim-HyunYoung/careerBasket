<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>searchForm.jsp</title>

<!-- 부트스트랩 버전 3으로 해야 select 잘 적용됨 -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
	integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu"
	crossorigin="anonymous">
<!-- 부트스트랩 select css -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/css/bootstrap-select.min.css">

<!-- ajax CDN -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- select보다 부트스트랩이 더 먼저와야함 -->
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"
	integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd"
	crossorigin="anonymous"></script>
<!-- 부트스트랩 select 스크립트 -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/js/bootstrap-select.min.js"></script>
<!-- 부트스트랩 아이콘 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">

<link rel="stylesheet" type="text/css" href="/css/search.css?verver">
<link rel="stylesheet" type="text/css" href="/css/header.css">
<link rel="stylesheet" type="text/css" href="/css/imgstyle.css">
<link rel="stylesheet" type="text/css" href="/css/pagenation.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script type="text/javascript">

		//ajax함수 선언
		function loadAjax(url,page) {
			var pageNumData = page;
				console.log("pageNumData :" +pageNumData);
			//var formData = $("#searchForm").serializeArray();
			//radio 체크된 값 가져오기
			var careerData = $('form [name="hireCareer"]:checked').val();
				console.log("careerData :" +careerData);
			var workPlaceData = $('form [name="workPlace"]').val();
				console.log("workPlaceData :" +workPlaceData);
			var positionData = $('form [name="position"]:checked').val();
				console.log("positionData :" +positionData);
				
			var allData = {"hireCareer":careerData, "workPlace":workPlaceData, "position":positionData,"page":pageNumData}
			
			$.ajax({
				url:"/hire/search",
				type:"get",
				data:allData,
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
						$('#rs').append('<div class="notice"><svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" fill="red" class="bi bi-exclamation-circle" viewBox="0 0 16 16">'
								  +'<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>'
								  +'<path d="M7.002 11a1 1 0 1 1 2 0 1 1 0 0 1-2 0zM7.1 4.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 4.995z"/>'
								  +'</svg><div class="sorry">죄송합니다.</div><br><div>해당하는 채용 공고가 없습니다.</div></div>');
						//$("#rs").append("<div class='notice'><h1 class='sorry'>죄송합니다.<br>해당하는 채용 공고가 없습니다.</h1></div>");
						$(".pagination").children().remove();
						
					}else{
						
						//append때문에 쌓이지 않도록 remove(초기화)시켜줌
						$("#rs").children().remove();
						
						for(var hire of hireList){
							console.log(hire);
							console.log("logoImg :"+hire.logoImg);
						var newSection = $("<div class='list_content'>");
						newSection.append("<img class='logo' src='http:/img/logo/"+hire.logoImg+"'>")
						//id 링크 -> hash
						newSection.append("<button class='btn btn-color btn-lg info'><a id='detail_btn' value='"+currentPage+"' href='http://localhost:8080/hire/detail?id="+hire.id+"&userId=${userId}'>상세보기</a></button>")
							//쿼리스트링으로 해당 페이지로 연결 url~~~?변수1=값1&변수2=값2
						newSection.append("<div class='list_top'><div class='hire_title'>"+hire.hireTitle+"</div><div class='end_date'><span class='end_box'>마감일</span>"+hire.endDate.substring(0,10)+"</div>")
						newSection.append("<div class='com_name_box'><div class='company_name'>"+hire.companyName+"</div>")
						newSection.append("<br><div class='list_box'><div class='h_info'><span>"+hire.workPlace+" | </span><span>"+hire.workType+" | </span><span>"+hire.education+"</span></div>")
						
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
						
						//var newSection = $("<div>");
						var newSection = $(".pagination");
							
						//append때문에 쌓이지 않도록 remove(초기화)시켜줌
							$(".pagination").children().remove();
							
						//--------------첫번째 페이지로 가는 버튼----------------------------
						if(pageTotalCnt == 1 || pageTotalCnt == 2){ //페이지가 1 또는 2면
							//첫째 페이지로 가는 버튼 없애기
							$(".goFirstPage").children().remove();
						}else{  //페이지가 1또는 2가 아니면 
							// <<버튼 활성화
							newSection.append("<ul class='pager'><li class='previous goFirstPage' value='"+1+"'><a href='#' ><span aria-hidden='true'>&larr;</span>First</a></li></ul>");
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
								newSection.append("<li class='goBackPage' value='"+(currentPage-1)+"'><a href='#' aria-label='Previous'><</a></li>");
								
							}
						}
						
						//-----------------페이지 숫자 출력(3개씩)---------------------------
						for(var i =blockBegin; i<blockEnd+1; i++){
								console.log("페이지네이션"+i);
							newSection.append("<li class='p' value='"+i+"'><a href='#'>"+i+"</a></li>");
							
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
								newSection.append("<li class='goNextPage' value='"+(currentPage+1)+"'><a href='#' aria-label='Next'>></a></li>");
							}
						}
							
						//----------------------마지막 페이지로 이동 버튼------------------------
						if(pageTotalCnt == 1 || pageTotalCnt == 2){
							$(".goLastPage").children().remove();
						
						}else {
							newSection.append("<ul class='pager'><li class='next goLastPage' value='"+pageTotalCnt+"'><a href='#' >Last<span aria-hidden='true'>&rarr;</span></a></li></ul>");	
						}
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
			//해당 리스트를 그리기 위해 필요한 값(가져올 값)
			arr_data = hash_str.split("&"); //데이터 쪼개서 배열로 담기
			var pageNumData = arr_data[0];
			console.log("pageNumData"+pageNumData);
			
			loadAjax("/hire/search",pageNumData);
			return false; 
		}
	}


	//현재 input 값 가져오는 메서드??
	function getInputData(){}
	
	
//----------------문서 로드---------------------------------
 $(function(){ 
	 
	 //문서가 로드 될 때마다 hash 체크
	 checkForHash();
	 
	 //검색버튼 눌렀을 때 실행될 이벤트
	$("#searchForm").on("submit",function(){
		//radio 체크된 값 가져오기
		var careerData = $('form [name="hireCareer"]:checked').val();
			console.log("careerData :" +careerData);
		var workPlaceData = $('form [name="workPlace"]').val();
			console.log("workPlaceData :" +workPlaceData);
		var positionData = $('form [name="position"]:checked').val();
			console.log("positionData :" +positionData);
	
		//검색 조건3가지 중 하나라도 입력하지 않으면 (null,지역을 선택하세요,null) 안내문구 띄우기
		if(typeof careerData == "undefined" || workPlaceData == "선택" || typeof positionData == "undefined"){
			$("#rs").children().remove();
			$('#rs').append('<div class="notice"><svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" fill="red" class="bi bi-ui-checks-grid" viewBox="0 0 16 16">'
					  +'<path d="M2 10h3a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1v-3a1 1 0 0 1 1-1zm9-9h3a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1h-3a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zm0 9a1 1 0 0 0-1 1v3a1 1 0 0 0 1 1h3a1 1 0 0 0 1-1v-3a1 1 0 0 0-1-1h-3zm0-10a2 2 0 0 0-2 2v3a2 2 0 0 0 2 2h3a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2h-3zM2 9a2 2 0 0 0-2 2v3a2 2 0 0 0 2 2h3a2 2 0 0 0 2-2v-3a2 2 0 0 0-2-2H2zm7 2a2 2 0 0 1 2-2h3a2 2 0 0 1 2 2v3a2 2 0 0 1-2 2h-3a2 2 0 0 1-2-2v-3zM0 2a2 2 0 0 1 2-2h3a2 2 0 0 1 2 2v3a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2zm5.354.854a.5.5 0 1 0-.708-.708L3 3.793l-.646-.647a.5.5 0 1 0-.708.708l1 1a.5.5 0 0 0 .708 0l2-2z"/>'
					  +'</svg><h1 class="check">검색 조건을 모두 선택해 주세요.</h1></div>');
			$(".pagination").children().remove();
			
			return false;  //이거 안해주면 페이지 계속 새로고침된다!
			
		}else{
			loadAjax("/hire/search",1);
			return false; 
		}
		
	});
 	
	//click 이벤트를 걸어 이벤트가 발생할때마다 현재 페이지를 내부링크처럼 hash에 저장
 	//상세보기 버튼 눌렀을 때 hash에 해당 id값을 저장(뒤로 가기 했을 때 기존 리스트를 보여주기위해서)
 	 $(document).on("click","#detail_btn",function(){ //.info 를 #detail_btn으로 변경해봄
 		var pageNumData = $(this).attr("value");
			console.log("pageNumData :" +pageNumData);
		var careerData = $('form [name="hireCareer"]:checked').val();
			console.log("careerData :" +careerData);
		var workPlaceData = $('form [name="workPlace"]').val();
			console.log("workPlaceData :" +workPlaceData);
		var positionData = $('form [name="position"]:checked').val();
			console.log("positionData :" +positionData);
			
 		 document.location.hash = "#" + pageNumData +"&"+careerData +"&"+ workPlaceData+ "&"+ positionData;
 		 
 	 });
	 
	//클릭된 페이지에 해당하는 리스트 보여주는 이벤트
	 $(document).on("click",".p",function(){
		var pageNumData = $(this).attr("value");
		loadAjax("/hire/search",pageNumData);
		return false; 
			
	});
	
	$(document).on("click",".goFirstPage",function(){
		var pageNumData = $(this).attr("value");
		loadAjax("/hire/search",pageNumData);
		return false; 
		
	});
	
	$(document).on("click",".goBackPage",function(){
		var pageNumData = $(this).attr("value");
		loadAjax("/hire/search",pageNumData);
		return false; 
		
	});
		
	$(document).on("click",".goNextPage",function(){
		var pageNumData = $(this).attr("value");
		loadAjax("/hire/search",pageNumData);
		return false; 
		
	});
		
	$(document).on("click",".goLastPage",function(){
		var pageNumData = $(this).attr("value");
		loadAjax("/hire/search",pageNumData);
		return false; 
		
	});
		
 }); 
 
</script>
</head>
<body>
	<div class="frame"> <!-- 로그아웃일 때 상단바 -->
		<div class="top">
			<c:if test="${empty userId}">
				<div class="top_left">
					<a href="/user/logout" style="color: #82B6ED">careerBasket</a>
				</div>
				<div class="top_middle">
					<a href="/hire/list">탐색</a> <a href="/user/loginForm">이력서</a>
				</div>
				<div class="top_right">
					<button class="btn btn-color">
						<a href="/user/signup">회원가입</a>
					</button>
					<button class="btn btn-color">
						<a href="/user/loginForm">로그인</a>
					</button>
				</div>
			</c:if> 
			<c:if test="${not empty userId}"> <!-- 로그인일 때 상단바 -->
				<div class="top_left">
					<a style="color: #82B6ED" href="/user/main?userId=${userId}">careerBasket</a>
				</div>
				<!-- 로고 -->
				<div class="top_middle">
					<a href="/hire/list?userId=${userId}">탐색</a> <a
						href="/resume/addresume?userId=${userId}">이력서</a>
				</div>
				<div class="top_right">
					<div class="ms">
						<span style="font-size: 13px; color: gray;"> <span
							style="color: #82B6ED;">${userId}</span> 님의 취업을 응원합니다!
						</span>
					</div>
					<button class="btn btn-color"
						style="float: left; margin-top: 15px; margin-left: 12px;">
						<a href="/user/logout">로그아웃</a>
					</button>
				</div>
			</c:if>
		</div> <!-- //상단바 -->
		<div class="conTain">
			<!-- 검색바 -->
			<div class="searchBar">
				<form id="searchForm">
					<div class="search1">
						<div class="career">
							<input class="car_con" type="radio" name="hireCareer" value=1>
							경력 <input class="car_con" type="radio" name="hireCareer" value=2>
							신입
						</div>
						<div class="place">
							<label style="margin-right: 12px;">지역</label> <select
								name="workPlace" class="selectpicker">
								<option style="font-size: smaller; color: lightgray;" value="선택">지역을
									선택해주세요</option>
								<option class="selectOp" value="서울">서울</option>
								<option class="selectOp" value="대구">대구</option>
								<option class="selectOp" value="부산">부산</option>
							</select>
						</div>
					</div>
					<hr>
					<div class="position">
						<div class="po_content1">
							<input type="radio" name="position" value="자바 개발자">자바 개발자
							<br> <input type="radio" name="position" value="안드로이드 개발자">안드로이드
							개발자 <br> <input type="radio" name="position"
								value="데이터 사이언티스트">데이터 사이언티스트<br> <input
								type="radio" name="position" value="프론트엔드 개발자">프론트엔드 개발자
							<br> <input type="radio" name="position" value="소프트웨어 엔지니어 ">소프트웨어
							엔지니어 <br>
						</div>
						<div class="po_content2">
							<input type="radio" name="position" value="빅데이터 엔지니어">빅데이터
							엔지니어<br> <input type="radio" name="position"
								value="보안 엔지니어 ">보안 엔지니어 <br> <input type="radio"
								name="position" value="PHP 개발자">PHP 개발자<br> <input
								type="radio" name="position" value="임베디드 개발자">임베디드 개발자<br>
							<input type="radio" name="position" value="하드웨어 엔지니어">하드웨어
							엔지니어<br>
						</div>
						<div class="po_content3">
							<input type="radio" name="position" value="BI 엔지니어">BI
							엔지니어<br> <input type="radio" name="position" value="기술지원">기술지원<br>
							<input type="radio" name="position" value="QA,체스트 엔지니어">QA,체스트
							엔지니어<br> <input type="radio" name="position"
								value="그래픽스 엔지니어">그래픽스 엔지니어<br> <input type="radio"
								name="position" value="Node.js 개발자">Node.js 개발자<br>
						</div>
					</div>
					<hr>
					<button class=" btn btn-color btn-lg search_btn">검색</button>
				</form>
			</div> <!-- //검색바 -->
			<hr>
			<!-- 리스트 -->
			<!-- 결과 보여주는 부분 -->
			<div class="rs_list">
				<div id="rs"></div>
			</div> <!-- //리스트 -->
			
			<!-- 페이지 네이션 -->
			<div class="p_bottom">
				<nav aria-label="Page navigation">
					<ul class="pagination"></ul>
				</nav>
			</div> <!-- //페이지 네이션 -->
		</div> <!-- //container -->
	</div>

</body>
</html>