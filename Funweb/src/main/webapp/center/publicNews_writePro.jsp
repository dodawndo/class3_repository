<%@page import="board2.BoardDAO2"%>
<%@page import="board2.BoardBean2"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
// PublicNews_write.jsp 페이지로 부터 전달받은 파라미터를 BoardBean2 객체에 저장
BoardBean2 board2 = new BoardBean2();
board2.setWriter(request.getParameter("writer"));
board2.setPass(request.getParameter("pass"));
board2.setTitle(request.getParameter("title"));
board2.setContent (request.getParameter("content"));

// BoardDAO 객체의 insertBoard() 메서드를 호출하여 게시물 등록 작업 요청
// => 파라미터 : BoardBean 객체 		리턴타입 : int(insertCount)
BoardDAO2 dao2 = new BoardDAO2();
int insertCount = dao2.insertBoard(board2);  
// 게시물 등록 작업 요청 결과 처리
// => 성공 시 notice.jsp 페이지로 포워딩
//		실패 시 자바스크립트 사용하여 "글쓰기 실패!" 출력 후 이전페이지로 돌아가기
if(insertCount > 0) {
		response.sendRedirect("publicNews.jsp");
} else {
	%>
	<script>
		alert("글쓰기 실패!");
		history.back();
	</script>
	<%
}
%>

<%--<%=board.getName()  확인 작업--%>