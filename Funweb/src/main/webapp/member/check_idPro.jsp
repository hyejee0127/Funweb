<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 아이디(id) 파라미터 가져오기
String id = request.getParameter("id");

// MemberDAO 객체 생성 후 checkId() 메서드를 호출하여 아이디 중복 확인
// => 파라미터 : 아이디(id)    리턴타입 : boolean(isDuplicate)
MemberDAO dao = new MemberDAO();
boolean isDuplicate = dao.checkId(id);

// check_id.jsp 페이지로 포워딩(파라미터 : 아이디(id), 중복확인결과(isDuplicate))
response.sendRedirect("check_id.jsp?id=" + id + "&isDuplicate=" + isDuplicate);

%>