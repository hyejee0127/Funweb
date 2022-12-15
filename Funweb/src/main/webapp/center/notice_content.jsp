<%@page import="board.ReplyDTO"%>
<%@page import="java.util.List"%>
<%@page import="board.ReplyDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 글번호 파라미터 가져오기
int num = Integer.parseInt(request.getParameter("num"));

// 데이터베이스 작업을 위한 BoardDAO 객체 생성
BoardDAO dao = new BoardDAO();

// BoardDAO 객체의 updateReadcount() 메서드를 호출하여 게시물 조회수 증가 작업 수행
// => 파라미터 : 글번호(num)   리턴타입 : void
dao.updateReadcount(num);

// BoardDAO 객체의 selectBoard() 메서드를 호출하여 게시물 1개 조회 작업 수행
// => 파라미터 : 글번호(num)   리턴타입 : BoardDTO(board)
BoardDTO board = dao.selectBoard(num);

// 날짜 표시 형식 변경을 위한 SimpleDateFormat 객체 생성
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // ex) 2022-08-19 17:35:05

// 세션 아이디 가져오기
String sId = (String)session.getAttribute("sId");
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice_content.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function forwardReply() {
		// 세션 아이디가 있을 경우에만 쓰기 동작 수행 => 세션 아이디 없으면 경고 출력 후 중단
		<%if(sId != null) {%>
			var content = document.getElementById("reply_content").value;
			
			// notice_content_reply_writePro.jsp 페이지로 포워딩
			// => 파라미터 : 글번호, 작성자(세션아이디), 댓글내용, 댓글게시판타입(notice)
			location.href = "notice_content_reply_writePro.jsp?boardType=notice&num=<%=board.getNum()%>&name=<%=sId%>&content=" + content;
		<%} else {%>
			alert("댓글은 로그인 후 사용 가능합니다!");
		<%}%>
	}
</script>
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
			<h1>Notice Content</h1>
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
					<td id="content">내용</td>
					<td colspan="3"><%=board.getContent() %></td>
				</tr>
				<tr>
					<td>댓글</td>
					<td colspan="2" class="content_reply">
						<textarea rows="4" id="reply_content"></textarea>
					</td>
					<td>
						<input type="button" class="reply_btn" value="쓰기" 
								onclick="forwardReply()">
					</td>
				</tr>
				<!-- 댓글 목록 가져와서 출력하기 -->
				<%
				// ReplyDAO 객체 생성 후 selectReplyList() 메서드를 호출하여 댓글 목록 가져오기
				// => 파라미터 : 글번호(num)   리턴타입 : List<ReplyDTO>(replyList)
				ReplyDAO replyDAO = new ReplyDAO();
				List<ReplyDTO> replyList = replyDAO.selectReplyList(num);
				
				// 날짜 및 시각 형식을 "월월-일일 시시:분분" 형식으로 설정
				SimpleDateFormat sdf2 = new SimpleDateFormat("MM-dd HH:mm");
				
				// List 객체 크기만큼 반복하면서 ReplyDTO 객체(reply) 꺼내기 => 향상된 for문 사용
				for(ReplyDTO reply : replyList) {
					%>
					<tr>
						<td>
							<!-- 댓글 작성자와 세션 아이디가 같으면 삭제 버튼 표시 -->
							<%if(sId.equals(reply.getName())) { %>
								<input type="button" value="삭제" onclick="location.href='notice_content_reply_deletePro.jsp?num=<%=reply.getNum()%>&refNum=<%=num%>'">
							<%} %>
						</td>
						<td class="left"><%=reply.getContent() %></td>
						<td><%=reply.getName() %></td>
						<td><%=sdf2.format(reply.getDate()) %></td>
					</tr>
					<%
				}
				%>
			</table>

			<div id="table_search">
				<input type="button" value="글수정" class="btn" onclick="location.href='notice_update.jsp?num=<%=num%>'">
				<input type="button" value="글삭제" class="btn" onclick="location.href='notice_delete.jsp?num=<%=num%>'"> 
				<input type="button" value="글목록" class="btn" onclick="location.href='notice.jsp'">
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


