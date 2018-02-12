<%@page import="board.BoardDataBean"%>
<%@page import="board.BoardDBBean"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import = "java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%request.setCharacterEncoding("euc-kr");%> <!-- 한글 인코딩 -->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Recent Diaries</title>

    <!-- Bootstrap Core CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">
    
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    <!-- Custom CSS -->
    <link href="css/stylish-portfolio.min.css" rel="stylesheet">
</head>

<body id="page-top">
<%
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
	String sql = "select * from articles"; 
			// "insert into users (name, email, passwd, regdate)";	
	pstmt = con.prepareStatement(sql);

	rs = pstmt.executeQuery();
	String comment = rs.getString("diarycomment");
	String photo = rs.getString("photo");
	
} catch(Exception e) {
	// 예외(Exception)이 발생하면 어떤 문제인지 파악하기 위한 코드가 여기에 들어갑니다.
	e.printStackTrace();
	System.out.print(e.getMessage());
} 
%>
<!-- Portfolio -->
<section class="content-section" id="portfolio">
	<div class="container">
		<div class="content-section-heading text-center">
			<h3 class="text-secondary mb-0">My Memories</h3>
          	<h2 class="mb-5">Recent Diaries</h2>
		</div>
			<div class="row no-gutters">

<% for(int i = 0; i < 4; i++) {%>

				<div class="col-lg-6">
		        	<a class="portfolio-item" href="#">
		          		<span class="caption">
		            		<span class="caption-content">
		              			<h2>Stationary</h2>
		              				<p class="mb-0">
										<%= comment %>
									</p>
							</span>
						</span>
					<img class="<%= photo %>" src="../images/portfolio-1.jpg" alt="">
					</a>
				</div>
			</div>  
        </div>
    </section>
</body>
</html>
