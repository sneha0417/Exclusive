<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>

<%
ClsConnection ClsConnection=new ClsConnection();
 	Connection conn = ClsConnection.getMyConnection();
try{
	Statement stmt = conn.createStatement ();
	String strSql = "select loc_name,doc_no from my_locm where status<>7 ";
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
	
	response.getWriter().write(loc+"***"+id);
	System.out.println("Location:"+loc+"***"+id);
	stmt.close();
	conn.close();
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>