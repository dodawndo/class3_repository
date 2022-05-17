package member;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.JdbcUtil;

public class MemberDAO {
		// 데이터 베이스 작업에 필요한 변수 선언
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// 회원 추가 작업
		 public int insertMember(MemberBean member) {
			 int insertCount = 0;
			 
			 // JdbcUtil 클래스의 getConnection() 메서드를 호출하여 Connection 객체 가져오기
			 con = JdbcUtil.getConnection();
			 
			 try {
				// 3단계. sql 구문 작성 및 전달
				 // member 테이블에 아이디, 패스워드, 이름, 이메일, 가입일, 주소, 전화번호, 폰번호 추가
				 // => 단, 가입일은 데이터베이스의 now(0 함수 사용
				 String sql = "INSERT INTO member VALUES (?,?,?,?,now(),?,?,?,?,?)";
				 pstmt = con.prepareStatement(sql);
				 	pstmt.setString(1, member.getId());
					pstmt.setString(2, member.getPass());
					pstmt.setString(3, member.getName());
					pstmt.setString(4, member.getEmail());
					pstmt.setString(5, member.getPost_code());
					pstmt.setString(6, member.getAddress1());
					pstmt.setString(7, member.getAddress2());
					pstmt.setString(8, member.getPhone());
					pstmt.setString(9, member.getMobile());
				 // 4단계. sql 구문 실행 및 결과 처리
					insertCount = pstmt.executeUpdate();
					
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("sql 구문 오류 - insertMember()");
			} finally {
				//자원반환
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
			}
			 return insertCount;
		 }
		//====================================	
		// 로그인
		 public boolean checkUser(String id, String pass) {
		// public boolean checkUser(MemberBean member)	 
			// 로그인 결과를 저장할 변수 isLoginSuccess 선언
			boolean isLoginSuccess = false;
			
			try {
				// 1단계 & 2단계
				// JdbcUtil 객체의 getConnection() 메서드를 호출하여 DB 연결 객체 가져오기
				con = JdbcUtil.getConnection();
				
				// 3단계. SQL 구문 작성 및 전달
				// => member 테이블의 id 컬럼조회 (단, id와 pass가 일치하는 레코드 조회)

				String sql = "SELECT id FROM member WHERE id=? AND pass=? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, pass); 
			// pstmt.setString(1,member.getId());
			// pstmt.setString(1,member.getPass());	
				
				
				// 4단계. SQL 구문 실행 및 결과 처리
				rs = pstmt.executeQuery();
				
				
				// 조회 결과가 존재할 경우 (=rs.next() 가 true 일 경우)
				// isLoginSuccess 변수값을 true로 변경
				// ResultSet 객체의 다음 레코드가 존재할 경우 로그인 성공
				if(rs.next()) {
					isLoginSuccess = true;
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("SQL 구문 오류 발생! - login()");
			} finally {
				// DB 자원 반환 - JdbcUtil 클래스의 static 메서드 close() 호출(오버로딩) - 역순으로
				// => 예외 발생 여부와 관계없이 수행하기 위해 finally 블록에서 호출
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
				JdbcUtil.close(rs);
			}
			return isLoginSuccess;
		}
		 
		 //================================================
		// 회원 상세정보 조회
		 // => 파라미터 : 아이디(세션에 저장되어 있음), 리턴타입 : MemberBean(member)
		 
		 public MemberBean selectMemberInfo(String id) {
			 MemberBean member = null;
				try {
					// 1단계 & 2단계
					con = JdbcUtil.getConnection();
					
					// 3단계. SQL 구문 작성 및 전달
					// id가 일치하는 레코드 조회
					String sql = "SELECT * FROM member WHERE id=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);
					
					// 4단계. SQL 구문 실행 및 결과 처리
					rs = pstmt.executeQuery();
					
					// ResultSet 객체의 다음 레코드가 존재할 경우
					// 모든 컬럼 데이터를 MemberBean 객체에 저장
					if(rs.next()) {
						// MemberBean 객체 생성
						member = new MemberBean();
						// 데이터 저장
						member.setId(id);
						member.setPass(rs.getString("pass"));
						member.setName(rs.getString("name"));
						member.setEmail(rs.getString("email"));
						member.setDate(rs.getDate("date"));
						member.setPost_code(rs.getString("post_code"));
						member.setAddress1(rs.getString("address1"));
						member.setAddress2(rs.getString("address2"));
						member.setPhone(rs.getString("phone"));
						member.setMobile(rs.getString("mobile"));
					}
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					JdbcUtil.close(rs);
					JdbcUtil.close(pstmt);
					JdbcUtil.close(con);
				}
				return member;
			}
			
		//=============================================
		 // 업데이트 회원정보 수정 insert 랑 비슷
		 public int updateMember(MemberBean member) {
			 int updateCount = 0;
			 
			 // JdbcUtil 클래스의 getConnection() 메서드를 호출하여 Connection 객체 가져오기
			 con = JdbcUtil.getConnection();
			 
			 try {
				// 3단계. sql 구문 작성 및 전달
				 // member 테이블의 아이디가 일치하는 레코드 수정
				 // 단, pass 값(패스워드) 이 없을 경우(=" ") 이름,이메일, 주소,전화번호, 폰번호 만 수정
				 // 아니면, 패스워드, 이름, 이메일, 주소, 전화번호, 폰번호 수정
				 if(member.getPass().equals("")) {
				 String sql = "UPDATE member SET name=?, email=?, post_code=?, address1=?, address2=?, phone=?, mobile=? WHERE id=?";
				 pstmt = con.prepareStatement(sql);
				 	pstmt.setString(1, member.getName());
				 	pstmt.setString(2, member.getEmail());
				 	pstmt.setString(3, member.getPost_code());
				 	pstmt.setString(4, member.getAddress1());
				 	pstmt.setString(5, member.getAddress2());
				 	pstmt.setString(6, member.getPhone());
					pstmt.setString(7, member.getMobile());
					pstmt.setString(8, member.getId());
				 } else {	// 패스워드 입력
					 String sql = "UPDATE member SET pass=?, name=?, email=?, post_code=?, address1=?, address2=?, phone=?, mobile=? WHERE id=?";
					 pstmt = con.prepareStatement(sql);
					 	pstmt.setString(1,member.getPass());
					 	pstmt.setString(2, member.getName());
					 	pstmt.setString(3, member.getEmail());
					 	pstmt.setString(4, member.getPost_code());
					 	pstmt.setString(5, member.getAddress1());
					 	pstmt.setString(6, member.getAddress2());
					 	pstmt.setString(7, member.getPhone());
						pstmt.setString(8, member.getMobile());
						pstmt.setString(9, member.getId());
				 }
				 // 4단계. sql 구문 실행 및 결과 처리
					updateCount = pstmt.executeUpdate();
					
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("sql 구문 오류 - updateMember()");
			} finally {
				//자원반환
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
			}
			 return updateCount;
		 }
//===========================================================
		 // 아이디 중복 확인
		 public boolean checkId(String id) {
				// public boolean checkUser(MemberBean member)	 
					boolean isDuplicate = false;
					
					try {
						// 1단계 & 2단계
						// JdbcUtil 객체의 getConnection() 메서드를 호출하여 DB 연결 객체 가져오기
						con = JdbcUtil.getConnection();
						
						// 3단계. SQL 구문 작성 및 전달
						// => member 테이블의 id 컬럼조회 (단, id가 일치하는 레코드 조회)

						String sql = "SELECT id FROM member WHERE id=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, id);
					// pstmt.setString(1,member.getId());
						
						
						// 4단계. SQL 구문 실행 및 결과 처리
						rs = pstmt.executeQuery();
						
						
						// 레코드(아이디)가 존재할 경우 아이디가 중복이므로 isDuplicate을 false 로 변경
						if(rs.next()) {
							isDuplicate = true;
						}
						
					} catch (SQLException e) {
						e.printStackTrace();
						System.out.println("SQL 구문 오류 발생! - isDuplicate()");
					} finally {
						// DB 자원 반환 - JdbcUtil 클래스의 static 메서드 close() 호출(오버로딩) - 역순으로
						// => 예외 발생 여부와 관계없이 수행하기 위해 finally 블록에서 호출
						JdbcUtil.close(pstmt);
						JdbcUtil.close(con);
						JdbcUtil.close(rs);
					}
					return isDuplicate;
				}

}
