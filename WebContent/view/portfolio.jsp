<%@page import="board.BoardDBBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.Article"%>
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
<!-- Portfolio -->
<section class="content-section" id="portfolio">
	<div class="container">
		<div class="content-section-heading text-center">
			<h3 class="text-secondary mb-0">My Memories</h3>
          	<h2 class="mb-5">Recent Diaries</h2>
		</div>
			<div class="row no-gutters">
			
<%
BoardDBBean dbcontroller = BoardDBBean.getInstance();
ArrayList<Article> diaryArticles = dbcontroller.getDiaryArticles();

for(int i = 0; i < diaryArticles.size(); i++) {
	Article at = diaryArticles.get(i);
%>	
				<div class="col-lg-6">
		        	<a class="portfolio-item" href="#">
		          		<span class="caption">
		            		<span class="caption-content">
		              			<h2>Stationary</h2>
		              				<p class="mb-0">
										<%= at.getComment() %>
									</p>
							</span>
						</span>
					<img class="img-fluid" src = <%="../images/" + at.getPhoto() %> alt="">
					</a>
				</div>
<%
}
%>				
				
			</div>  
        </div>
    </section>
</body>
</html>
