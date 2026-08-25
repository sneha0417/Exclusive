<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsEncrypt" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
ClsEncrypt ClsEncrypt=new ClsEncrypt();
String userid=request.getParameter("userid");

 	Connection conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select pass from my_user where doc_no="+userid+"";
	System.out.println("==strSql==="+strSql);
	ResultSet rs = stmt.executeQuery(strSql);

	String passwrd="";
	//String id="";
	if(rs.next()) {
		passwrd=ClsEncrypt.getInstance().decrypt(rs.getString("pass"));
					
  		} 
	response.getWriter().write(passwrd);
	//System.out.println("aaaaaa"+accode);
	stmt.close();
	conn.close();
	  
  
  %>