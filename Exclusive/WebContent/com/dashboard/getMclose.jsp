<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
	java.sql.Date mclosedate=null,taxdate=null;
String branch=request.getParameter("branch")==null || request.getParameter("branch").equalsIgnoreCase("")?"0":request.getParameter("branch");
ClsConnection ClsConnection=new ClsConnection();	
Connection conn = null;
	try{
		conn=ClsConnection.getMyConnection();
	
	Statement stmt = conn.createStatement ();
	String strSql = "select mclose,taxdate from my_brch where doc_no="+branch;
	ResultSet rs = stmt.executeQuery(strSql);
	while(rs.next()) {
			mclosedate=rs.getDate("mclose");
			taxdate=rs.getDate("taxdate");
			} 
	stmt.close();
	conn.close();
	response.getWriter().write(mclosedate+"####"+taxdate);
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
		
	}
	finally{
		conn.close();
	}
	
  %>
  