<%@page import="board.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int num = Integer.parseInt(request.getParameter("num"));

// 세션 아이디 저장
String sId = (String)session.getAttribute("sId");

if(sId == null) {
	%>
	<script>
		alert("댓글 삭제 실패!");
		history.back();
	</script>
	<%
}

// ReplyDAO 객체 생성 후 deleteReply() 메서드를 호출하여 댓글 삭제
// => 파라미터 : 글번호(num), 세션아이디(sId)  리턴타입 : int(deleteCount)
ReplyDAO dao = new ReplyDAO();
int deleteCount = dao.deleteReply(num, sId);

// 댓글 삭제 결과 판별 
// => 실패 시 자바스크립트 사용하여 "댓글 삭제 실패!" 출력 후 이전페이지로 돌아가기
// => 성공 시 notice_content.jsp 로 이동
if(deleteCount > 0) {
	// 주의! 파라미터로 전달할 글번호는 댓글번호가 아닌 원본글 번호 전달
	response.sendRedirect("notice_content.jsp?num=" + request.getParameter("refNum"));
} else {
	%>
	<script>
		alert("댓글 삭제 실패!");
		history.back();
	</script>
	<%
}

%>








