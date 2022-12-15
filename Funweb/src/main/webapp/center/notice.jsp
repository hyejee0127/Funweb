<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 날짜 및 시각 정보 표시 형식을 변경하기 위해 SimpleDateFormat 클래스 활용
// => 생성자 파라미터로 표시 형식 문자열을 사용한 패턴 지정
// => ex) "yy-MM-dd HH:mm" 지정 시 "22-08-19 16:15" 형식으로 변환됨
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
// => 패턴이 지정된 SimpleDateFormat 객체의 format() 메서드를 호출하여 변환할 날짜 객체 전달
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice.jsp</title>
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
			<h1>Notice</h1>
			<table id="notice">
				<tr>
					<th class="tno">No.</th>
					<th class="ttitle">Title</th>
					<th class="twrite">Write</th>
					<th class="tdate">Date</th>
					<th class="tread">Read</th>
				</tr>
				<%
				// 3단계. SQL 구문 작성 및 전달
// 				// board 테이블의 모든 레코드 조회(단, 글번호 기준 내림차순 정렬하고, 10개만 조회)
// 				String sql = "SELECT * FROM board ORDER BY num DESC LIMIT 10";
// 				PreparedStatement pstmt = con.prepareStatement(sql);
				
// 				// 4단계. SQL 구문 실행 및 결과 처리
// 				ResultSet rs = pstmt.executeQuery();

				// 게시물 목록 조회를 위해 BoardDAO 객체 생성
// 				BoardDAO dao = new BoardDAO();
				
				// BoardDAO 객체의 selectBoardList() 메서드를 호출하여 게시물 목록 조회
				// => 파라미터 : 없음   리턴타입 : ArrayList<BoardDTO>(boardList)
// 				ArrayList<BoardDTO> boardList = dao.selectBoardList();
				
				// -----------------------------------------------------------------------
				// 페이징 처리를 위한 계산 작업
				// 1. 한 페이지에서 표시할 게시물 목록 수와 페이지 목록 수 설정
				int listLimit = 10; // 한 페이지에서 표시할 게시물 목록을 10개로 제한
// 				int pageListLimit = 10; // 한 페이지에서 표시할 페이지 목록을 10개로 제한 
				
				// 2. 현재 페이지 번호 설정(pageNum 파라미터)
				int pageNum = 1; // 현재 페이지 번호 기본값을 1로 설정
				// 만약, pageNum 파라미터가 존재할 경우 가져와서 저장
				if(request.getParameter("pageNum") != null) {
					pageNum = Integer.parseInt(request.getParameter("pageNum"));
				}
				
				// 3. 현재 페이지에서 목록으로 표시할 첫 게시물의 행 번호 계산
				//    => (현재페이지 - 1) * 페이지 당 게시물 목록 갯수
				// ---------------------------------------------------
				// pageNum   listLimit   startRow             endRow
				// ---------------------------------------------------
				//    1         10       (1 - 1) * 10 = 0행  (~ 9행)
				//    2         10       (2 - 1) * 10 = 10행 (~ 19행)
				//    3         10       (3 - 1) * 10 = 20행 (~ 29행)
				int startRow = (pageNum - 1) * listLimit;
				
				// 4. 현재 페이지에서 목록으로 표시할 마지막 게시물 행 번호 계산
				//    => 시작 행번호 + 페이지 당 게시물 목록 갯수 - 1
				//    => 현재 과정에서는 불필요한 작업(시작행부터 목록 갯수만큼 조회하므로)
// 				int endRow = startRow + listLimit - 1; 
				// -----------------------------------------------------------------------
				// 게시물 목록 조회를 위해 BoardDAO 객체 생성
				BoardDAO dao = new BoardDAO();
				
				// BoardDAO 객체의 selectBoardList() 메서드를 호출하여 게시물 목록 조회
				// => 파라미터 : 시작 행번호, 페이지 당 게시물 목록 수    
				//    리턴타입 : ArrayList<BoardDTO>(boardList)
				ArrayList<BoardDTO> boardList = dao.selectBoardList(startRow, listLimit);
				
				// 반복문을 통해 ArrayList 객체를 차례대로 접근하여
				// BoardDTO 객체를 꺼낸 후 테이블에 출력
// 				for(int i = 0; i < boardList.size(); i++) {
// 					// ArrayList 객체의 제네릭타입이 BoardDTO 타입으로 지정되어 있으므로
// 					// ArrayList 객체로부터 꺼낸 데이터는 BoardDTO 타입이 확정된다.
// 					// 즉, 별도로 Object -> BoardDTO 타입 다운캐스팅(= 강제형변환)이 불필요
// 					BoardDTO board = boardList.get(i);
// 				}
				
				// 향상된 for문을 사용하여 반복문을 동일하게 구현 가능
				// for(객체를 저장할 변수 선언 : 객체가 저장되어 있는 변수) {}
				// => 좌변의 객체에 저장된 데이터를 꺼내서 우변의 변수에 저장 반복
				for(BoardDTO board : boardList) {
					%>
					<!-- 반복문 내에서 각 레코드를 각 행에 표시 -->
					<tr onclick="location.href='notice_content.jsp?num=<%=board.getNum()%>'">
						<td><%=board.getNum() %></td>
						<td class="left"><%=board.getSubject() %></td>
						<td><%=board.getName() %></td>
<%-- 						<td><%=board.getDate() %></td> --%>
						<%-- SimpleDateFormat 객체에서 지정한 패턴을 적용하여 날짜 표시 --%>
						<td><%=sdf.format(board.getDate()) %></td>
						<td><%=board.getReadcount() %></td>
					</tr>
					<%
				}
				%>
			</table>
			<div id="table_search">
				<input type="button" value="글쓰기" class="btn" onclick="location.href='notice_write.jsp'">
			</div>
			
			<!-- 검색 기능 -->
			<div id="table_search">
				<form action="notice_search.jsp" method="get">
					<input type="text" name="keyword" class="input_box" required="required">
					<input type="submit" value="Search" class="btn">
				</form>
			</div>

			<div class="clear"></div>
			<div id="page_control">
				<%
				// 한 페이지에서 보여줄 페이지 갯수 계산
				// 1. BoardDAO 객체의 selectBoardListCount() 메서드를 호출하여 전체 게시물 수 조회
				// => 파라미터 : 없음    리턴타입 : int(boardListCount)
				int boardListCount = dao.selectBoardListCount();
				
				// 2. 한 페이지에서 표시할 페이지 갯수 설정
				int pageListLimit = 10; // 한 페이지에서 표시할 페이지 목록을 10개로 제한
				
				// 3. 전체 페이지 수 계산
				// => 전체 게시물 수를 페이지 당 페이지 갯수로 나눈 나머지가 0이면 몫을 그대로 사용하고
				//    아니면 나눗셈 결과 + 1
				int maxPage = boardListCount / pageListLimit 
								+ (boardListCount % pageListLimit == 0 ? 0 : 1);
				// 위의 삼항연산자 부분 대신 사용 가능한 if문
	// 			if(boardListCount / pageListLimit > 0) {
	// 				maxPage++;
	// 			}
				
				// 4. 시작 페이지 번호 계산
				// => (현재 페이지 - 1) / 페이지목록갯수 * 페이지목록갯수 + 1
				// ex) 현재 페이지 : 1 => 시작 페이지 = (1 - 1) / 10 * 10 + 1 = 1 페이지
				//     현재 페이지 : 2 => 시작 페이지 = (2 - 1) / 10 * 10 + 1 = 1 페이지 
				//     현재 페이지 : 10 => 시작 페이지 = (10 - 1) / 10 * 10 + 1 = 1 페이지
				//     현재 페이지 : 15 => 시작 페이지 = (15 - 1) / 10 * 10 + 1 = 11 페이지
				int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
				
				// 5. 끝 페이지 번호 계산
				// => 시작 페이지 + 페이지목록갯수 - 1
				int endPage = startPage + pageListLimit - 1;
				
				// 6. 만약, 끝 페이지 번호(endPage)가 최대 페이지 번호(maxPage)보다 클 경우 
				//    끝 페이지 번호를 최대 페이지 번호로 교체
				if(endPage > maxPage) {
					endPage = maxPage;
				}
				
				%>
				<!-- 이전 페이지 버튼(Prev) 클릭 시 현재 페이지 번호 - 1 값 전달 -->
				<!-- 단, 현재 페이지번호가 1 페이지보다 클 경우 하이퍼링크 표시(아니면 제거) -->
				<%if(pageNum == 1) { %>
					<a href="javascript:void(0)">Prev</a>
				<%} else { %>
					<a href="notice.jsp?pageNum=<%=pageNum - 1%>">Prev</a>
				<%} %>
				
				
				<!-- for문을 사용하여 startPage ~ endPage 까지 목록 표시 -->
				<%for(int i = startPage; i <= endPage; i++) { %>
					<!-- 현재 페이지 번호(pageNum) 가 i 값과 같을 경우 하이퍼링크 제거 -->
					<%if(pageNum == i) { %>
						<a href="javascript:void(0)"><%=i %></a>
					<%} else { %>
						<a href="notice.jsp?pageNum=<%=i %>"><%=i %></a>
					<%} %>
				<%} %>
				
				
				<!-- 다음 페이지 버튼(Next) 클릭 시 현재 페이지 번호 + 1 값 전달 -->
				<!-- 단, 현재 페이지번호가 최대 페이지 번호보다 작을 경우 하이퍼링크 표시(아니면 제거) -->
				<%if(pageNum == maxPage) { %>
					<a href="javascript:void(0)">Next</a>
				<%} else { %>
					<a href="notice.jsp?pageNum=<%=pageNum + 1%>">Next</a>
				<%} %>
			</div>
		</article>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>






