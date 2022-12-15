<%@page import="board.FileBoardDTO"%>
<%@page import="board.FileBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 글번호(num) 파라미터 가져오기
int num = Integer.parseInt(request.getParameter("num"));

// FileBoardDAO 객체 생성 후 게시물 상세 정보 조회를 위해 selectBoard() 메서드 호출(메서드 재사용)
// => 파라미터 : 글번호    리턴타입 : FileBoardDTO(board)
FileBoardDAO dao = new FileBoardDAO();
FileBoardDTO board = dao.selectFileBoard(num);
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/driver_update.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%
	// 세션에 저장된 아이디가 null 이거나 게시물의 아이디와 일치하지 않으면 
	// 자바스크립트를 통해 "접근 권한이 없습니다!" 출력 후 돌아가기
	// 단, 관리자 아이디("admin")는 접근 권한 허용
	String id = (String)session.getAttribute("sId");
	System.out.println(id);
	
	if(id == null || !id.equals("admin") && !id.equals(board.getName())) {
		// 관리자 아이디가 아니고 세션 아이디가 일치하지 않으면 권한 없음
		// <-> 관리자 아이디이거나 세션 아이디가 일치하면 권한 있음
		%>
		<script>
			alert("접근 권한이 없습니다!");
			history.back();
		</script>
		<%
	}
	%>
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
			<h1>Driver Update</h1>
			<form action="driver_updatePro.jsp" method="post" enctype="multipart/form-data">
				<!-- 입력받지 않은 글번호도 함께 전달 -->
				<input type="hidden" name="num" value="<%=request.getParameter("num")%>">
				<!-- 기존 파일 삭제를 위해 실제 업로드 파일명도 함께 전달 -->
				<input type="hidden" name="real_file" value="<%=board.getReal_file()%>">
				<table id="notice">
					<tr>
						<td>글쓴이</td>
						<td><input type="text" name="name" value="<%=board.getName()%>" required="required" readonly="readonly"></td>
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
					<tr>
						<td>파일</td>
						<td>
							<%=board.getOriginal_file() %><br>
							<input type="file" name="original_file" required="required">
						</td>
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


