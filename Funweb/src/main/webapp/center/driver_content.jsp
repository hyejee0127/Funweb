<%@page import="board.FileBoardDTO"%>
<%@page import="board.FileBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 글번호 파라미터 가져오기
int num = Integer.parseInt(request.getParameter("num"));

// 데이터베이스 작업을 위한 FileBoardDAO 객체 생성
FileBoardDAO dao = new FileBoardDAO();

// FileBoardDAO 객체의 updateReadcount() 메서드를 호출하여 게시물 조회수 증가 작업 수행
// => 파라미터 : 글번호(num)   리턴타입 : void
dao.updateReadcount(num);

// FileBoardDAO 객체의 selectFileBoard() 메서드를 호출하여 게시물 1개 조회 작업 수행
// => 파라미터 : 글번호(num)   리턴타입 : FileBoardDTO(board)
FileBoardDTO board = dao.selectFileBoard(num);

// 날짜 표시 형식 변경을 위한 SimpleDateFormat 객체 생성
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // ex) 2022-08-19 17:35:05
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/driver_content.jsp</title>
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
			<h1>Driver Content</h1>
			<table id="notice_content">
				<tr>
					<td>글번호</td>
					<td><%=board.getNum() %></td>
					<td>글쓴이</td>
					<td><%=board.getName() %></td>
				</tr>
				<tr>
					<td>작성일</td>
					<td><%=sdf.format(board.getDate()) %></td>
					<td>조회수</td>
					<td><%=board.getReadcount() %></td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3"><%=board.getSubject() %></td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="3"><%=board.getContent() %></td>
				</tr>
				<tr>
					<td>파일</td>
					<td colspan="3">
						<!-- 
						실제 파일과 연결하여 파일 다운로드 하이퍼링크 생성(HTML5 에서 추가된 기능)
						하이퍼링크 href 속성에 파일 위치 경로명과 실제 파일명을 기술하고
						download 속성 지정 시 파일 다운로드 기능이 동작함
						(download 속성 생략 시 웹브라우저가 처리 가능한 파일은 브라우저에서 실행됨)
						download 속성값에 다운로드할 파일명 지정하면 파일명 변경도 가능	
						<a href="경로/실제파일명" download="원본파일명">원본파일명</a>					
						-->
						<a href="../upload/<%=board.getReal_file()%>" download="<%=board.getOriginal_file() %>"><%=board.getOriginal_file() %></a>
					</td>
				</tr>
				<tr>
					<td>댓글</td>
					<td colspan="2" class="content_reply">
						<textarea rows="4"></textarea>
					</td>
					<td>
						<input type="button" class="reply_btn" value="쓰기">
					</td>
				</tr>
			</table>

			<div id="table_search">
				<input type="button" value="글수정" class="btn" onclick="location.href='driver_update.jsp?num=<%=num%>'">
				<input type="button" value="글삭제" class="btn" onclick="location.href='driver_delete.jsp?num=<%=num%>'"> 
				<input type="button" value="글목록" class="btn" onclick="location.href='driver.jsp'">
			</div>

			<div class="clear"></div>
		</article>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


