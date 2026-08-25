<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
ClsConnection ClsConnection=new ClsConnection();


 	Connection conn =null;
try{
	conn=ClsConnection.getMyConnection();

	Statement stmt = conn.createStatement ();
	String strSql = "select color,doc_no from my_color where status<>7";
	ResultSet rs = stmt.executeQuery(strSql);
	String color="";
	String id="";
	while(rs.next()) {
		color+=rs.getString("color")+",";		
		id+=rs.getString("doc_no")+",";
  		} 
if(color.length()>0){
	color=color.substring(0, color.length()-1);
}
	
	stmt.close();
	conn.close();

	response.getWriter().write(color+"***"+id);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
  %>
  
