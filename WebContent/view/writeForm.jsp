<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<html>
<head>
<style>
.container {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translateX(-50%) translateY(-50%);
}
</style>
	<title>Users</title>
</head>

<!-- center 태그는 이제 사용하지 않도록 합니다. 사라질 예정이라서 warning이 발생합니다.-->
<div class = "container" style = "text-align:center">
<p>Users</p>
	<div class = "row justify-content-md-center">

<!-- form, input tag 사용 -->
<form method = "post" name = "writeform" action = "test.jsp" >
 
<!-- table, th, tr, td tag에 관련된 설명은 다음 자료를 참고합니다.
<th>: table head, 테이블의 제목
<tr>: table row, 태이블의  한 행(row)
<td>: table data, 테이블의 한 셀 
참고: http://aboooks.tistory.com/59 -->

	<table class = "table" style = "width:50%;">
	   	<!-- name input -->
		<tr>
			<td width = "70" align = "center">name</td>
			
			<td width = "330">
			<input type = "text" size = "10" maxlength = "10" name = "name"></td>
		</tr>
		
		<!-- email input -->
		<tr>
			<td width = "70" align = "center">email</td>
			
			<td width = "330">
			<input type = "text" size = "40" maxlength = "50" name = "email"></td>
	 	</tr>
	 	
	 	<!-- passwd input -->
	 	<tr>
			<td width = "70" align = "center">passwd</td>
			
			<td width = "330">
			<input type = "text" size = "40" maxlength = "50" name = "passwd"></td>
	 	</tr>
	</table>

<input type = "submit"/>

</form>
</div>
</div> 
</body>
</html>      
