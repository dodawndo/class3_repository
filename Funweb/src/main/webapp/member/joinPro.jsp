<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    // post 방식 한글 처리
    request.setCharacterEncoding("utf-8"); 
    
    // join.jsp 페이지로 부터 전달받은 폼 파라미터 데이터 가져오기
    String id = request.getParameter("id");
    String pass = request.getParameter("pass");
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String post_code = request.getParameter("post_code");
    String address1 = request.getParameter("address1");
    String address2 = request.getParameter("address2");
    String phone = request.getParameter("phone");
    String mobile = request.getParameter("mobile");
    
    // 회원가입에 필요한 파라미터 데이터를 하나의 객체로 관리하기 위해 MemberBean 객체 활용
    // MemberBean 객체 생성 후 Setter 를 호출하여 폼 파라미터 데이터 저장
    MemberBean member = new MemberBean();
    member.setId(id);
    member.setPass(pass);
    member.setName(name);
    member.setEmail(email);
    member.setPost_code(post_code);
    member.setAddress1(address1);
    member.setAddress2(address2);
    member.setPhone(phone);
    member.setMobile(mobile);
    
    //MemberDAO 클래스 객체 생성
    MemberDAO dao = new MemberDAO();
    
    //MemberDAO 개체의 insertMember() 메서드 호출하여 회원 가입 처리
    // => 파라미터 : MemberBean 객체, 리턴타입 : int (insertCount)
	int insertCount = dao.insertMember(member); 
    
    // insertMember() 작업 수행 후 리턴받은 값에 따른 처리
    //=> 성공시 (insertCount>0) "member 폴더의 joinSuccess.jsp " 페이지로 포워딩
    //=> 실패시 자바스크립트를 사용하여 "회원 가입 실패!" 출력후 이전페이지로 돌아가기
if(insertCount > 0) {
		response.sendRedirect("joinSuccess.jsp");

} else {
	%>
	<script>
		alert("회원 가입 실패!");
		history.back();
	</script>
	<%
}
    %>


