<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
 	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();
try{
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select grp_name,doc_no from my_fagrp where status=3;";
	ResultSet rs = stmt.executeQuery(strSql);
	String branch="";
	String id="";
	while(rs.next()) {
		branch+=rs.getString("grp_name")+",";		
		id+=rs.getString("doc_no")+",";
  		} 
	branch=branch.substring(0, branch.length()-1);
//	System.out.println("branch"+branch+"***"+id);
	stmt.close();
	conn.close();

	response.getWriter().write(branch+"***"+id);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>