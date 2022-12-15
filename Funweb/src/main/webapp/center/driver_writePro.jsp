<%@page import="board.FileBoardDAO"%>
<%@page import="board.FileBoardDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// driver_write.jsp 페이지로부터 전달받은 파라미터를 사용하여 funweb.file_board 테이블에 추가
request.setCharacterEncoding("UTF-8");

// 주의! 기존 일반 폼 파라미터를 가져오는 request.getParameter() 메서드 사용 불가! null 값 전달됨!
// String name = request.getParameter("name");
// out.println(name); // null 출력됨

// ---------------------------- 파일 업로드 관련 처리 --------------------------------
// 1. 업로드 할 파일이 저장될 프로젝트 상의 경로(= 가상 경로)를 문자열로 저장
//    => webapp/upload 폴더 생성(webapp 폴더가 뷰페이지 최상위 경로이므로 "/upload" 지정)
String uploadPath = "/upload";

// 2. 업로드 할 파일 최대 크기를 정수형으로 지정
// int fileSize = 10485760; // 10MB 지정 시(차후 유지보수 과정에서 파일 크기 변경 시 불편함)
// => 파일 크기 지정 시 byte 단위부터 계산 과정을 차례대로 기술하면 유지보수 시 편리함
int fileSize = 1024 * 1024 * 10; // byte(1) -> KB(1024 Byte) -> MB(1024 KB) -> 10MB 단위로 변환

// 3. 현재 프로젝트(서블릿)를 처리하는 객체를 서블릿 컨텍스트(Servlet Context)라고 하며
//    이 서블릿 컨텍스트를 객체 형태로 가져와서(request 객체의 getServletContext() 메서드 활용 
ServletContext context = request.getServletContext();
// 4. 프로젝트 상의 가상 업로드 경로에 대한 실제 업로드 경로를 알아내기(getRealPath() 메서드 활용)
//    => 파라미터 : 이클립스 상의 가상의 업로드 경로(uploadPath)
String realPath = context.getRealPath(uploadPath);
// out.println(realPath);
// 이클립스가 관리하는 톰캣 서버의 실제 경로 내부에 있는 실제 업로드 되는 폴더 위치
// D:\Shared\JSP\workspace_jsp3\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Funweb\ upload

// 5. MultipartRequest 객체 생성
// 업로드 게시물 작성 페이지를 통해 전달받은 파라미터는 request 객체를 통해 전달되지만
// request.getParameter() 메서드 사용은 불가능하다!
// 대신, MultipartRequest 객체를 통해 getParameter() 메서드를 호출하여 파라미터를 가져올 수 있다!
// => 파일 업로드를 위해 form 태그에 enctype="multipart/form-data" 속성 설정 후 
//    파라미터 처리를 위해 cos.jar 라이브러리 추가 필수(com.oreilly.servlet 패키지)
MultipartRequest multi = new MultipartRequest(
	request, // 1) 실제 요청 정보가 포함된 request 객체
	realPath, // 2) 실제 업로드 되는 폴더 경로(서버마다 달라질 수 있음 - 탐색 필요)
	fileSize, // 3) 업로드 파일 최대 크기(작은 단위부터 계산하여 저장 - Byte 단위)
	"UTF-8", // 4) 한글 파일명을 처리하기 위한 인코딩 방식
	new DefaultFileRenamePolicy() // 5) 중복 파일명에 대한 기본 처리 담당 객체 생성(파일명 뒤에 숫자 붙임)
);
// => MultipartRequest 객체 생성 시점에 파일 업로드가 수행됨

// 6. FileBoardDTO 객체 생성하여 업로드 파라미터 데이터 저장
FileBoardDTO board = new FileBoardDTO();
// 주의! request.getParameter() 메서드가 아닌 multi.getParameter() 메서드 호출 필수!
board.setName(multi.getParameter("name"));
board.setPass(multi.getParameter("pass"));
board.setSubject(multi.getParameter("subject"));
board.setContent(multi.getParameter("content"));
// 단, 파일명을 가져올 때는 단순히 getParameter() 메서드로 처리 불가
// 1) 파일명을 관리하는 객체에 접근하여 파일명 목록 중 첫번째 파일명 가져오기
String fileElement = multi.getFileNames().nextElement().toString();
// 2) 1번 과정에서 가져온 이름을 활용하여 원본 파일명과 실제 업로드 된 파일명 가져오기
board.setOriginal_file(multi.getOriginalFileName(fileElement)); // 원본 파일명
board.setReal_file(multi.getFilesystemName(fileElement)); // 실제 업로드 된 파일명
// out.println("원본 파일명 : " + board.getOriginal_file() + ", 실제 파일명 : " + board.getReal_file());

// FileBoardDAO 객체의 insertFileBoard() 메서드를 호출하여 글쓰기 작업 수행
// => 파라미터 : BoardDTO 객체(board)   리턴타입 : int(insertCount)
FileBoardDAO dao = new FileBoardDAO();
int insertCount = dao.insertFileBoard(board);

// INSERT 작업 수행 결과 판별
if(insertCount > 0) { // 회원가입 성공 시 driver.jsp 포워딩
	response.sendRedirect("driver.jsp");
} else { // 실패 시
	%>
	<script>
		alert("글쓰기 실패!");
		history.back();
	</script>
	<%
}



%>














