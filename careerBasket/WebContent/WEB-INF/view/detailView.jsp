<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detailView.jsp</title>
<link rel="stylesheet" type="text/css" href="/css/header.css">
<link rel="stylesheet" type="text/css" href="/css/detail.css">
<link rel="stylesheet" type="text/css" href="/css/imgstyle.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- services 라이브러리 불러오기 -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f92552f56d0252119d785ec6db2f5b73&libraries=services"></script>

</head>
<body>

	<!-- 마감일 형식바꾸기 -->
	<fmt:parseDate var="endDate" value="${detail.endDate}"
		pattern="yyyy-MM-dd'T'HH:mm" />
	<fmt:formatDate var="eDate" value="${endDate}" pattern="yyyyMMddHHmmss" />
	<fmt:parseDate var="startDate" pattern="yyyy-MM-dd'T'HH:mm"
		value="${detail.startDate}" />

	<script>
	
	function open_modal(){
		$('#myModal').show(); 
		if("${userId}" == ""){
			$('.modal-content').children().remove();
			$('.modal-content').append("<div>로그인을 해주세요</div>");
			$('.modal-content').append("<button><a href='/user/loginForm'>로그인</a></button>");
		}
		
	};
	
	function close_modal(){
		$('#myModal').hide(); //팝업 close기능
	};
	
$(function(){
	
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
	$("form").on("submit",function(){ 
		var titleData = $('form [name="title"]').val();
		console.log(titleData);
		
		if(titleData == "이력서를 선택하세요"){//이력서 선택이 안되어 있으면 "이력서를 선택해주세요"문구 띄우기
			
			$.ajax({
				url:"/hire/check",
				type:"post",
				success:function(){
					$("#parents").children().remove();
					$("#parents").append("<h1 class='notice_re'>이력서를 선택해주세요</h1>");
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
						
						$('.modal-content').children().remove();
						$('.modal-content').append("<div class='notice_already'><div class='noti'>"+resp+"</div></div>");
						
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
		<!-- 상단바 -->
		<div class="top">
			<div class="top_left">
				<a style="color: #82B6ED" href="/user/main?userId=${userId}">careerBasket</a>
			</div>
			<!-- 로고 -->
			<div class="top_middle">
				<a href="/hire/list?userId=${userId}">탐색</a> <a
					href="/resume/addresume?userId=${userId}">이력서</a>
			</div>
			<div class="top_right">
				<div class="ms">${userId}님의취업을응원합니다!</div>
				<button class="logOut">
					<a href="/user/logout">로그아웃</a>
				</button>
			</div>
		</div>
		<!-- //상단바 -->

		<div class="container">
			<div class="content">
				<div class="title">
					<div class="position">${detail.hireTitle}</div>
					<div class="comName">${detail.companyName}</div>
				</div>

				<div class="hireInfo">
					<div class="condition">
						<div class="boldT">지원 자격</div>
						<div class="conContent">
							<div class="grayF">
								<div>경력</div>
								<div>학력</div>
								<div>근무 형태</div>
							</div>
							<div class="blueF">
								<div>${detail.hireCareer}</div>
								<div>${detail.education}</div>
								<div>${detail.workType}</div>
							</div>
						</div>
					</div>
					<div class="workType">
						<div class="boldT">근무 조건</div>
						<div class="workContent">
							<div class="grayF">
								<div>급여</div>
								<div>근무 지역</div>
							</div>
							<div class="blueF">
								<div>${detail.salary}</div>
								<div>${detail.workPlace}</div>
							</div>
						</div>
					</div>
				</div>

				<div class="detailImg">
					<div class="boldT">상세 정보</div>
					<img id="info" alt="상세이미지"
						src="http://localhost:8080/img/detail/${detail.detailImg}">

				</div>

				<div class="comInfo">
					<div class="boldT">기업 정보</div>
					<div class="company">
						<img class="logo" alt="회사 로고"
							src="http://localhost:8080/img/logo/${company.companyLogo}">
						<div class="name">${company.companyName}</div>
						<div class="com01">
							<div class="grayF">
								<div>기업 형태</div>
								<div>설립일</div>

							</div>
							<div class="blackF">
								<div>${company.companyType}</div>
								<div>${company.startDate}</div>
							</div>
						</div>
						<div class="com02">
							<div class="grayF">
								<div>기업주소</div>
								<div>대표자명</div>
							</div>
							<div class="blackF">
								<div>${company.companyAddress}</div>
								<div>${company.bossName}</div>
							</div>
						</div>
					</div>
				</div>
				<!-- //comInfo -->
				<!--------------------- 지도 ------------------------------------------------------------>
				<div class="mapInfo">
					<div class="boldT">기업 위치</div>
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
					<div onclick="open_modal();">지원하기</div>

				</div>
			</div>

			<!-- //nav -->
		</div>
		<!-- //container -->

		<div id="myModal" class="modal">
			<div class="mModal_box">
				<div class="close_bt" onclick="close_modal();">X</div>
				<div class="modal-content">
					<div class="m-content">
						<span class="name">${company.companyName}</span> <span>입사지원</span>
						<br>
						<div class="doc">제출서류</div>
						<br>
						<!-- 지원서 개수 받아와서 비교후 생성 -->
						<c:choose>
							<c:when test="${count>0}">
									<form>
										<!-- action,method 없애도 됨 ajax로 보낼꺼니까 -->
									<div class="notice_noResume">
										<select class="resume_check" name="title">
											<option>이력서를 선택하세요</option>
											<c:forEach var="resume" items="${list}">
												<option>${resume.title}</option>
											</c:forEach>
										</select>
										<div id="parents">
											<div id="children"></div>
										</div>
										<input type="hidden" name="id" value="${detail.id}"> <input
											type="hidden" name="companyName"
											value="${detail.companyName}"> <input type="hidden"
											name="userId" value="${userId}">
									</div>
									<input id="apply"
											class="blue_btn" type="submit" value="지원하기">
									</form>
								<!-- 지원하기 버튼(submit) 누르면 선택한 데이터와 필요한 값들 컨트롤러로 넘겨서 DB에 저장하고 해당 이력서 사진을 폴더에 저장 -->
							</c:when>

							<c:when test="${count<=0}">
								<div class="notice_noResume">
									<div class="n_content">
										등록된 이력서가 없습니다.<br> <br>먼저 이력서를 등록해주세요.
									</div>
									<button class="resumeBtn">
										<a href="/resume/addresume">이력서 등록하기</a>
									</button>
								</div>
								<button class="gray_btn">
									<a>지원하기</a>
								</button>
							</c:when>
						</c:choose>

					</div>
				</div>
			</div>
		</div>

	</div>
	<!-- //frame -->
</body>
</html>