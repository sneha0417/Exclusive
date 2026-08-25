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
	String strSql = "select gname,doc_no from gl_vehgroup where status<>7";
	ResultSet rs = stmt.executeQuery(strSql);
	String group="";
	String id="";
	while(rs.next()) {
		group+=rs.getString("gname")+",";		
		id+=rs.getString("doc_no")+",";
  		} 
if(group.length()>0){
	group=group.substring(0, group.length()-1);
}
stmt.close();
conn.close();	
	response.getWriter().write(group+"***"+id);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
	%>
  
