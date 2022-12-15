<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// URL 파라미터로 전달되는 아이디(id) 와 중복체크결과(isDuplicate) 가져와서 변수에 저장
String id = request.getParameter("id");
boolean isDuplicate = Boolean.parseBoolean(request.getParameter("isDuplicate"));
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function getCheckId() {
		// 만약, 파라미터로 전달받은 id 가 null 이 아니면 아이디 입력란에 해당 아이디 표시
		<%if(id != null) {%>
			document.fr.id.value = "<%=id%>";
			
			// if 문을 사용하여 중복 여부 판별
			// 만약, 파라미터로 전달받은 isDuplicate 값이 true 일 경우 = 아이디 중복
			// => "checkIdResult" 선택자에 "이미 사용중인 아이디" 출력(색상 : RED)
			// 아니면, "사용 가능한 아이디" 출력(색상 : GREEN)
			<%if(isDuplicate == true) {%>
				document.getElementById("checkIdResult").innerHTML = "이미 사용중인 아이디";
				document.getElementById("checkIdResult").style.color = "RED";
			<%} else {%>
				var btn = "<input type='button' value='아이디 사용' onclick='useId()'>";
				document.getElementById("checkIdResult").innerHTML = "사용 가능한 아이디<br>" + btn;
				document.getElementById("checkIdResult").style.color = "GREEN";
			<%}%>
			
		<%}%>	
	}
	
	// 사용 가능한 아이디일 때 아이디 사용 버튼 클릭 시 호출되는 메서드
	function useId() {
		// 부모창(join.jsp)의 ID 입력란에 중복 확인이 완료된 ID 값 표시
// 		window.opener.document.fr.id.value = document.fr.id.value;
		window.opener.document.fr.id.value = "<%=id%>";
		
		// 현재 자식창(check_id.jsp) 닫기
		window.close();
	}
</script>
</head>
<body onload="getCheckId()">
	<h1>ID 중복 체크</h1>
	<form action="check_idPro.jsp" name="fr">
		<input type="text" name="id" required="required">
		<input type="submit" value="중복확인"><br>
		<div id="checkIdResult"></div>
	</form>
</body>
</html>








