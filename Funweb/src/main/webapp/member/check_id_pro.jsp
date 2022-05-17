<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// check_id.jsp 페이지로부터 전달받은 id 가져와서 변수에 저장 후
// MemberDAO 객체의 checkId() 메서드를 호출하여 아이디 중복 여부확인 작업 요청
// =>파라미터 : 아이디(id) 		리턴타입 : boolean(isDuplicate)

String id = request.getParameter("id");
MemberDAO dao = new MemberDAO();
boolean isDuplicate = dao.checkId(id); 

// 리턴된 결과 (isDuplicate) 에 대한 판별
// => 중복일 경우(isDuplidate 이 true) out.println() 메서드를 통해 "중복" 출력
// => 중복일 경우 check_id.jsp 페이지로 이동(파라미터로 duplicate=true 값 전달)
//		아니면 "사용가능" 출력
//=> 아니면 check_id.jsp 페이지로 이동 (파라미터로 duplicate=false 값 전달)
// if(isDuplicate){
// 	out.println("중복");
// }else{
// 	out.println("사용가능");
// }

// => 단, isDuplicate 변수에 이미 중복여부가 저장되어 있으므로 해당 변수값을 파라미터로 전달하여
// 		check_id.jsp 페이지로 이동
// 또한, 입력한 아이디를 활용하기 위해 id 값도 파라미터로 전달
// response.sendRedirect("check_id.jsp?duplicate=" + isDuplicate);
response.sendRedirect("check_id.jsp?id=" + id + "&duplicate=" + isDuplicate);
%>