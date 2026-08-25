
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();

 	Connection conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select smtpServer, smtpHostPort,signature from my_user where doc_no='"+session.getAttribute("COMPANYID")+"'";
	ResultSet rs = stmt.executeQuery(strSql);
	System.out.println("=strSql=strSql==strSql=="+strSql);
	String smtpServer="",smtpHostPort="",signature="";
	while(rs.next()) {
		smtpServer=rs.getString("smtpServer").trim();
		smtpHostPort=rs.getString("smtpHostPort").trim();
		signature=rs.getString("signature").trim();
			
  		} 
	System.out.println("signature=="+signature);
	
	
	response.getWriter().write(smtpServer+"####"+smtpHostPort+"####"+signature);
	
	stmt.close();
	conn.close();
  %>
  
