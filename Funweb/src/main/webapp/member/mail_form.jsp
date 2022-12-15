<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>자바 메일 전송 폼</h1>
	<form action="mail_pro.jsp" method="post">
		<table border="1">
			<tr>
				<th>보내는 사람</th>
				<td><input type="text" name="sender"></td>
			</tr>		
			<tr>
				<th>받는 사람</th>
				<td><input type="text" name="receiver"></td>
			</tr>		
			<tr>
				<th>제목</th>
				<td><input type="text" name="title"></td>
			</tr>		
			<tr>
				<th>내용</th>
				<td><textarea name="content" rows="20" cols="40"></textarea></td>
			</tr>	
			<tr>
				<td colspan="2"><input type="submit" value="메일발송"></td>
			</tr>		
		</table>
	</form>
</body>
</html>










