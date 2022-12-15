package board;

import java.sql.Timestamp;

/*
 CREATE TABLE file_board (
	num INT PRIMARY KEY,
	name VARCHAR(20) NOT NULL,
	pass VARCHAR(16) NOT NULL,
	subject VARCHAR(50) NOT NULL,
	content VARCHAR(2000) NOT NULL,
	original_file VARCHAR(200) NOT NULL,
	real_file VARCHAR(200) NOT NULL,
	readcount INT NOT NULL,
	date DATETIME NOT NULL
 );
 */

// funweb.file_board 테이블 1개 레코드 정보를 관리하는 FileBoardDTO 클래스 정의
public class FileBoardDTO {
	private int num;
	private String name;
	private String pass;
	private String subject;
	private String content;
	private String original_file;
	private String real_file;
	private int readcount;
	private Timestamp date;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getOriginal_file() {
		return original_file;
	}
	public void setOriginal_file(String original_file) {
		this.original_file = original_file;
	}
	public String getReal_file() {
		return real_file;
	}
	public void setReal_file(String real_file) {
		this.real_file = real_file;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	
}
