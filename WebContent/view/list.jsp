<!-- 데이터베이스와 관련된 java 클래스를 import합니다 -->
<%@page import="board.BoardDataBean"%>
<%@page import="board.BoardDBBean"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%request.setCharacterEncoding("euc-kr");%> <!-- 한글 인코딩 -->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<!-- 일반적인 head 태그 사용 -->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
		<title>Insert title here</title>
	</head>
<body>

<%
// request 기본 객체는 웹 브라우저, 즉 클라이언트가 전송한 정보 및 서버 정보를 구할 수 있는 메모드를 제공합니다.
// request.getParameter(): parameter의 value를 얻는다.
String boardid = request.getParameter("boardid");

if(boardid == null)
	boardid="1";
%>

<%
	int pageSize=5;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	// parameter "pageNum"로 전달된 value를 얻는다.
	// parameter로 전달된 값이 없는 경우, null을 return합니다.
	String pageNum = request.getParameter("pageNum");
	
	// "pageNum"의 value가 없거나, 공백이면 1번 페이지로 
	if(pageNum==null || pageNum=="") {
		pageNum = "1";
	}
	
	// String pageNum을 int로 casting
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1; // 이건 뭐지?
	int endRow = currentPage * pageSize; // 이건 뭐지?
	int count = 0;
	int number = 0;
	
	// article 목록을 저장하기 위한 List
	List articleList = null;
	
	// 싱글톤 객체의 레퍼런스 변수를 얻습니다.
	// 싱글톤 객체이므로 객체를 직접 생성하지 않습니다.
	BoardDBBean dbPro = BoardDBBean.getInstance();
	
	// Article의 개수를 가져옵니다.
	count = dbPro.getArticleCount(boardid);
	
	if(count > 0) {
		articleList = dbPro.getArticles(startRow, endRow, boardid);
	}
	
	number = count - (currentPage - 1) * pageSize;
%>

<p class="w3-left" style="padding-left: 30px;">
</p>
<div class="w3-container">
	<span class="w3-center w3-large">
		<h3><%=boardid %>(전체글:<%=count %>)</h3>
	</span>
	<p class="w3-right w3-padding-right-large"><a href="writeForm.jsp">글쓰기</a></p>
	<%
		if(count==0){				
	%>
	<table class="table-bordered" width="700">
		<tr class="w3-grey">
			<td align="center">게시판에 저장된 글이 없습니다.</td>
	</table>
	<%} else { %>
	<table class="w3-table-all" width="700">
		<tr class="w3-babypink" style="background-color:rgba(255, 0, 0, 0.4);">
			<td align="center" width="50">번호</td>
			<td align="center" width="250">제목</td>
			<td align="center" width="100">작성자</td>
			<td align="center" width="150">작성일</td>
			<td align="center" width="50">조회</td>
			<td align="center" width="100">IP</td>
			<%
			for(int i=0; i<articleList.size(); i++){
				BoardDataBean article = (BoardDataBean) articleList.get(i);%>
				<tr height="30">
				<td align="center" width="50"><%=number-- %></td>
				<td width="250">
				<%int wid=0;
					if(article.getRe_level()>0){
						wid=5*(article.getRe_level());
				%><img src="../images/level.gif" width="<%=wid%>" height="16"><img src="../images/re.gif">
				<%}else{
				%><img src="../images/level.gif" width="<%=wid%>" height="16">
				<%}%><a href="content.jsp?num=<%=article.getNum() %>&pageNume=<%=currentPage %>">
				<%=article.getSubject() %></a><%
					if(article.getReadcount()>=20){
						%><img src="../images/hot.gif" border="0" height="16"><%}%></td>
				<td align="center" width="100"><%=article.getWriter() %></td>
				<td align="center" width="150"><%=sdf.format(article.getReg_date()) %></td>
				<td align="center" width="50"><%=article.getReadcount() %></td>
				<td align="center" width="100"><%=article.getIp() %></td>
		</tr><%} %>	
	</table>
	<% 
	}
	%>
<div class="w3-center">
<%int bottomLine=3;
	if(count>0){int pageCount=count/pageSize+(count%pageSize==0?0:1);
	int startPage = 1+(currentPage-1)/bottomLine*bottomLine;
	int endPage = startPage+bottomLine-1;
	if(endPage>pageCount) endPage=pageCount;
	if(startPage>bottomLine){	%>
	<a href="list.jsp?pageNum=<%=startPage-bottomLine %>">[이전]</a>
	<%} %>
	<%for (int i=startPage; i<=endPage; i++){ %>
	<a href="list.jsp?pageNum=<%=i%>"><%
		if(i!=currentPage) out.print("["+i+"]");
		else out.print("<font color='red'>["+i+"]</font>");	%></a>
	<%}
		if(endPage<pageCount){ %>
		<a href="list.jsp?pageNum=<%=startPage+bottomLine%>">[다음]</a>
		<%}	} %>
</div>
</div>
</body>
</html>