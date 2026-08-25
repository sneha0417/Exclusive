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
	String strSql = "select branch,doc_no from my_brch where status<>7";
	ResultSet rs = stmt.executeQuery(strSql);
	String branch="";
	String id="";
	while(rs.next()) {
		branch+=rs.getString("branch")+",";		
		id+=rs.getString("doc_no")+",";
  		} 
	branch=branch.substring(0, branch.length()-1);
	stmt.close();
	conn.close();
	response.getWriter().write(branch+"***"+id);
	
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
		
	}
	finally{
		conn.close();
	}
	%>
  
