package board2;

import java.sql.Date;

/*
board2 테이블 정의
글번호(num) - 정수, PRIMARY KEY
글쓴이(writer) - 문자16자, NN
패스워드(pass) - 문자 16자, NN
제목(title) - 문자 50자, NN
내용(content) - 문자 2000자, NN
작성일(date) - 날짜(DATE), NN
조회수(readcount) - 정수, NN

CREATE TABLE board2(
num INT PRIMARY KEY,
writer VARCHAR(16) NOT NULL,
pass VARCHAR(16) NOT NULL,
title VARCHAR(50) NOT NULL,
content VARCHAR(2000) NOT NULL,
date DATE NOT NULL,
readcount INT NOT NULL
);
*/
public class BoardBean2 {
	private int num;
	private String writer;
	private String pass;
	private String title;
	private String content;
	private Date date;
	private int readcount;
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	
	
}
