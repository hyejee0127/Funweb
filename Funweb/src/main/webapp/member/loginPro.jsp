<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 폼 파라미터로 전달받은 아이디, 패스워드 가져오기
String id = request.getParameter("id");
String pass = request.getParameter("pass");

MemberDTO member = new MemberDTO();
member.setId(id);
member.setPass(pass);

MemberDAO dao = new MemberDAO();
boolean isLoginSuccess = dao.loginMember(member);

if(isLoginSuccess) { // 로그인 성공
	// 세션 객체(session)에 로그인 성공한 아이디를 "sId" 라는 속성명으로 저장 후 메인페이지로 이동
	session.setAttribute("sId", id);
	response.sendRedirect("../main/main.jsp");
} else { // 로그인 실패
	%>
	<script>
		alert("로그인 실패!");
		history.back();
	</script>
	<%
}
%>

















 

