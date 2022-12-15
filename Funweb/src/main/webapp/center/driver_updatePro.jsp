<%@page import="java.io.File"%>
<%@page import="board.FileBoardDAO"%>
<%@page import="board.FileBoardDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

//---------------------------- 파일 업로드 관련 처리 --------------------------------
String uploadPath = File.separator + "upload"; // 이클립스 상의 가상의 업로드 경로
String realPath = request.getServletContext().getRealPath(uploadPath);
// D:\Shared\JSP\workspace_jsp3\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Funweb\ upload
int fileSize = 1024 * 1024 * 10; // byte(1) -> KB(1024 Byte) -> MB(1024 KB) -> 10MB 단위로 변환
MultipartRequest multi = new MultipartRequest(
	request, // 1) 실제 요청 정보가 포함된 request 객체
	realPath, // 2) 실제 업로드 되는 폴더 경로(서버마다 달라질 수 있음 - 탐색 필요)
	fileSize, // 3) 업로드 파일 최대 크기(작은 단위부터 계산하여 저장 - Byte 단위)
	"UTF-8", // 4) 한글 파일명을 처리하기 위한 인코딩 방식
	new DefaultFileRenamePolicy() // 5) 중복 파일명에 대한 기본 처리 담당 객체 생성(파일명 뒤에 숫자 붙임)
);

// FileBoardDTO 객체 생성하여 업로드 파라미터 데이터 저장
FileBoardDTO board = new FileBoardDTO();
board.setNum(Integer.parseInt(multi.getParameter("num"))); // 원본 글번호
board.setName(multi.getParameter("name"));
board.setPass(multi.getParameter("pass"));
board.setSubject(multi.getParameter("subject"));
board.setContent(multi.getParameter("content"));
String fileElement = multi.getFileNames().nextElement().toString();
board.setOriginal_file(multi.getOriginalFileName(fileElement)); // 원본 파일명
board.setReal_file(multi.getFilesystemName(fileElement)); // 실제 업로드 된 파일명
//out.println("원본 파일명 : " + board.getOriginal_file() + ", 실제 파일명 : " + board.getReal_file());

//FileBoardDAO 객체의 updateFileBoard() 메서드를 호출하여 글 수정 작업 수행
//=> 파라미터 : FileBoardDTO 객체(board)   리턴타입 : int(updateCount)
FileBoardDAO dao = new FileBoardDAO();
int updateCount = dao.updateFileBoard(board);

if(updateCount > 0) { // 수정 성공 시
	// ---------------- 기존 파일 삭제 처리 --------------
	String realFile = multi.getParameter("real_file"); // 기존 업로드 된 파일명 가져오기
// 	System.out.println(realFile);
	
	File f = new File(realPath, realFile);
	if(f.exists()) {
		f.delete();
	}
	// ---------------------------------------------------
	response.sendRedirect("driver_content.jsp?num=" + board.getNum());	
} else {
	%>
	<script>
		alert("글 수정 실패!");
		history.back();
	</script>
	<%
}
%>















