<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 세션 아이디("sId" 속성값) 가져오기
String id = (String)session.getAttribute("sId"); // Object -> String 다운캐스팅(= 형변환)
%>
<script>
	function confirm_logout() {
		// confirm dialog 를 활용하여 "로그아웃 하시겠습니까?" 질문 처리
		var result = confirm("로그아웃 하시겠습니까?");
		
		// 예(true)일 경우 logout.jsp 페이지로 이동
		if(result) {
			location.href = "../member/logout.jsp";
		}
	}
</script>

<header>
  <!-- login join -->
  <div id="login">
  	<!-- 
  	세션 아이디("sId") 가 존재하지 않을 경우(= null) login 과 join 링크 표시하고
  	아니면, 세션 아이디와 logout 링크 표시
  	(단, 세션 아이디가 관리자일 경우 logout 링크 옆에 관리자페이지 링크 표시)
  	-->
  	<%if(id == null) { %>
		<a href="../member/login.jsp">login</a> | <a href="../member/join.jsp">join</a>
	<%} else { %>
		<!-- 로그아웃(logout) 링크 클릭 시 자바스크립트 함수 호출 -->
		<%=id %> 님 | <a href="javascript:confirm_logout()">logout</a>
		<!-- 아이디가 "admin" 일 경우 관리자 페이지 링크 표시 -->
		<%if(id.equals("admin")) { %>
			| <a href="../admin/adminMain.jsp">관리자페이지</a>
		<%} %>
	<%} %>
  </div>
  <div class="clear"></div>
  <!-- 로고들어가는 곳 -->
  <div id="logo"><img src="../images/logo.gif"></div>
  <!-- 메뉴들어가는 곳 -->
  <nav id="top_menu">
  	<ul>
  		<li><a href="../main/main.jsp">HOME</a></li>
  		<li><a href="../company/welcome.jsp">COMPANY</a></li>
  		<li><a href="../company/welcome.jsp">SOLUTIONS</a></li>
  		<li><a href="../center/notice.jsp">CUSTOMER CENTER</a></li>
  		<li><a href="../mail/mailForm.jsp">CONTACT US</a></li>
  	</ul>
  </nav>
</header>