<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 글번호(num) 파라미터 가져오기
int num = Integer.parseInt(request.getParameter("num"));

// BoardDAO 객체 생성 후 게시물 상세 정보 조회를 위해 selectBoard() 메서드 호출(메서드 재사용)
// => 파라미터 : 글번호    리턴타입 : BoardDTO(board)
BoardDAO dao = new BoardDAO();
BoardDTO board = dao.selectBoard(num);
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice_update.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
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
			<h1>Notice Update</h1>
			<form action="notice_updatePro.jsp" method="post">
				<!-- 입력받지 않은 글번호도 함께 전달 -->
				<input type="hidden" name="num" value="<%=request.getParameter("num")%>">
				<table id="notice">
					<tr>
						<td>글쓴이</td>
						<td><input type="text" name="name" value="<%=board.getName()%>" required="required"></td>
					</tr>
					<tr>
						<td>패스워드</td>
						<td><input type="password" name="pass" required="required"></td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input type="text" name="subject" value="<%=board.getSubject()%>" required="required"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea rows="10" cols="20" name="content" required="required"><%=board.getContent() %></textarea></td>
					</tr>
				</table>

				<div id="table_search">
					<input type="submit" value="글수정" class="btn">
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


