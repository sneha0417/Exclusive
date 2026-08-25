<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
ClsConnection ClsConnection=new ClsConnection();

 	Connection conn = null;
try{
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select desc1,doc_no from hr_setpaycat where status=3;";
	ResultSet rs = stmt.executeQuery(strSql);
	String desc1="";
	String id="";
	while(rs.next()) {
		desc1+=rs.getString("desc1")+",";		
		id+=rs.getString("doc_no")+",";
  		} 
	desc1=desc1.substring(0, desc1.length()-1);

	stmt.close();
	conn.close();

	response.getWriter().write(desc1+"***"+id);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>