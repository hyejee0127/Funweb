<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");

String sId = (String)session.getAttribute("sId");

String driver = "com.mysql.cj.jdbc.Driver"; // 드라이버 클래스
String url = "jdbc:mysql://localhost:3306/funweb"; // DB 접속 정보
String user = "root"; // 계정명
String password = "1234"; // 패스워드

// 1단계. 드라이버 클래스 로드
Class.forName(driver);
	
// 2단계. DB 연결
// => 연결 성공 시 리턴되는 Connection 타입 객체를 java.sql.Connection 타입으로 저장
Connection con = DriverManager.getConnection(url, user, password);
	

// 3단계. SQL 구문 작성 및 전달
// => idx 가 일치하는 레코드 조회
String sql = "SELECT * FROM member WHERE id=?";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setString(1, sId);

// 4단계. SQL 구문 실행 및 결과 처리
ResultSet rs = pstmt.executeQuery();

if(rs.next()) { // 조회 결과가 존재할 경우
%>	


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
	  	<h1>회원정보 수정</h1>
	  	<form action="joinPro.jsp" method="post" id="join" name="fr">
	  		<fieldset>
	  			<legend>Basic Info</legend>
	  			<label>User Id</label>
	  			<input type="text" name="id" class="id" id="id" value="<%=rs.getString("id")%>">
	  			<input type="button" value="dup. check" class="dup" id="btn"><br>
	  			
	  			<label>Name</label>
	  			<input type="text" name="name" id="name" value="<%=rs.getString("name")%>"><br>
	  			
	  			<label>E-Mail</label>
	  			<input type="email" name="email" id="email" value="<%=rs.getString("email")%>"><br>
	  			
	  		</fieldset>
	  		
	  		<fieldset>
	  			<legend>Optional</legend>
	  			<label>Address</label>
	  			<input type="text" name="address1" value="<%=rs.getString("address1")%>"> <input type="text" name="address2" value="<%=rs.getString("address2")%>"><br>
	  			<label>Phone Number</label>
	  			<input type="text" name="phone" value="<%=rs.getString("phone")%>"><br>
	  			<label>Mobile Phone Number</label>
	  			<input type="text" name="mobile" value="<%=rs.getString("mobile")%>"><br>
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
<%
}
%>
</body>
</html>