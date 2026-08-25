<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();

 	Connection conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select smtpServer, smtpHostPort,signature,email,mailpass from my_user where doc_no='"+session.getAttribute("USERID")+"'";
	ResultSet rs = stmt.executeQuery(strSql);
	System.out.println("=strSql=strSql==strSql=="+strSql);
	String smtpServer="",smtpHostPort="",signature="",email="",pass="";
	while(rs.next()) {
		smtpServer=rs.getString("smtpServer").trim();
		smtpHostPort=rs.getString("smtpHostPort").trim();
		signature=rs.getString("signature").trim();
		email=rs.getString("email").trim();
		pass=rs.getString("mailpass").trim();
			
  		} 
	System.out.println("signature=="+signature);
	
	
	response.getWriter().write(smtpServer+"####"+smtpHostPort+"####"+signature+"####"+email+"####"+pass);
	
	stmt.close();
	conn.close();
  %>
  
