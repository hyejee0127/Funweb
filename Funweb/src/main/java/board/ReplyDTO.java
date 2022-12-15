package board;

import java.sql.Timestamp;

/*
 reply 테이블 생성
 ----------------------
 댓글번호(num) - 정수 PK AI(AUTO_INCREMENT = 자동 증가)
 게시판타입(boardType) - 문자 10자 NN
 원본게시물번호(refNum) - 정수 FK NN (임시로 FK 생략)
 댓글작성자(name) - 문자 20자 NN
 댓글내용(content) - 문자 100자 NN
 댓글작성일시(date) - TIMESTAMP
 ------------------------------
 CREATE TABLE reply (
 	num INT PRIMARY KEY AUTO_INCREMENT,
 	boardType VARCHAR(10) NOT NULL,
 	refNum INT NOT NULL,
 	name VARCHAR(20) NOT NULL,
 	content VARCHAR(100) NOT NULL,
 	date TIMESTAMP NOT NULL
 );
 */

public class ReplyDTO {
	private int num; // 댓글의 번호
	private String boardType; // 게시판 타입
	private int refNum; // 댓글의 원본 게시물 번호
	private String name; // 댓글 작성자(아이디)
	private String content; // 댓글 내용
	private Timestamp date; // 댓글 작성 일시
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
	public int getRefNum() {
		return refNum;
	}
	public void setRefNum(int refNum) {
		this.refNum = refNum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	
}
