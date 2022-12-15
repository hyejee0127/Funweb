<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main/main.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<!-- inc/top.jsp 페이지 포함시키기-->
		<jsp:include page="../inc/top.jsp"></jsp:include>
		<!-- 헤더 들어가는곳 -->
		  
		<div class="clear"></div>   
		<!-- 본문들어가는 곳 -->
		<!-- 메인 이미지 -->
		<div id="main_img"><img src="../images/main_img.jpg"></div>
		<!-- 본문 내용 -->
		<article id="front">
		  	<div id="solution">
		  		<div id="hosting">
		  			<h3>Web Hosting Solution</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
		  		</div>
		  		<div id="security">
		  		  	<h3>Web Security Solution</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
		  		</div>
		  		<div id="payment">
		  			<h3>Web Payment Solution</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
		  		</div>
		  	</div>
		  	<div class="clear"></div>
			<div id="sec_news">
				<h3><span class="orange">Security</span> News</h3>
				<dl>
					<dt>Vivamus id ligula....</dt>
					<dd>Proin quis ante Proin quis anteProin 
					quis anteProin quis anteProin quis anteProin 
					quis ante......</dd>
				</dl>
				<dl>
					<dt>Vivamus id ligula....</dt>
					<dd>Proin quis ante Proin quis anteProin 
					quis anteProin quis anteProin quis anteProin 
					quis ante......</dd>
				</dl>
			</div>
		
			<div id="news_notice">
		  		<h3 class="brown">News &amp; Notice</h3>
		  		<table>
		  			<!-- 공지사항 게시물(notice) 중 최근 게시물 5개 표시 영역 -->
		  			<%
		  			// BoardDAO 객체의 selectRecentBoardList() 메서드 호출하여
		  			// 최근 게시물 5개 목록 조회
		  			// => 파라미터 : 없음    리턴타입 : ArrayList<BoardDTO>(boardList)
		  			BoardDAO dao = new BoardDAO();
		  			ArrayList<BoardDTO> boardList = dao.selectRecentBoardList();
		  			
		  			SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd");
		  			
		  			for(BoardDTO board : boardList) {
		  			%>
			  			<tr>
			  				<td width="280"><a href="../center/notice_content.jsp?num=<%=board.getNum()%>"><%=board.getSubject() %></a></td>
			  				<td width="70"><%=board.getName() %></td>
			  				<td width="70"><%=sdf.format(board.getDate()) %></td>
		  				</tr>
	  				<%} %>
		  		</table>
		  	</div>
	  	</article>
		  
		<div class="clear"></div>  
		<!-- 푸터 들어가는곳 -->
		<!-- inc/bottom.jsp 페이지 포함시키기 -->
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


