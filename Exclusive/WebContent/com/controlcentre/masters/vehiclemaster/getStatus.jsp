<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
Connection conn = ClsConnection.getMyConnection();
try{
	
 
	Statement stmt = conn.createStatement ();
	String strSql = "select status,st_desc from gl_status";
	ResultSet rs = stmt.executeQuery(strSql);
	/* System.out.println(strSql); */
	String status="",stdesc="";
	while(rs.next()) {
				stdesc+=rs.getString("st_desc")+",";
				status+=rs.getString("status")+",";
  		} 
	if(status.length()>0){
		status=status.substring(0, status.length()-1);	
	}
	
	/* response.getWriter().write(brch.toString()); */ 
	response.getWriter().write(stdesc+"####"+status);
	
	stmt.close();
	conn.close();
 
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>
  
