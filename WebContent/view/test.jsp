<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
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
%>

<div class = "container" style = "width:50%">
	<div class = "row">
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
		
		<a href = "hello.jsp" class = "btn" role = "button">Yes</a>
		
	</div>
</div>

</body>
</html>