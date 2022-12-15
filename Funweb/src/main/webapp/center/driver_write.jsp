<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/driver_write.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%
	// 세션에 저장된 아이디가 null 이면 자바스크립트를 통해 "회원만 접근 가능합니다" 출력 후 돌아가기
	String id = (String)session.getAttribute("sId");
	
	if(id == null) {
		%>
		<script>
			alert("회원만 접근 가능합니다!");
			history.back();
		</script>
		<%
	}
	%>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더 들어가는곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<div id="sub_img_center"></div>
		<!-- 왼쪽 메뉴 -->
		<jsp:include page="../inc/left.jsp"></jsp:include>
		<!-- 본문 내용 -->
		<article>
			<h1>Driver Write</h1>
			<!-- 파일 업로드 기능을 위해서는 form 태그에 enctype="multipart/form-data" 속성 추가 -->
			<!-- 속성을 지정하지 않으면 모든 데이터는 문자열로 전송되므로 파일도 파일명만 전송됨 -->
			<!-- 주의! 속성 지정 시 파라미터 가져오는 request.getParameter() 사용 불가! -->
			<form action="driver_writePro.jsp" method="post" enctype="multipart/form-data">
				<table id="notice">
					<tr>
						<td>글쓴이</td>
						<!-- 작성자 이름은 세션 아이디로 고정하기 -->
						<td><input type="text" name="name" value="<%=id %>" required="required" readonly="readonly"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="pass" required="required"></td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input type="text" name="subject" required="required"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea rows="10" cols="20" name="content" required="required"></textarea></td>
					</tr>
					<tr>
						<td>파일</td>
						<!-- 파일 업로드를 위해 "file" 타입 지정 -->
						<td><input type="file" name="original_file" required="required"></td>
					</tr>
				</table>

				<div id="table_search">
					<input type="submit" value="글쓰기" class="btn">
				</div>
			</form>
			<div class="clear"></div>
		</article>


		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


