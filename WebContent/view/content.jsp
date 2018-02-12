<%@page import="board.BoardDataBean"%>
<%@page import="board.BoardDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>게시판</title>
</head>
<%
// boardid를 얻습니다.
// boardid가 없다면 1
String boardid = request.getParameter("boardid");
if(boardid == null)
	boardid = "1";

int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

// pageNum이 없거나 공백이면 1
if(pageNum == null || pageNum == "") {
 	pageNum = "1";
 }

// Date를 "년-월-일 시간:분 형식으로" 표시하기 위한 객체입니다.
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

// 예외 상황이 발생할 수 있는 코드를 try 안에 작성
// try 안에서 예외 상황이 발생하면 catch로 이동합니다.
try{
	// BoardDBBean: DB에 접속하고, 쿼리를 전달하고, 그 결과를 받을 수 있는 메소드를 가진 클래스입니다.
	BoardDBBean dbPro = BoardDBBean.getInstance();
	// BoardDataBean: Article 데이터를 저장하고, 사용하기 쉽도록 하는 클래스입니다.
	BoardDataBean article = dbPro.getArticle(num, boardid, "content");

	int ref = article.getRef();
	int re_step = article.getRe_step();
	int re_level = article.getRe_level();
%>
<body>
	<center><br><br><b>글내용 보기</b>
	<div class="container">
		<!-- 글번호, 조회수, 작성자, 작성일, 글제목, 글내용을 보여주는 테이블을 작합니다. -->
		<table class="w3-table-all" style="width: 80%;">
			<tr height="30">
				<td width="125" align="center">글번호</td>
				<td width="125" align="center"><%=article.getNum() %></td>
				<td width="125">조회수</td>
				<td width="125" align="center"><%=article.getReadcount() %></td>
			</tr>
			<tr height="30">
				<td width="125">작성자</td>
				<td width="125" align="center"><%=article.getWriter() %></td>
				<td width="125" align="center">작성일</td>
				<td align="center" width="125" align="center"><%=sdf.format(article.getReg_date()) %></td>
			</tr>
			<tr height="30">
				<td align="center" width="125">글제목</td>
				<td align="center" width="375" colspan="3"><%=article.getSubject() %></td>
			</tr>
			<tr height="30">
				<td align="center" width="125">글내용</td>
				<td align="left" width="375" colspan="3"><pre><%=article.getContent() %></pre></td>
			</tr>
			<tr height="30">
				<td colspan="4" class="w3-center">
				<input type="button" value="글수정" onclick="document.location.href='updateForm.jsp?num=<%=article.getNum() %>&pageNum=<%=pageNum %>'">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="글삭제" onclick="document.location.href='deleteForm.jsp?num=<%=article.getNum() %>&pageNum=<%=pageNum %>'">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="답글쓰기" onclick="document.location.href='writeForm.jsp?num=<%=num %>&ref=<%=ref %>&re_step=<%=re_step %>&re_level=<%=re_level %>&pageNum=<%=pageNum %>'">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="글목록" onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
				</td>
			</tr>
		</table>	
	
<%
	// 예외가 발생하면 여기로 이동합니다.
	// 예외를 처리하거나 예외 내용을 출력하는 코드를 작성합니다.
	} catch (Exception e)
	{}
%>

</div>
</center>
</body>
</html>