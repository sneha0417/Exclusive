<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%
 	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();


	try{

	java.sql.Date sqlAccountYearToDate=null;
	java.sql.Date mclosedate=null;
	java.sql.Date mclosedateto=null;
		
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	
	String accountingtodate=request.getParameter("accountingtodate");
	
	accountingtodate.trim();
    if(!(accountingtodate.equalsIgnoreCase("undefined"))&&!(accountingtodate.equalsIgnoreCase(""))&&!(accountingtodate.equalsIgnoreCase("0")))
    {
    	 sqlAccountYearToDate = ClsCommon.changeStringtoSqlDate(accountingtodate);
    }
	
	String sql = "select DATE_ADD('"+sqlAccountYearToDate+"',INTERVAL 1 DAY) yclose";
	ResultSet rs = stmt.executeQuery(sql);
	
	while(rs.next()){
		mclosedate=rs.getDate("yclose");
	}
	
	String strSql = "select DATE_SUB(DATE_ADD('"+mclosedate+"' , INTERVAL 1 YEAR),INTERVAL 1 DAY) ycloseto";
	ResultSet rs1 = stmt.executeQuery(strSql);
	
	while(rs1.next()){
		mclosedateto=rs1.getDate("ycloseto");
	}
	
	
	stmt.close();
	conn.close();
	
	response.getWriter().write(mclosedate+"####"+mclosedateto);

} catch(Exception e){
	e.printStackTrace();
	conn.close();
} finally{
	conn.close();
}
	
%>