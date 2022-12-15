<%@page import="java.io.File"%>
<%@page import="board.FileBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 글번호(num), 패스워드(pass) 파라미터 가져오기
int num = Integer.parseInt(request.getParameter("num"));
String pass = request.getParameter("pass");

// FileBoardDAO 객체 생성 
FileBoardDAO dao = new FileBoardDAO();

// 업로드 된 파일 삭제를 위해 selectRealFile() 메서드를 호출하여 실제 업로드 파일명 조회
// => 주의! 레코드 삭제 전 미리 파일명 조회 필요
String realFile = dao.selectRealFile(num);
// System.out.println(realFile);
	
// deleteFileBoard() 메서드를 호출하여 글 삭제 작업 수행
// => 파라미터 : 글번호, 패스워드    리턴타입 : int(deleteCount)
int deleteCount = dao.deleteFileBoard(num, pass);

// 작업 결과 판별 
// => 성공 시 해당 실제 파일을 삭제 후 글목록(driver.jsp) 으로 이동하고, 
//    실패 시 자바스크립트로 "글 삭제 실패" 출력하고 이전 페이지로 돌아가기
if(deleteCount > 0) {
	// --------------------------- 파일 삭제 ------------------------------
	String uploadPath = File.separator + "upload"; // 이클립스 상의 가상의 업로드 경로
	// 별도의 ServletContext 객체를 저장하지 않고, 메서드 두 개를 연달아 호출하는 방법
	String realPath = request.getServletContext().getRealPath(uploadPath);
	// System.out.println(realPath);

	// java.io.File 클래스를 사용하여 파일이 존재할 경우 해당 파일 삭제
	// 1. File 객체 생성(생성자 파라미터로 파일 경로 및 파일명 전달)
	File f = new File(realPath, realFile);
	// 2. 지정된 경로의 파일이 존재하는지 여부 판별
	if(f.exists()) { // exists() 메서드 리턴값이 true 이면 해당 파일이 존재한다는 의미
		// 3. 해당 파일 삭제
		boolean isDeleteSuccess = f.delete();
// 		System.out.println("파일 삭제 결과 : " + isDeleteSuccess);
	}
	//------------------------------------------------------------------------------------
	
	response.sendRedirect("driver.jsp");
} else {
	%>
	<script>
		alert("글 삭제 실패!");
		history.back();
	</script>
	<%
}
%>








