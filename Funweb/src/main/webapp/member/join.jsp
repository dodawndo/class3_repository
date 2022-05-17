<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/join.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script type="text/javascript">

// 아이디 중복확인 여부와 패스워드 확인 결과를 저장할 전역변수 선언
	var checkIdResult = false; var checkPassResult = false; var checkRetypePassResult = false; 
	
	
	
	
	function checkPass(pass) {
		// 패스워드 검사를 위한 정규표현식 패턴 작성 및 검사 결과에 따른 변수값 변경
		var spanElem = document.getElementById("checkPassResult");
		var lengthRegex = /^[A-Za-z0-9!@#$%]{8,16}$/;
		var engUpperRegex = /[A-Z]/;
		var engLowerRegex = /[a-z]/;
		var numRegex = /[0-9]/;
		var specRegex = /[!@#$%]/;
			
		var count = 0;
		
		
		
		if(lengthRegex.exec(pass)) { // 패스워드 규칙 통과 시
// 			spanElem.innerHTML = "사용 가능한 패스워드";
// 			spanElem.style.color = "GREEN";
// 			checkPassResult = true;

			if(engUpperRegex.exec(pass))count++;
			if(engLowerRegex.exec(pass))count++;
			if(numRegex.exec(pass))count++;
			if(specRegex.exec(pass))count++;
			
			switch (count) {
				case 4 : 
					spanElem.innerHTML = "사용 가능한 패스워드 (안전)";
					spanElem.style.color = "GREEN";
					checkPassResult = true;
					break;
					
				case 3 : 
					spanElem.innerHTML = "사용 가능한 패스워드 (보통)";
					spanElem.style.color = "YELLOW";
					checkPassResult = true;
					break;
					
				case 2 : 
					spanElem.innerHTML = "사용 가능한 패스워드 (위험)";
					spanElem.style.color = "ORANGE";
					checkPassResult = true;
					break;
					
				default:
					spanElem.innerHTML = "2가지 이상 조합 필수";
					spanElem.style.color = "RED";
					checkPassResult = false;
			}

		} else {
// 			spanElem.innerHTML = "사용 불가능한 패스워드";
			spanElem.innerHTML = "영문자,숫자,특수문자 조합 8 ~ 16자리 필수";
			spanElem.style.color = "RED";
			checkPassResult = false;
		}
		
	}


function checkRetypePass(pass2){
	// 함수에서 pass와 pass2 의 항목을 비교하여 일치하면 "패스워드 일치"(초록색) 
	// 아니면 "패스워드 불일치" (빨간색) 표시
	// 패스워드 일치 시 checkRetypePassResult 를 true, 아니면 false 로 변경 
	var pass = document.fr.pass.value;

	var spanElem = document.getElementById("checkRetypePassResult");
	// 패스워드 일치 여부 판별
	if(pass == pass2) { // 일치할 경우
		spanElem.innerHTML = "패스워드 일치";
		spanElem.style.color = "GREEN";
		checkRetypePassResult = true;
	} else { // 일치하지 않을 경우
		spanElem.innerHTML = "패스워드 불일치";
		spanElem.style.color = "RED";
		checkRetypePassResult = false;
	}
}

function openCheckIdWindow(){
	window.open("check_id.jsp","","width=400, height=250");
}

function checkSubmit(){
	// 아이디 중복 확인 작업을 통해 아이디를 입력받았고, (checkIdResult == true),
	// 정규표현식을 통해 패스워드 규칙이 올바르고 (checkPassResult == true),
	// 패스워드 확인을 통해 두 패스워드가 동일하면 (checkRetypePassResult == true) true 리턴, 아니면 false 리턴
	// => 아이디 중복 확인 작업과 패스워드 비교 작업 시 성공 여부를 저장할 변수 필요
	//		(이 변수는 다른 메서드에서도 접근 해야하므로 함수 외부에 전역변수로 선언해야함)
	if(checkIdResult == false) { // 아이디 중복확인을 수행하지 않았을 경우
		// alert() 함수를 통해 "중복 확인 필수!" 메세지 출력 후 아이디 창에 포커스 요청
		alert("아이디 중복확인 필수!");
		document.fr.id.focus();
		return false; // 현재 함수 종료
	} else if(checkPassResult == false) { // 패스워드 확인을 수행하지 않았을 경우
		// alert() 함수를 통해 "패스워드 확인 필수!" 메세지 출력 후 아이디 창에 포커스 요청
		alert("올바른 패스워드 확인 필수!");
		document.fr.pass.focus();
		return false; // 현재 함수 종료
	} else if(checkRetypePassResult == false) { // 패스워드 확인을 수행하지 않았을 경우
		// alert() 함수를 통해 "패스워드 확인 필수!" 메세지 출력 후 아이디 창에 포커스 요청
		alert("패스워드 확인 필수!");
		document.fr.pass2.focus();
		return false; // 현재 함수 종료
	}
	
}



</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
            	var addr = '';
            	// 사용자가 선택한 주소타입(도로명/지번)에 따라 해당 값 가져오기
				// 만약 사용자가 도로명 주소를 선택했을 때
				if (data.userSelectedType == 'R') {
					addr = data.roadAddress;
				// 만약 사용자가 구주소를 선택했을 때
				} else {
					addr = data.jibunAddress;
				}
            	document.getElementById('post_code').value = data.zonecode;
                document.getElementById("address1").value = addr;
                
                document.getElementById('address2').focus();
            }
        }).open();
    }
</script>


</head>
<body>z
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- 헤더 들어가는곳 -->
		  
		<!-- 본문들어가는 곳 -->
		  <!-- 본문 메인 이미지 -->
		  <div id="sub_img_member"></div>
		  <!-- 왼쪽 메뉴 -->
		  <nav id="sub_menu">
		  	<ul>
		  		<li><a href="#">Join us</a></li>
		  		<li><a href="#">Privacy policy</a></li>
		  	</ul>
		  </nav>
		  <!-- 본문 내용 -->
		  <article>
		  	<h1>Join Us</h1>
		  	<form action="joinPro.jsp" method="post" id="join" name="fr" onsubmit="return checkSubmit()">
		  		<fieldset>
		  			<legend>Basic Info</legend>
		  			<label>User Id</label>
		  			<input type="text" name="id" class="id" id="id" required="required" readonly="readonly" placeholder="중복체크 버튼 클릭">
		  			<input type="button" value="dup. check" class="dup" id="btn" onclick ="openCheckIdWindow()"><br>
		  			<!-- 버튼 클릭 시 새 창 띄우기(크기 : 350*200, 파일 : check_id.jsp) -->
		  			<label>Password</label>
		  			<input type="password" name="pass" id="pass" onkeyup="checkPass(this.value)" required="required" placeholder="영문,숫자,특수문자 8~16자"> 			
		  			<span id="checkPassResult"></span> <br>
		  			<label>Retype Password</label>
		  			<input type="password" name="pass2" required="required" onkeyup = "checkRetypePass(this.value)">
		  			<span id = "checkRetypePassResult"><!-- 패스워드 일치여부 표시영역 --></span><br>
		  			<!-- pass2 항목에 텍스트 입력할 때마다 자바스크립트의 checkRetypePassResult() 함수 호출 -->
		  			<!-- 함수에서 pass와 pass2 의 항목을 비교하여 일치하면 "패스워드 일치"(초록색) -->
		  			<!-- 아니면 "패스워드 불일치" (빨간색) 표시 -->
		  			
		  			<label>Name</label>
		  			<input type="text" name="name" id="name" required="required"><br>
		  			
		  			<label>E-Mail</label>
		  			<input type="email" name="email" id="email" required="required"><br>
		  		</fieldset>
		  		
		  		<fieldset>
		  			<legend>Optional</legend>
		  			<label>Post code</label>
		  			<input type="text" name="post_code" id="post_code"  placeholder="검색 버튼 클릭" readonly="readonly"> 
		  			<input type="button" value="우편번호 검색" onclick="sample4_execDaumPostcode()" class="dup"><br>
<!-- <span id="guide" style="color:#999;display:none"></span> -->
		  			<label>Address</label>
		  			<input type="text" name="address1" id="address1" readonly="readonly"> 
		  			<input type="text" name="address2" id="address2" placeholder="상세주소 입력"><br>
		  			<label>Phone Number</label>
		  			<input type="text" name="phone" ><br>
		  			<label>Mobile Phone Number</label>
		  			<input type="text" name="mobile" ><br>
		  		</fieldset>
		  		<div class="clear"></div>
		  		<div id="buttons">
		  			<input type="submit" value="Submit" class="submit">
		  			<input type="reset" value="Cancel" class="cancel">
		  		</div>
		  	</form>
		  </article>
		  
		  
		<div class="clear"></div>  
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp"/>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


