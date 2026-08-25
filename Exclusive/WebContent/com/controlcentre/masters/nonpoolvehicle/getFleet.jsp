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
	String strSql = "select max(fleet_no)+1 as fleetno from gl_vehmaster";
	ResultSet rs = stmt.executeQuery(strSql);
	String fleet="";
	while(rs.next()) {
		  	fleet=rs.getString("fleetno");	
	} 
	//loc=loc.substring(0, loc.length()-1);
	stmt.close();
	conn.close();
	response.getWriter().write(fleet);
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
	%>
  
