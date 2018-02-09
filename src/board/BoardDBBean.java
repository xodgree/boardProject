package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// 싱글톤 패턴(singleton pattern)
public class BoardDBBean {
	// 정적(static) 변수로 지정하였기 때문에 이 변수는 모든 BoardDBBean 객체가 공유합니다.
	// 싱글톤 패턴의 핵심입니다.
	// instance 변수가 생성될 때,
	// 바로 BoardDBBean 객체가 하나 생성되고 instance 레퍼런스 변수로 이것을 참조합니다.
	private static BoardDBBean instance = new BoardDBBean();
	
	// 생성자는 private으로 선언합니다.
	// 외부에서는 생성자를 직접 호출할 수 없습니다. 즉, 생성을 제한합니다.
	private BoardDBBean() {
	}
	
	// instance 레퍼런스 변수를 얻습니다.
	// public static 메소드이므로 어느 곳에서나 접근할 수 있습니다.
	// static 함수이므로 객체를 생성하지 않아도 접근할 수 있습니다.
	public static BoardDBBean getInstance() {
		return instance;
	}
	
	// DB에 접속하는 메소드입니다.
	// DB 계정 정보를 포함하고 있습니다.
	public static Connection getConnection(){
		Connection con = null;
		
		try {
			// DB의 URL, 사용자 계정, 비밀번호
			String jdbcUrl = "jdbc:oracle:thin:@localhost:1521:orcl";
			String dbUser = "scott";
			String dbPass = "tiger";
			
			// 리플렌션(reflection) 동적 로딩에 대한 코드이므로 몰라도 됩니다.
			// 이렇게 사용해야 한다는 것만 알고 넘깁니다.
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			// DB URL,계정, 비밀번호를 가지고 DB에 접속합니다.
			con = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);
		} catch(Exception e) {
			// 예외(Exception)이 발생하면 어떤 문제인지 파악하기 위한 코드가 여기에 들어갑니다.
			e.printStackTrace();
		}
		
		// Exception이 발생하지 않았다면 무사히 접속하였습니다.
		// 접속 정보를 return합니다.
		return con;
	}
	
	public void close(Connection con, ResultSet rs, PreparedStatement pstmt) {
		if(rs!=null) 
			try {
				rs.close();
			}catch(SQLException ex) {}
		if(pstmt!=null)
			try {
				pstmt.close();
			}catch(SQLException ex) {}
		if(con!=null)
			try {
				con.close();
			}catch(SQLException ex) {}
		}
	
	
	public void insertArticle(BoardDataBean article) {
		String sql="";
		Connection con = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int number=0;
		
		try {									//boardser ½ÃÄö½º / ÇöÀç ½ÃÄö½ºÀÇ ´ÙÀ½°ª ¹ÝÈ¯
			pstmt = con.prepareStatement("select boardser.nextval from dual");
			rs = pstmt.executeQuery();
			if(rs.next())
				number = rs.getInt(1)+1;
			else number = 1;
		
			int num = article.getNum();	
			int ref = article.getRef();	
			int re_step = article.getRe_step();
			int re_level = article.getRe_level();
			//´ä±Û¾²±â
			if(num!=0) {
				sql = "update board set re_step=re_step+1 where ref=? and re_step> ? and boardid = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.setString(3, article.getBoardid());
				pstmt.executeUpdate();
				re_step = re_step+1;
				re_level=re_level+1;
				
			}else {
				ref=number;
				re_step=0;
				re_level=0;
			}
			
			//»õ±Û¾²±â
			sql = "insert into board(num,writer,email,subject,passwd,reg_date,";
			sql += "ref,re_step,re_level,content,ip,boardid) "
				+ "values(?,?,?,?,?,sysdate,?,?,?,?,?, ?)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, article.getWriter());
			pstmt.setString(3, article.getEmail());
			pstmt.setString(4, article.getSubject());
			pstmt.setString(5, article.getPasswd());
			pstmt.setInt(6, ref);
			pstmt.setInt(7, re_step);
			pstmt.setInt(8, re_level);
			pstmt.setString(9, article.getContent());
			pstmt.setString(10, article.getIp());
			pstmt.setString(11, article.getBoardid());
			pstmt.executeQuery();
			
			}catch(SQLException ex){
				ex.printStackTrace();
			}finally {
				close(con, rs, pstmt);
			}
	}

	// article의 개수를 얻습니다.
	public int getArticleCount(String boardid) {
		int x = 0;
		
		// nvl은 null 데이터라면 0으로 가정하는 쿼리
		// nvl(count(*),0)이 의미하는 내용은 다음 주소에 잘 설명되어 있습니다.
		// http://www.commit.co.kr/entry/%EC%A7%91%EA%B3%84%ED%95%A8%EC%88%98%EC%99%80-%EA%B3%B5%EC%A7%91%ED%95%A9%EC%9D%98-NULL-%EC%B2%98%EB%A6%AC
		String sql = "select nvl(count(*),0) from board where boardid = ?";
		
		// DB에 접속하고, 접속 정보를 얻습니다.
		Connection con = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int number = 0;
		try {
		pstmt=con.prepareStatement(sql);
		pstmt.setString(1, boardid);
		
		rs=pstmt.executeQuery();
		if(rs.next()) { x=rs.getInt(1); }
		}
		catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(con, rs, pstmt);
		}
		return x;
	}
	
	public List getArticles(int startRow, int endRow, String boardid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List articleList = null;
		String sql = "";
		try {
			conn = getConnection();
			sql = " select * from" + "( select rownum rnum ,a.* "
			         + " from (select num,writer,email,subject,passwd,"
			         + "reg_date,readcount,ref,re_step,re_level,content,"
			         + "ip from board where boardid = ? order by ref desc , re_step) "
			         + " a ) where rnum between ? and ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, boardid);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				articleList = new ArrayList();
				do {
					BoardDataBean article = new BoardDataBean();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setEmail(rs.getString("email"));
					article.setSubject(rs.getString("subject"));
					article.setPasswd(rs.getString("passwd"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcount"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("re_step"));
					article.setRe_level(rs.getInt("re_level"));
					article.setContent(rs.getString("content"));
					article.setIp(rs.getString("ip"));
					articleList.add(article);
					
				}while(rs.next());
			}}catch(Exception ex) {
				ex.printStackTrace();
			}finally {close(conn, rs, pstmt);}
				return articleList;
		}
	
	public BoardDataBean getArticle(int num, String boardid, String chk) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardDataBean article = null;
		String sql="";
		try {
			conn = getConnection();
			
			if(chk.equals("content")) {
			sql = "update board set readcount = readcount+1 " + "where num = ? and boardid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, boardid);
			pstmt.executeUpdate();
			}
			sql = "select * from board where num = ? and boardid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, boardid);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				article = new BoardDataBean();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPasswd(rs.getString("passwd"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
	}finally {close(conn, rs, pstmt);}
	return article;
	}
	
	public int updateArticle(BoardDataBean article) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int chk=0;
		try {
			conn = getConnection();
			String sql = "update board set writer=?,email=?,subject=?,content=? where num=? and passwd=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getWriter());
			pstmt.setString(2, article.getEmail());
			pstmt.setString(3, article.getSubject());
			pstmt.setString(4, article.getContent());
			pstmt.setInt(5, article.getNum());
			pstmt.setString(6, article.getPasswd());
			chk = pstmt.executeUpdate();
			
			}catch(SQLException ex){
				ex.printStackTrace();
			}finally {
				close(conn, null, pstmt);
			}
		return chk;
	}
	
	
	public int deleteArticle(int num, String passwd, String boardid) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "delete from board where num = ? and passwd = ?" ;
		int x = -1;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, passwd);
			x = pstmt.executeUpdate();
			}catch(SQLException ex){
				ex.printStackTrace();
			}finally {
				close(conn, rs, pstmt);
			}
		return x;
	}
	
	
	
	
	
}