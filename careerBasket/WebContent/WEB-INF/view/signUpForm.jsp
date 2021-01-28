<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>signUpForm.jsp</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){ 	//로드가 끝났다면
		$("#signUp").prop("disabled",true);	//가입하기 버튼 비활성화
		
		//아이디 중복체크
		$("#idCheck").on("click", function(){	
			var user_id = $("input[name=userId]").val();
			if(user_id == ""){	//val()은 '값' 이므로 객체가 아니므로 equals() 함수가 없음.
				$("#dupIdCheck").text("아이디를 입력해주세요");
				$("#signUp").prop("disabled",true);
				return false;	//return false를 해줘야 밑에서 덮어쓰기가 안됨.
			}
			$.ajax({
				url:"${pageContext.request.contextPath}/user/idCheck?userId="+user_id,
				type:"get",
				success:function(resp){
					if(resp == 1){		//count가 1이면 중복
						$("#dupIdCheck").text("아이디가 중복되었습니다.");
						$("#signUp").prop("disabled",true);
					}else if(resp == 0){
						$("#dupIdCheck").text("입력한 아이디는 사용 가능합니다.");
						$("#signUp").prop("disabled",false);
					}
				},
				error:function(e){
					console.log(e);
				}
			})
			return false;	//ajax로 요청하고 form에서는 요청 못하게 하기위해서
		})
		
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
				$("#signUp").prop("disabled",false);
			}else{
				$("#pwCheck").text("비밀번호가 다릅니다. 다시 입력해주세요");
				$("#signUp").prop("disabled",true);
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
						$("#signUp").prop("disabled",true);
					}else if(resp == 0){
						$("#dupEmailCheck").text("이메일 사용이 가능합니다.");
						$("#signUp").prop("disabled",false);
					}
				},
				error:function(e){
					console.log(e);
				}
			})
			return false;	
		})	
		
		//상세주소 입력란에 마우스 커서가 왔을때,
		//모든 입력사항에 입력이 안되어있고,
		//중복 확인 메세지가 없다면 가입하기 버튼 비활성화
		$("#detailAddress").focus(function(){
			if($("input[name=userId]").val() == "" || $("input[name=password]").val() == "" || $("input[name=rePassword]").val() == "" ||
				$("input[name=name]").val() == "" || $("input[name=birthDate]").val() == "" || $("input[name=sex]:checked").val() == "" ||
				$("input[name=emailStart]").val() == "" || $("select[name=emailEnd] option:selected").val() == "" || $("input[name=tel]").val() == "" ||
				$("input[name=post]").val() == "" || $("input[name=addr]").val() == "" || 
				$("span[id=dupIdCheck]").text() == "" || $("span[id=dupEmailCheck]").text() == ""){
				
				$("#signUp").prop("disabled",true);		//가입하기 버튼 비활성화
			}
		})
		
	})
	
</script>
</head>     
<body>
	<h1>회원가입</h1>
	<h5>*필수입력사항</h5> <hr>
	<form action="/user/signup" method="post">
		아이디*  <input type="text" name="userId" placeholder="아이디를 입력해주세요"> 
			   <button type="button" id="idCheck">중복확인</button>
		<span id="dupIdCheck"></span> <br>
		비밀번호* <input type="password" name="password" placeholder="비밀번호를 입력해주세요"> <br>
		비밀번호 확인* <input type="password" name="rePassword" placeholder="비밀번호를 한번 더 입력해주세요"> 
		<span id="pwCheck"></span><br>
		이름* <input type="text" name="name" placeholder="이름을 입력해주세요"> <br>
		생일* <input type="date" name="birthDate"> <br>
		성별* <input type="radio" name="sex" value="남자">남자
			 <input type="radio" name="sex" value="여자">여자 <br>
		이메일주소* <input type="text" name="emailStart">@
				 	<select name="emailEnd">
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option> 	
				 	</select>
				 	<button type="button" id="emailCheck">중복확인</button>
		<span id="dupEmailCheck"></span> <br>
		전화번호* <input type="text" name="tel" placeholder="예: 010-####-####"> <br>
		주소* 	<input type="text" name="post" id="postCode" placeholder="우편번호">
				<button id="searchAddr" type="button" onclick="searchAddress()">우편번호 찾기</button> <br>		<!-- type="button"을 안해주면 무조건 그냥 submit 해버리기 때문에 추가함. -->
				<input type="text" name="addr" id="address" placeholder="주소"><br>
				<input type="text" name="detailAddr" id="detailAddress" placeholder="상세주소">
				<input type="text" name="extraAddr" id="extraAddress" placeholder="참고항목"> 	<!-- 도로명 주소일 때 : OO동을 써줌 -->
				
				<!-- 주소검색 div를 주소 폼 밑에 띄어줌. -->
				<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">	
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
		<input id="signUp" type="submit" value="가입하기">
	</form>
</body>
</html>