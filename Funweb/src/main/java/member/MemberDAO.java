package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.JdbcUtil;

public class MemberDAO {
	// 아이디 중복 확인 수행
	// => 파라미터 : 아이디(id)    리턴타입 : boolean(isDuplicate)
	public boolean checkId(String id) {
		boolean isDuplicate = false;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 1단계 & 2단계
		Connection con = JdbcUtil.getConnection();
		
		try {
			// SELECT 구문을 사용하여 아이디가 일치하는 레코드 검색
			// => 아이디가 일치하는 레코드가 있을 경우 isDuplicate 변수값을 true 로 변경
			String sql = "SELECT * FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				isDuplicate = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return isDuplicate;
	}
	
	// 회원 가입 작업 - insertMember()
	// => 파라미터 : MemberDTO 객체(member)   리턴타입 : int(insertCount)
	public int insertMember(MemberDTO member) {
		int insertCount = 0;
		
		Connection con = JdbcUtil.getConnection();
		
		PreparedStatement pstmt = null;
		
		try {
			// 회원 가입(INSERT) 작업 수행
			String sql = "INSERT INTO member VALUES (?,?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getId()); // 아이디
			pstmt.setString(2, member.getPass()); // 패스워드
			pstmt.setString(3, member.getName()); // 이름
			pstmt.setString(4, member.getEmail()); // 이메일
			pstmt.setString(5, member.getPost_code()); // 우편번호
			pstmt.setString(5, member.getAddress1()); // 기본주소
			pstmt.setString(6, member.getAddress2()); // 상세주소
			pstmt.setString(7, member.getPhone()); // 전화번호
			pstmt.setString(8, member.getMobile()); // 폰번호

			insertCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return insertCount;
	}
	
	// 로그인
	public boolean loginMember(MemberDTO member) {
		boolean isLoginSuccess = false;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 1단계 & 2단계
		Connection con = JdbcUtil.getConnection();
		
		try {
			// SELECT 구문을 사용하여 아이디가 일치하는 레코드 검색
			// => 아이디, 패스워드 일치하는 레코드 검색
			String sql = "SELECT * FROM member WHERE id=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPass());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				isLoginSuccess = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return isLoginSuccess;
	}
}















