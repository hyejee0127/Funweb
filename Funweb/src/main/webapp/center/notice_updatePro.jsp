<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 글번호, 작성자, 패스워드, 제목, 내용 파라미터 가져와서 BoardDTO 객체에 저장
request.setCharacterEncoding("UTF-8");

int num = Integer.parseInt(request.getParameter("num"));
String name = request.getParameter("name");
String pass = request.getParameter("pass");
String subject = request.getParameter("subject");
String content = request.getParameter("content");

// UPDATE 작업에 필요한 데이터를 BoardDTO 객체 생성 후 저장
BoardDTO board = new BoardDTO();
board.setNum(num);
board.setName(name);
board.setPass(pass);
board.setSubject(subject);
board.setContent(content);

// BoardDAO 객체 생성 후 updateBoard() 메서드를 호출하여 게시물 수정 작업 수행
// => 파라미터 : BoardDTO 객체    리턴타입 : int(updateCount)
BoardDAO dao = new BoardDAO();
int updateCount = dao.updateBoard(board);

// 수정 결과 판별
// => 성공 시 글 상세 정보 조회(notice_content.jsp) 으로 이동하고, 
//    실패 시 자바스크립트로 "글 수정 실패" 출력하고 이전 페이지로 돌아가기
if(updateCount > 0) {
	response.sendRedirect("notice_content.jsp?num=" + num);
} else {
	%>
	<script>
		alert("글 수정 실패!");
		history.back();
	</script>
	<%
}
%>












