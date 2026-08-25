<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%

 	Connection conn = null;
ClsConnection objconn=new ClsConnection();
try{
	conn=objconn.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select st_desc,status from gl_status where mov=1";
	ResultSet rs = stmt.executeQuery(strSql);
	String desc="";
	String id="";
	while(rs.next()) {
		desc+=rs.getString("st_desc")+",";		
		id+=rs.getString("status")+",";
  		} 
	desc=desc.substring(0, desc.length()-1);
	response.getWriter().write(desc+"***"+id);
	System.out.println("Status:"+desc+"***"+id);
	stmt.close();
	conn.close();
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>