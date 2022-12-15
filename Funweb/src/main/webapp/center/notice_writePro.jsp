<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// notice_write.jsp 페이지로부터 전달받은 파라미터를 사용하여 funweb.board 테이블에 추가
request.setCharacterEncoding("UTF-8");

String name = request.getParameter("name");
String pass = request.getParameter("pass");
String subject = request.getParameter("subject");
String content = request.getParameter("content");

// INSERT 작업에 필요한 데이터를 BoardDTO 객체 생성 후 저장
BoardDTO board = new BoardDTO();
board.setName(name);
board.setPass(pass);
board.setSubject(subject);
board.setContent(content);

// 데이터베이스 작업을 위한 BoardDAO 객체 생성
BoardDAO dao = new BoardDAO();
// 글쓰기 작업을 수행할 BoardDAO 객체의 insertBoard() 메서드 호출
// => 파라미터 : BoardDTO 객체(board)   리턴타입 : int(insertCount)
int insertCount = dao.insertBoard(board);

// INSERT 작업 수행 결과 판별
if(insertCount > 0) { // 회원가입 성공 시
	response.sendRedirect("notice.jsp");
} else { // 실패 시
	%>
	<script>
		alert("글쓰기 실패!");
		history.back();
	</script>
	<%
}
%>