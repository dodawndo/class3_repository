<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
// member_info.jsp 페이지로 부터 전달받은 파라미터 (패스워드, 이름, 이메일, 주소, 전화번호,폰번호)
//가져와서 MemberBean 객체에 저장
MemberBean member = new MemberBean();
member.setId(request.getParameter("id"));	// 또는 세션 객체에서 아이디 전달받을 수도 있음
member.setPass(request.getParameter("pass"));
member.setName(request.getParameter("name"));
member.setEmail(request.getParameter("email"));
member.setPost_code(request.getParameter("post_code"));
member.setAddress1(request.getParameter("address1"));
member.setAddress2(request.getParameter("address2")); // 수정
member.setPhone(request.getParameter("phone"));
member.setMobile(request.getParameter("mobile"));

//MemberDAO 객체의 updateMember() 메서드를 호출하여 회원 정보 수정 작업 요청
// => 파라미터 : MemberBean 객체 		리턴타입 : int(updateCount)
// => 단, 아이디에 해당하는 이름, 이메일, 주소, 전화번호, 폰번호만 수정 (비밀전호 제외)
MemberDAO dao = new MemberDAO();
 int updateCount = dao.updateMember(member);

// 작업 수행 결과를 리턴받아 처리 
// =>성공시 (updateCount>0) "member 폴더의 member_info.jsp" 페이지로 포워딩
// => 실패 시 자바스크립트를 사용하여 "정보수정실패!" 출력후 이전페이지로 돌아가기
if(updateCount > 0) {
	%>
	<script>
		alert("수정 완료!");
		location.href = "member_info.jsp";
	</script>
	<%
} else {
	%>
	<script>
		alert("정보 수정 실패!");
		history.back();
	</script>
	<%
}

%>