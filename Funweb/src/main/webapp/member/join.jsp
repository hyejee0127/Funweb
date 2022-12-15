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
	function checkId() {
		// check_id.jsp 페이지를 새 창으로 열기(가로 : 400, 세로 : 200)
		window.open("check_id.jsp", "ID중복확인", "width=400,height=200");
	}
	// -----------------------------------------------------
	// 패스워드 일치 여부를 저장할 변수 선언(checkRetypePassword() 함수에서 변경)
	// => 여러 함수에서 사용하므로 전역 변수로 선언 필요
	var isSamePass = false; // true : 일치, false : 불일치
	
	function checkForm() {
		// 아이디, 패스워드, 패스워드 확인, 이름, 이메일란이 모두 입력됐을 경우
		// submit 동작을 수행(true 리턴), 그렇지 않으면 submit 동작을 취소(false 리턴)
		// => 단, required 속성이 설정되어 있을 경우 불필요
		
		// 지금은 임시로 아이디가 입력되어 있고, 두 패스워드가 서로 일치할 경우 submit 동작 수행
		// => 아이디가 없거나, 일치하지 않을 경우 해당 항목에 대한 경고창 표시 후 중단
		// 1) 두 패스워드를 가져와서 직접 비교하는 방법
// 		if(document.fr.id.value == "") { 
// 			alert("아이디 입력 필수!");
// 			document.fr.id.focus();
// 			return false;
// 		} else if(document.fr.pass.value != document.fr.pass2.value) {
// 			alert("패스워드가 일치하지 않습니다!");
// 			document.fr.pass.select();
// 			return false;
// 		}
		
		// 2) 두 패스워드 비교 결과를 저장한 변수를 사용하여 판별하는 방법 
		if(document.fr.id.value == "") { 
			alert("아이디 입력 필수!");
			document.fr.id.focus();
			return false;
		} else if(!isSamePass) {
			alert("패스워드가 일치하지 않습니다!");
			document.fr.pass.select();
			return false;
		}
		
		return true;
	}
	
	// 패스워드 확인란 입력할 때마다 자동으로 호출되어
	// 패스워드란에 입력된 패스워드와 비교 후 일치 여부를 "retypePasswordResult" 영역에 출력
	// "패스워드 일치"(초록색), "패스워드 불일치"(빨간색)
	function checkRetypePassword() {
		// 기존 패스워드(pass, pass2) 가져와서 변수에 저장
		var pass = document.fr.pass.value;
		var pass2 = document.fr.pass2.value;
		
		if(pass == pass2) { // 두 패스워드가 일치할 경우 
			document.getElementById("retypePasswordResult").innerHTML = "패스워드 일치";
			document.getElementById("retypePasswordResult").style.color = "GREEN";
			
			// 패스워드 일치 여부를 true 로 변경
			isSamePass = true;
		} else {
			document.getElementById("retypePasswordResult").innerHTML = "패스워드 불일치";
			document.getElementById("retypePasswordResult").style.color = "RED";
			
			// 패스워드 일치 여부를 false 로 변경
			isSamePass = false;
		}
	}
	
</script>
<!-- 다음 주소 API 사용을 위한 코드 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                // => 간단하게 도로명 주소를 무조건 사용
                document.getElementById('post_code').value = data.zonecode; // 우편번호
                document.getElementById("address1").value = data.roadAddress; // 주소(도로명 주소)
                
				document.getElementById("address2").focus();                
            }
        }).open();
    }
</script>
<!-- ============================== -->
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp"></jsp:include>
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
		  	<form action="joinPro.jsp" method="post" id="join" name="fr" onsubmit="return checkForm()">
		  		<fieldset>
		  			<legend>Basic Info</legend>
		  			<label>User Id</label>
		  			<input type="text" name="id" class="id" id="id" placeholder="중복확인 클릭" required="required" readonly="readonly">
		  			<input type="button" value="dup. check" class="dup" id="btn" onclick="checkId()"><br>
		  			
		  			<label>Password</label>
		  			<input type="password" name="pass" id="pass" required="required"
		  					onchange="checkRetypePassword()"><br> 			
		  			
		  			<label>Retype Password</label>
		  			<input type="password" name="pass2" required="required" 
		  					onkeyup="checkRetypePassword()">
		  			<span id="retypePasswordResult"></span><br>
		  			
		  			<label>Name</label>
		  			<input type="text" name="name" id="name" required="required"><br>
		  			
		  			<label>E-Mail</label>
		  			<input type="email" name="email" id="email" required="required"><br>
		  		</fieldset>
		  		
		  		<fieldset>
		  			<legend>Optional</legend>
		  			<label>Post Code</label>
		  			<input type="text" name="post_code" id="post_code" placeholder="우편번호">
		  			<button onclick="execDaumPostcode()">주소검색</button><br>
		  			<label>Address</label>
		  			<input type="text" name="address1" id="address1" placeholder="주소">
					<input type="text" name="address2" id="address2" placeholder="상세주소"><br>
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
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


