 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	

Connection conn =null;
 try
{
			ClsConnection ClsConnection=new ClsConnection();
 	  conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
 
	String strSql = "select costtype,costgroup from my_costunit where status=1 ";
	
	 
	
	ResultSet rs = stmt.executeQuery(strSql);
	String doc_no="";
	String type="";
 
	while(rs.next()) {
		doc_no+=rs.getInt("costtype")+",";
		type+=rs.getString("costgroup")+",";
	 
  		} 
 
	response.getWriter().write(doc_no+"####"+type);
	
	
	stmt.close();
	conn.close();
}
catch(Exception e)
{
	e.printStackTrace();
	conn.close();
}
  %>
  
 