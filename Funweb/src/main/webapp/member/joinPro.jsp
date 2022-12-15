<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// join.jsp 페이지로부터 전달받은 파라미터를 사용하여 funweb.member 테이블에 추가
// => 추가 성공 시 "joinSuccess.jsp" 로 이동하고
//    실패 시 자바스크립트 사용하여 "회원 가입 실패!" 출력 후 이전페이지로 돌아가기
request.setCharacterEncoding("UTF-8");

String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");
String email = request.getParameter("email");
String post_code = request.getParameter("post_code");
String address1 = request.getParameter("address1");
String address2 = request.getParameter("address2");
String phone = request.getParameter("phone");
String mobile = request.getParameter("mobile");

MemberDTO member = new MemberDTO();
member.setId(id);
member.setPass(pass);
member.setName(name);
member.setEmail(email);
member.setPost_code(post_code);
member.setAddress1(address1);
member.setAddress2(address2);
member.setPhone(phone);
member.setMobile(mobile);

MemberDAO dao = new MemberDAO();
int insertCount = dao.insertMember(member);

if(insertCount > 0) { // 회원가입 성공 시
// 	response.sendRedirect("../main/main.jsp");
	response.sendRedirect("joinSuccess.jsp");
} else { // 실패 시
	%>
	<script>
		alert("회원가입 실패!");
		history.back();
	</script>
	<%
}
%>








