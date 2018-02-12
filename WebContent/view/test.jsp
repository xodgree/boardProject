<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import = "java.sql.*" %>	

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<title>Test</title>

<style>
.container {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translateX(-50%) translateY(-50%);
}
</style>

</head>
<body>

<%
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String passwd = request.getParameter("passwd");
	
	Connection con = null;
	
	try {
		// DB의 URL, 사용자 계정, 비밀번호
		String jdbcUrl = "jdbc:oracle:thin:@localhost:1521:xe";
		String dbUser = "mooneegee";
		String dbPass = "1227";
		
		// 리플렌션(reflection) 동적 로딩에 대한 코드이므로 몰라도 됩니다.
		// 이렇게 사용해야 한다는 것만 알고 넘깁니다.
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		// DB URL,계정, 비밀번호를 가지고 DB에 접속합니다.
		con = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);
		
		// querry를 등록하고 실행할 PreparedStatement 객체  레퍼런스
		PreparedStatement pstmt = null;
		// querry 결과를 저장하는 ResultSet 객체 레퍼런스
		ResultSet rs = null;
		String sql = "insert into users (name, email, passwd, regdate)";
		sql += "values(?,?,?, sysdate)";
					
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setString(2, email);
		pstmt.setString(3, passwd);
		
		rs = pstmt.executeQuery();
		
		
	} catch(Exception e) {
		// 예외(Exception)이 발생하면 어떤 문제인지 파악하기 위한 코드가 여기에 들어갑니다.
		e.printStackTrace();
		System.out.print(e.getMessage());
	}
%>

<div class = "container">
	<div class = "row justify-content-md-center"">
		<div class="col-6">
			<table class = "table"> 
			   	<!-- name input -->
				<tr>
					<td>name</td>
					<td> <%= name %></td>
				</tr>
				
				<!-- email input -->
				<tr>
					<td>email</td>
					<td> <%= email %></td>
			 	</tr>
			 	
			 	<!-- passwd input -->
			 	<tr>
					<td>passwd</td>
					<td> <%= passwd %></td>
			 	</tr>
			</table>
		</div>
	</div>
	<div class = "row justify-content-md-center">
		<div class="col col-md-auto">
			<button type = "button" class = "btn btn-primary">Yes</button>
		</div>
	</div>
</div>

</body>
</html>