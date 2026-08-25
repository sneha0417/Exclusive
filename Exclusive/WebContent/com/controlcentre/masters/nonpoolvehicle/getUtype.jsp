<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
ClsConnection ClsConnection=new ClsConnection();


Connection conn=null;
try{
String temp=request.getParameter("id"); 
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select utype from gl_vehgroup where status<>7 and doc_no="+temp;
	ResultSet rs = stmt.executeQuery(strSql);
	String utype="";
	while(rs.next()) {
		utype+=rs.getString("utype");		
  		} 
	stmt.close();
	conn.close();
	response.getWriter().write(utype);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
	%>
  
