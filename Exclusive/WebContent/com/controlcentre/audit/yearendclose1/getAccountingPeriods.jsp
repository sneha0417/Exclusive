<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%
ClsConnection ClsConnection=new ClsConnection();

 	Connection conn = null;

	try{

	java.sql.Date sqlAccountYearFromDate=null;
	java.sql.Date sqlAccountYearToDate=null;
	java.sql.Date mclosedate=null;
	java.sql.Date mclosedateto=null;
		
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	
	String sql = "select min(ACCYR_F) ACCYR_From , min(ACCYR_T) ACCYR_To from my_year where cl_stat=0";
	ResultSet rs = stmt.executeQuery(sql);
	
	while(rs.next()){
		sqlAccountYearFromDate=rs.getDate("ACCYR_From");
		sqlAccountYearToDate=rs.getDate("ACCYR_To");
	}
	
	String strSql = "select DATE_ADD('"+sqlAccountYearToDate+"',INTERVAL 1 DAY) yclose";
	ResultSet rs1 = stmt.executeQuery(strSql);
	
	while(rs1.next()){
		mclosedate=rs1.getDate("yclose");
	}
	
	String strSqld = "select DATE_SUB(DATE_ADD('"+mclosedate+"' , INTERVAL 1 YEAR),INTERVAL 1 DAY) ycloseto";
	ResultSet rs2 = stmt.executeQuery(strSqld);
	
	while(rs2.next()){
		mclosedateto=rs2.getDate("ycloseto");
	}
	
	stmt.close();
	conn.close();
	
	response.getWriter().write(sqlAccountYearFromDate+"####"+sqlAccountYearToDate+"####"+mclosedate+"####"+mclosedateto);

} catch(Exception e){
	e.printStackTrace();
	conn.close();
} finally{
	conn.close();
}
	
%>