<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detailView.jsp</title>
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
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
	
	<link rel="stylesheet" type="text/css" href="/css/detail.css?ver14">
	<link rel="stylesheet" type="text/css" href="/css/header.css">
	<link rel="stylesheet" type="text/css" href="/css/imgstyle.css">
	
	<!-- 지도 services 라이브러리 불러오기 -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f92552f56d0252119d785ec6db2f5b73&libraries=services"></script>

</head>
<body>

	<!-- 마감일 형식바꾸기 -->
	<fmt:parseDate var="endDate" value="${detail.endDate}"
		pattern="yyyy-MM-dd'T'HH:mm" />
	<fmt:formatDate var="eDate" value="${endDate}" pattern="yyyyMMddHHmmss" />
	<fmt:parseDate var="startDate" pattern="yyyy-MM-dd'T'HH:mm"
		value="${detail.startDate}" />

<script>	
$(function(){

	//-------------------- 남은 시간 계산 --------------
	const clock = document.querySelector(".clock");
	
	function getTime(){
		//현재시간 찍는 객체를 여기서 만들기
		var today = new Date();
		var endTime = "${eDate}";
		//마감일 객체
		 var endDate  = new Date(
				 parseInt(endTime.substring(0,4), 10), //년
	             parseInt(endTime.substring(4,6), 10)-1, //'월'데이터 불일치. -1로 보정
	             parseInt(endTime.substring(6,8), 10), //일
	             parseInt(endTime.substring(8,10), 10), //시
	             parseInt(endTime.substring(10,12), 10), //분
	             parseInt(endTime.substring(12,14), 10) //초
	            );
		console.log(endDate);
		
		//일자 사이의 차이 구하기
		  var dateGap = endDate.getTime() - today.getTime();
		  console.log(dateGap);
		  var timeGap = new Date(0, 0, 0, 0, 0, 0, endDate - today);
	  	  console.log(timeGap);
	  	  
	  	   var diffDay  = Math.floor(dateGap / (1000 * 60 * 60 * 24)); // 일수
	   		  console.log(diffDay);
	
	  	   var diffHour = ("0"+timeGap.getHours()).slice(-2);       // 시간 끝에 두자리(00,01,02)
	   		  console.log(diffHour);
	
	  	   var diffMin  = ("0"+timeGap.getMinutes()).slice(-2);      // 분
	   	 	 console.log(diffMin);
	
	  	   var diffSec  = ("0"+timeGap.getSeconds()).slice(-2);      // 초
	   	 	 console.log(diffSec);
	  	   
	  	  clock.innerHTML = diffDay + "일 " + diffHour + ": " + diffMin + ": "  + diffSec ;
			 console.log("getTime 끝")
	}
	
	//1초마다 getTime함수 실행
	setInterval(() => {
		console.log("인터벌 시작")
		getTime();	
		console.log("인터벌 끝")

	}, 1000);
	
	//모달창 안에 지원하기 버튼 눌렀을 때 실행될 것
	$("#apply").on("click",function(){ 
		var titleData = $('form [name="title"]').val();
		console.log(titleData);
		
		if(titleData == "이력서를 선택하세요."){//이력서 선택이 안되어 있으면 "이력서를 선택해주세요"문구 띄우기
			
			$.ajax({
				url:"/hire/check",
				type:"post",
				success:function(){
					$("#parents").children().remove();
					$("#parents").append("<h1 class='notice_re'>이력서를 선택해주세요.</h1>");
				},
				error:function(e){
					console.log(e);
				}
			})
			return false;
		
		}else{ //이력서 선택 되었으면 데이터 직렬화해서 변수에 담기!
			var con = confirm("지원서 제출후에는 수정이 불가능합니다.지원하시겠습니까?");
			if(con == true){ //확인누르면
				//폼에 있는 데이터를 스크립트로 보내려면 ajax에 사용하기 좋은 형태로 바꿔서 보내야해!!
				//직렬화를 해서 보내자
				var formData = $("form").eq(0).serialize(); //배열형태로 담김
				
				//이력서 선택 되어 있으면 post로 ajax 실행
				console.log("ajax전!")
				$.ajax({
					url:"/hire/apply",
					type:"post",
					data:formData,
					success:function(resp){
						console.log(resp);
						
						//구분해서 각각 다른 아이콘 넣어주기
						if(resp == "이미 지원하신 채용공고입니다."){
							console.log("이미 지원하신 채용공고입니다.");
							$('.modal-body').children().remove();
							//$('.modal-body').append("<div class='noti'>"+resp+"</div></div>");
							$('.modal-body').append('<div class="notice_already"><svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" fill="red" class="bi bi-exclamation-circle" viewBox="0 0 16 16">'
							  +'<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>'
							  +'<path d="M7.002 11a1 1 0 1 1 2 0 1 1 0 0 1-2 0zM7.1 4.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 4.995z"/>'
							  +'</svg><div class="noti">'+resp+'</div></div>');
						
						}else if(resp == "지원이 완료되었습니다."){
							console.log("지원이 완료되었습니다.");
							$('.modal-body').children().remove();
							$('.modal-body').append('<div class="notice_already"><svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" fill="#82B6ED" class="bi bi-file-earmark-check" viewBox="0 0 16 16">'
									  +'<path d="M10.854 7.854a.5.5 0 0 0-.708-.708L7.5 9.793 6.354 8.646a.5.5 0 1 0-.708.708l1.5 1.5a.5.5 0 0 0 .708 0l3-3z"/>'
									  +'<path d="M14 14V4.5L9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2zM9.5 3A1.5 1.5 0 0 0 11 4.5h2V14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h5.5v2z"/>'
									  +'</svg><div class="noti">'+resp+'</div></div>');
						
						}
					},
					error:function(e){
						console.log(e);
					}
				})
				return false; //submit 실행이 안되도록 만든다
			}else if(con == false){ //취소 버튼 누르면 확인창 닫힘
				
				$.ajax({
					url:"/hire/check",
					type:"post",
					success:function(){
					},
					error:function(e){
						console.log(e);
					}
				})
				return false;
			}
		}
	})
})
	
</script>

	<div class="frame">
	
		<!-- 로그아웃일 때 상단바 -->
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
			
			<!-- 로그인일 때 상단바 -->
			<c:if test="${not empty userId}">
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
		</div>
		<!-- //상단바 -->

		<div class="con">
			<div class="content">
				<div id="title">
					<div class="line">
						<span style="font-size: xx-large; font-weight: bold; top:-3px; position: relative;">|</span><span class="position">${detail.hireTitle}</span>
					</div>
						<div class="comName">${detail.companyName}</div>
				</div>

				<div class="hireInfo">
					<div class="condition">
						<div  class="boldT">
							<span style="font-size:large; font-weight: bold; top: -1px; position: relative;">|</span><span>지원 자격</span>
						</div>
						<div class="conContent">
							<div class="grayF">
								<div class="line">경력</div>
								<div class="line">학력</div>
								<div class="line">근무 형태</div>
							</div>
							<div class="blueF">
								<!-- 1이면 경력 2면 신입으로 글자로 바꿔서 출력해주기 -->
								<c:if test="${detail.hireCareer eq 1}">
									<div class="line">경력</div>
								</c:if>
								<c:if test="${detail.hireCareer eq 2}">
									<div class="line">신입</div>
								</c:if>
								<div class="line">${detail.education}</div>
								<div class="line">${detail.workType}</div>
							</div>
						</div>
					</div>
					<div class="workType">
					<div  class="boldT">
						<span style="font-size:large; font-weight: bold; top: -1px; position: relative;">|</span><span>근무 조건</span>
					</div>
						<div class="workContent">
							<div class="grayF">
								<div class="line">급여</div>
								<div class="line">근무 지역</div>
							</div>
							<div class="blueF">
								<div class="line">${detail.salary}</div>
								<div class="line">${detail.workPlace}</div>
							</div>
						</div>
					</div>
				</div>

				<div class="detailImg">
				<div  class="boldT">
					<span style="font-size:large; font-weight: bold; top: -1px; position: relative;">|</span><span>상세 정보</span>
				</div>
					<img id="info" alt="상세이미지"
						src="http://localhost:8080/img/detail/${detail.detailImg}" style="border-radius:10px">
				</div>

				<div class="comInfo">
				<div  class="boldT">
					<span style="font-size:large; font-weight: bold; top: -1px; position: relative;">|</span><span class="boldT">기업 정보</span>
				</div>
					<div class="company">
						<img class="logo" alt="회사 로고"
							src="http://localhost:8080/img/logo/${company.companyLogo}">
						<div class="comInfoCon">
							<div class="comInfoName">${company.companyName}</div>
							<div class="com01">
								<div class="grayF">
									<div class="line">기업 형태</div>
									<div class="line">설립일</div>
	
								</div>
								<div class="blackF">
									<div class="line">${company.companyType}</div>
									<div class="line">${company.startDate}</div>
								</div>
							</div>
							<div class="com02">
								<div class="grayF">
									<div class="line">기업주소</div>
									<div class="line">대표자명</div>
								</div>
								<div class="blackF">
									<div class="line">${company.companyAddress}</div>
									<div class="line">${company.bossName}</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- //comInfo -->
				<!--------------------- 지도 ------------------------------------------------------------>
				<div class="mapInfo">
				<div  class="boldT">
					<span style="font-size:large; font-weight: bold; top: -1px; position: relative;">|</span><span class="boldT">기업 위치</span>
				</div>
					<div class="location">
						<div id="map" style="width: 100%; height: 350px;"></div>


						<script>
						var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
						    mapOption = {
						        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
						        level: 3 // 지도의 확대 레벨
						    };  
						
						// 지도를 생성합니다    
						var map = new kakao.maps.Map(mapContainer, mapOption); 
						
						// 주소-좌표 변환 객체를 생성합니다
						var geocoder = new kakao.maps.services.Geocoder();
						
						// 주소로 좌표를 검색합니다
						geocoder.addressSearch('${company.companyAddress}', function(result, status) {
						
						    // 정상적으로 검색이 완료됐으면 
						     if (status === kakao.maps.services.Status.OK) {
						
						        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
						
						        // 결과값으로 받은 위치를 마커로 표시합니다
						        var marker = new kakao.maps.Marker({
						            map: map,
						            position: coords
						        });
						
						        // 인포윈도우로 장소에 대한 설명을 표시합니다
						        var infowindow = new kakao.maps.InfoWindow({
						            content: '<div style="width:150px;text-align:center;padding:6px 0;">${company.companyName}</div>'
						        });
						        infowindow.open(map, marker);
						
						        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
						        map.setCenter(coords);
						    } 
						});    
						</script>

					</div>
				</div>
			</div>
			<!-- ---------------------------------nav---------------------------------------------- -->

			<div class="nav">
				<div class="nav_content">
					<div class="last_t">남은 기간</div>
					<div class="time">
						<div class="clock"></div>
					</div>
					<div class="date">
						<div class="startDate">
							<div class="s_date">시작일</div>
							<!--받은 값의 패턴을 담은 변수의 포맷 변경-->
							<div>
								<fmt:formatDate value="${startDate}"
									pattern="yyyy-MM-dd hh:mm:ss" />
							</div>
						</div>
						<div class="endDate">
							<div class="e_date">마감일</div>
							<!--받은 값의 패턴을 담은 변수의 포맷 변경-->
							<div>
								<fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd hh:mm:ss" />
							</div>
						</div>
					</div>
					<!-- Button trigger modal -->
					<button id="mo" type="button" class="btn btn-primary">
						지원하기</button>
				</div>
			</div>

			<!-- //nav -->
		</div>
		<!-- //container -->

		<!-------------------------------------------------- Modal -------------------------------------------------------->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<c:if test="${empty userId}">
							
							
							<h4 class="modal-title">회원이 아닙니다.</h4>
						</c:if>
						<c:if test="${not empty userId}">
							<span class="modal-title" id="myModalLabel">${company.companyName}</span>
							<span class="subN">입사지원</span>
						</c:if>
					</div>
					<div class="modal-body">
						<!-- 로그인 여부 판단하기 -->
						<c:if test="${empty userId}">
						<div class="notice_already">
						<svg xmlns="http://www.w3.org/2000/svg" width="70" height="70" fill="#82B6ED" class="bi bi-person-plus" viewBox="0 0 16 16">
						  <path d="M6 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H1s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C9.516 10.68 8.289 10 6 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
						  <path fill-rule="evenodd" d="M13.5 5a.5.5 0 0 1 .5.5V7h1.5a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0V8h-1.5a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5z"/>
						</svg>
							<div class='loginStart'>careerBasket 시작하기!</div>
							<button id="loginBtn" class="btn btn-primary btn-sm" type="button">
								<a href='/user/loginForm' style="top: -3px; position: relative;">로그인</a>
							</button>
							</div>
						</c:if>
						<c:if test="${not empty userId}">
							<div class="doc">제출서류</div>
							<c:choose>
								<c:when test="${count>0}">
									<form>
										<div class="container n_content">
											<select name="title" class="selectpicker" data-live-search="true">
												<option>이력서를 선택하세요.</option>
												<c:forEach var="resume" items="${list}">
													<option>${resume.title}</option>
												</c:forEach>
											</select>
											<div id="parents">
												<div id="children"></div>
											</div>
											<input type="hidden" name="id" value="${detail.id}">
											<input type="hidden" name="companyName"
												value="${detail.companyName}"> <input type="hidden"
												name="userId" value="${userId}">
										</div>
										<button id="apply" type="button"
											class="btn btn-primary btn-lg">지원하기</button>
									</form>
								</c:when>

								<c:when test="${count<=0}">
									<div class="notice_noResume">
										<div class="container n_content">
											<div style="margin-bottom: 10px;">등록된 이력서가 없습니다.</div><div>먼저 이력서를 등록해주세요.</div>
										<button id="resume_apply" class="btn btn-primary btn-sm">
											<a href="/resume/addresume">이력서 등록하기</a>
										</button>
										</div>
									</div>
									<button id="apply_dis" type="button"
										class="btn btn-secondary btn-lg" disabled>지원하기</button>
								</c:when>
							</c:choose>
						</c:if>
					</div>
				</div>
			</div>
		</div>

		<script>
		$('#mo').on('click', function(){
			$('#myModal').modal('show');
			
			});
		
		</script>
	</div>
	<!-- //frame -->
	
</body>
</html>