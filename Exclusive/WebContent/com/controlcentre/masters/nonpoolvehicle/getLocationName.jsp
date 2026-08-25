<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
ClsConnection ClsConnection=new ClsConnection();



 	Connection conn = null;
try{
	conn=ClsConnection.getMyConnection();
String test=request.getParameter("id");
	Statement stmt = conn.createStatement ();
	String strSql = "select loc_name from my_locm where status<>7 and doc_no="+test;
	ResultSet rs = stmt.executeQuery(strSql);
	System.out.println(strSql);
	String loc="";
	while(rs.next()) {
  	loc=rs.getString("loc_name");	
	} 
	stmt.close();
	conn.close();
	response.getWriter().write(loc);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
	
}
finally{
	conn.close();
}
	%>
  
