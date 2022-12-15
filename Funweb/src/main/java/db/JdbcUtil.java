package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

// JDBC 를 활용한 애플리케이션 개발 시 DB 접근 관련 작업 등을 수행하는 용도의 클래스 정의
// => DB 접속, DB 자원 반환(해제), 커밋 또는 롤백 등의 작업 수행
// => 모든 메서드는 외부 클래스에서 인스턴스 생성 없이도 메서드 호출이 가능하도록 static 메서드로 선언
public class JdbcUtil {
	
	// 1. DB 접속을 수행하는 getConnection() 메서드 정의
	// => 파라미터 : 없음   리턴타입 : java.sql.Connection(con)
	// => 1단계 & 2단계 작업을 수행하여 DB 접속 성공 시 접속 정보가 저장된 Conneciton 객체를 리턴
	public static Connection getConnection() {
		// DB 연결 정보를 저장할 Connection 타입 변수 선언
		Connection con = null;
		
		// DB 연결에 필요한 정보 문자열(4가지)을 변수에 별도로 저장
		String driver = "com.mysql.cj.jdbc.Driver"; // 드라이버 클래스
		String url = "jdbc:mysql://localhost:3306/funweb"; // DB 접속 정보
		String user = "root"; // 계정명
		String password = "1234"; // 패스워드

		try {
			// 1단계. 드라이버 클래스 로드
			Class.forName(driver);

			// 2단계. DB 연결
			// => 연결 성공 시 리턴되는 Connection 타입 객체를 java.sql.Connection 타입으로 저장
			con = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			// 1단계(드라이버 로드) 작업 실패(예외 발생) 시 실행되는 코드 블럭(catch 블럭)
			System.out.println("드라이버 로드 실패! - " + e.getMessage());
			e.printStackTrace();
		} catch (SQLException e) {
			// 2단계(DB 연결) 작업 실패(예외 발생) 시 실행되는 코드 블럭(catch 블럭)
			System.out.println("DB 연결 실패! - " + e.getMessage());
			e.printStackTrace();
		}
		
		// DB 연결 정보가 저장된 Connection 객체 리턴
		return con;
	}
	
	// 2. DB 자원 반환을 수행하는 close() 메서드 정의
	// => 반환해야하는 대상 객체 : Connection, PreparedStatement, ResultSet
	// => 메서드 이름은 close() 로 통일하고, 파라미터 타입만 다르게 하는 오버로딩 활용하여 정의
	public static void close(Connection con) {
		try {
			if(con != null) { con.close(); }
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void close(PreparedStatement pstmt) {
		try {
			if(pstmt != null) { pstmt.close(); }
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void close(ResultSet rs) {
		try {
			if(rs != null) { rs.close(); }
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
















