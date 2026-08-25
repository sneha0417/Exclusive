<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
ClsConnection ClsConnection=new ClsConnection();



 	Connection conn = null;
 	try{
 		String test=request.getParameter("id");
 		conn=ClsConnection.getMyConnection();
 	
	Statement stmt = conn.createStatement ();
	String strSql = "select loc_name,doc_no from my_locm where status<>7 and brhid="+test;
	ResultSet rs = stmt.executeQuery(strSql);
	String loc="";
	String id="";
	while(rs.next()) {
		loc+=rs.getString("loc_name")+",";		
		id+=rs.getString("doc_no")+",";
  		} 
	if(loc.length()>0){
		loc=loc.substring(0, loc.length()-1);	
	}
	stmt.close();
	conn.close();
	response.getWriter().write(loc+"***"+id);
 	}
 	catch(Exception e){
 		e.printStackTrace();
 		conn.close();
 	}
 	finally{
 		conn.close();
 	}
  %>
  
