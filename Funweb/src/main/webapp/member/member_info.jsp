<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// MemberDAO 객체의 selectMemberInfo() 메서드를 호출하여 회원 상세정보 조회 후 폼에 출력하기
// => 파라미터 : 아이디(세션에 저장되어 있음), 리턴타입 : MemberBean(member)
String id = (String)session.getAttribute("sId");
MemberDAO memberDAO = new MemberDAO();
MemberBean member = memberDAO.selectMemberInfo(id);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/member_info.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp"></jsp:include>
		<!-- 헤더 들어가는곳 -->
		  
		<!-- 본문들어가는 곳 -->
		  <!-- 본문 메인 이미지 -->
		  <div id="sub_img_member"></div>
		  <!-- 왼쪽 메뉴 -->
		  <nav id="sub_menu">
		  	<ul>
		  		<li><a href="#">Join us</a></li>
		  		<li><a href="#">Privacy policy</a></li>
		  	</ul>
		  </nav>
		  <!-- 본문 내용 -->
		  <article>
		  	<h1>Member Info</h1>
		  	<form action="member_update.jsp" method="post" id="join" name="fr">
		  		<fieldset>
		  			<legend>Basic Info</legend>
		  			<label>User Id</label>
		  			<input type="text" name="id" class="id" id="id" value="<%=id %>" readonly="readonly" required="required">
		  			<br>
		  			
		  			<label>New Password</label>
		  			<input type="password" name="pass" id="pass"  placeholder="변경할 패스워드"><br> 			
		  			
		  			<label>Retype Password</label>
		  			<input type="password" name="pass2" ><br>
		  			
		  			<label>Name</label>
		  			<input type="text" name="name" id="name" value="<%=member.getName() %>" required="required"><br>
		  			
		  			<label>E-Mail</label>
		  			<input type="email" name="email" id="email" value="<%=member.getEmail() %>" required="required"><br>
		  		</fieldset>
		  		
		  		<fieldset>
		  			<legend>Optional</legend> 
		  			<label>Post code</label>
		  			<input type="text" name="post_code" id="post_code" value = "<%=member.getPost_code() %>"   placeholder="검색 버튼 클릭" readonly="readonly"> 
		  			<input type="button" value="우편번호 검색" onclick="sample4_execDaumPostcode()" class="dup"><br>
<!-- <span id="guide" style="color:#999;display:none"></span> -->
		  			<label>Address</label>
		  			<input type="text" name="address1" id="address1" value="<%=member.getAddress1() %>" readonly="readonly"> 
		  			<input type="text" name="address2" id="address2" value ="<%=member.getAddress2() %>" placeholder="상세주소 입력"><br>
		  			
		  			<label>Phone Number</label>
		  			<input type="text" name="phone" value="<%=member.getPhone() %>"><br>
		  			<label>Mobile Phone Number</label>
		  			<input type="text" name="mobile" value="<%=member.getMobile() %>"><br>
		  		</fieldset>
		  		<div class="clear"></div>
		  		<div id="buttons">
		  			<input type="submit" value="Submit" class="submit">
		  			<input type="reset" value="Cancel" class="cancel">
		  		</div>
		  	</form>
		  </article>
		  
		  
		<div class="clear"></div>  
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


