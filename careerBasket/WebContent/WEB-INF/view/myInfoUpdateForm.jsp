<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	$("input[type=submit]").prop("disabled",true);	//수정하기 버튼 비활성화
	//성별값에 체크
	if("${info.sex}"!=""){
		$("input[value='${info.sex}']").prop("checked", true);
	}
	//이메일 값을 선택
	if("${emailEnd}"!=""){
		$("select[name=emailEnd]").val("${emailEnd}");
	}
	
	//비밀번호 재입력하고 마우스가 폼에서 떠나면 전에 입력한 비밀번호와 일치한지 확인
	$("input[name=rePassword]").blur(function(){
		var pw1 = $("input[name=password]").val();
		var pw2 = $("input[name=rePassword]").val();
		
		if(pw1 == "" || pw2 == ""){		//비밀번호를 입력하지 않았을 때
			$("#pwCheck").text("비밀번호를 입력해주세요");
			return false;
		}
		if(pw1 == pw2){
			$("#pwCheck").text("비밀번호가 동일합니다.");
			$("input[type=submit]").prop("disabled",false);
		}else{
			$("#pwCheck").text("비밀번호가 다릅니다. 다시 입력해주세요");
			$("input[type=submit]").prop("disabled",true);
		}
	})
	
	//이메일 중복 확인
	$("#emailCheck").on("click", function(){
		var email_start = $("input[name=emailStart]").val();
		var email_end = $("select[name=emailEnd] option:selected").val();	//option:selected 선택된 값 가져오기
		var email = email_start + "@" + email_end;
		$.ajax({
			url:"${pageContext.request.contextPath}/user/emailCheck?email="+email,
			type:"get",
			success:function(resp){
				if(resp >= 1){
					$("#dupEmailCheck").text("이메일이 중복되었습니다. 다시 입력해주세요.");
					$("input[type=submit]").prop("disabled",true);
				}else if(resp == 0){
					$("#dupEmailCheck").text("이메일 사용이 가능합니다.");
					$("input[type=submit]").prop("disabled",false);
				}
			},
			error:function(e){
				console.log(e);
			}
		})
		return false;	
	})
	
	//중복 확인 메세지가 없다면 가입하기 버튼 비활성화
		if($("span[id=dupIdCheck]").text() == "" || $("span[id=dupEmailCheck]").text() == ""){
			
			$("input[type=submit]").prop("disabled",true);		//가입하기 버튼 비활성화
		}
})
</script>
<title>myInfoUpdateForm.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="/css/myInfoUpdateForm.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400&display=swap" rel="stylesheet">
</head>
<body>
<div id="info_form_wrapper">
<form action="/resume/userInfoUpdate" method="post">
<input type="hidden" name="userId" value="${info.userId }">
<div class="badge bg-primary text-wrap" style="width: 100%;">* 정보를 수정하실때는 비밀번호를 입력해주셔야 저장이 가능합니다 *</div>
 <div class="mb-3 row">
   <label for="staticUserId" class="col-sm-2 col-form-label">아이디</label>
   <div class="col-sm-10">
     <input type="text" readonly class="form-control-plaintext" id="staticUserId" value="${info.userId }">
   </div>
 </div>
<!-- -----------------------------------------비밀번호------------------------------------------------------- -->
 <div class="mb-3 row">
   <label for="inputPassword" class="col-sm-2 col-form-label">비밀번호</label>
   <div class="col-sm-10">
     <input type="password" id="inputPassword" name="password" value="${info.password }">
   </div>
 </div>
<!-- -----------------------------------------비밀번호확인------------------------------------------------------- -->
 <div class="mb-3 row">
   <label for="rePassword" class="col-sm-2 col-form-label">비밀번호 확인</label>
   <div class="col-sm-10">
     <input id="rePassword" type="password" name="rePassword" value="${info.password }"><br>
     <span id="pwCheck" class="message" style="font-size: 12px;"></span>
   </div>
 </div>
<!-- -----------------------------------------이름------------------------------------------------------- -->
 <div class="mb-3 row">
   <label for="inputName" class="col-sm-2 col-form-label">이름</label>
   <div class="col-sm-10">
     <input type="text" class="form-control" id="inputName" name="name" value="${info.name }">
   </div>
 </div>
<!-- -----------------------------------------생년월일------------------------------------------------------- -->  
 <div class="mb-3 row">
   <label for="inputBirth" class="col-sm-2 col-form-label">생년월일</label>
   <div class="col-sm-10">
     <input type="date" style="width: 40%;" class="form-control" id="inputBirth" name="birthDate" value="${info.birthDate }">
   </div>
 </div>
<!-- -----------------------------------------성별------------------------------------------------------- -->
 <div class="mb-3 row">
   <label for="inputBirth" class="col-sm-2 col-form-label">성별</label>
   <div class="col-sm-10" style="line-height: 2.6rem;">
     <input type="radio" name="sex" value="여자">  여자 <input type="radio" name="sex" value="남자">  남자 
   </div>
 </div>
 
<!-- -----------------------------------------이메일------------------------------------------------------- -->

<div class="mb-3 row">
   <label for="inputEmail" class="col-sm-2 col-form-label">이메일주소</label>
   <div class="col-sm-10">
     <div class="input-group mb-3">
	  <input type="text" class="form-control" id="inputEmail" name="emailStart" value="${emailStart}">
	  <span class="input-group-text">@</span>
	  <select class="form-select" name="emailEnd">
		  <option selected>선택</option>
		  <option value="naver.com">naver.com</option>
		  <option value="gmail.com">gmail.com</option>
	  </select>
	  <button type="button" id="emailCheck" class="btn btn-outline-primary" class="message">중복확인</button>
	 </div>
	 <div class="input-group mb-3">
	 <span id="dupEmailCheck" class="message"  style="font-size: 12px;"></span>
	 </div>
   </div>
 </div>

<!-- -----------------------------------------전화번호------------------------------------------------------- -->

 <div class="mb-3 row">
   <label for="inputTel" class="col-sm-2 col-form-label">전화번호</label>
   <div class="col-sm-10">
     <input type="text" class="form-control" id="inputTel" name="tel" value="${info.tel }">
   </div>
 </div>

<!-- ---------------------------------------------------주소------------------------------------------------- -->

 <div class="mb-3 row">
   <label for="inputaAddress" class="col-sm-2 col-form-label">기존주소</label>
   <div class="col-sm-10">
     <input type="text" class="form-control" id="inputaAddress" name="address" value="${info.address }" readonly="readonly"><br>
     <span style="font-size:12px;">*입력된 주소가 맞지 않다면 밑에 다시 입력해주세요*</span>
   </div>
 </div>

 <div class="mb-3 row">
   <label for="postCode" class="col-sm-2 col-form-label">새 주소</label>
   <div class="col-sm-10">
	   <div class="row" style="margin-bottom:2%">
		  <div class="col">
		  	 <input type="text" class="form-control" id="postCode" name="post" placeholder="우편번호">
		  </div>
		  <div class="col">
		    <button id="searchAddr" type="button" class="btn btn-outline-primary form-control" onclick="searchAddress()">우편번호 찾기</button>
		  </div>
		 </div>
		 <div class="row" style="margin-bottom:2%">
		 	<div class="col">
		  	 <input type="text" class="form-control" name="addr" id="address" placeholder="주소">
		 	</div>
		 </div>
		 <div class="row" style="margin-bottom:2%">
		  <div class="col">
		  	 <input type="text" class="form-control" name="detailAddr" id="detailAddress" placeholder="상세주소">
		  </div>
		  <div class="col">
		    <input type="text" class="form-control" name="extraAddr" id="extraAddress" placeholder="참고항목">
		  </div>
		</div>
	</div>
 </div>
 
<!-- -------------------------------------------------------주소 API---------------------------------------------------- -->
<div id="section">
	<!-- 주소검색 div를 주소 폼 밑에 띄어줌. -->
	<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative; margin-left: 382px">	
	<!-- 닫기 버튼 -->
	<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="닫기 버튼">
	</div>
	
	<!-- 다음 주소 오픈 api 사용 -->
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    // 우편번호 찾기 화면을 넣을 element
	    var element_wrap = document.getElementById('wrap');
	
	    
	    function foldDaumPostcode() {	//닫기버튼 눌렀을 때
	        // iframe을 넣은 element를 안보이게 한다.
	        element_wrap.style.display = 'none';
	    }
	 
	    //주소 검색
	    function searchAddress() {
	        // 현재 scroll 위치를 저장해놓는다.
	        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('postCode').value = data.zonecode;
	                document.getElementById("address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("detailAddress").focus();
	
	                // iframe을 넣은 element를 안보이게 한다.
	                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
	                element_wrap.style.display = 'none';
	
	                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
	                document.body.scrollTop = currentScroll;
	            },
	            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
	            onresize : function(size) {
	                element_wrap.style.height = size.height+'px';
	            },
	            width : '100%',
	            height : '100%'
	        }).embed(element_wrap);
	
	        // iframe을 넣은 element를 보이게 한다.
	        element_wrap.style.display = 'block';
	    }
	</script>
	<hr>
	<input type="submit" value="기본정보 수정" class="btn btn-outline-primary" style="margin-left: 35%;">
</div>
</form>
</div>
</body>
</html>