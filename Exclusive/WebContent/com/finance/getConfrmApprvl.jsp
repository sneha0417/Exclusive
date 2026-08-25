<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
    String doctype = request.getParameter("doctype")==null?"0":request.getParameter("doctype");  

Connection conn = null;
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();  
	int val=0;
	String strSql = "select * from my_apprmaster where status=3 and dtype='"+doctype+"'";      
	//System.out.println("strSql--------->>"+strSql);      
	ResultSet rs = stmt.executeQuery(strSql);   
    if(rs.next()) {       
		val=1; 
	}
	stmt.close();
	conn.close();  

	response.getWriter().print(val);         
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>   