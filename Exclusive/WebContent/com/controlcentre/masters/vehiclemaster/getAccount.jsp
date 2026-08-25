<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
	Connection conn = ClsConnection.getMyConnection();
try{
	

	String test=request.getParameter("id");

	Statement stmt = conn.createStatement ();
	String strSql = "select description,doc_no from my_head limit 10";
	ResultSet rs = stmt.executeQuery(strSql);
	String desc="";
	String id="";
	while(rs.next()) {
		desc+=rs.getString("description")+",";		
		id+=rs.getInt("doc_no")+",";
  		} 
if(desc.length()>0){
	desc=desc.substring(0, desc.length()-1);
}
	
	response.getWriter().write(desc+"***"+id);
	stmt.close();
	conn.close();
}
catch(Exception e1){
	e1.printStackTrace();
	conn.close();
	
}
  %>