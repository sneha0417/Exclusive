<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	ClsConnection ClsConnection=new ClsConnection();
 	Connection conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "SELECT category,doc_no FROM my_clcatm where dtype='CRM';";
	ResultSet rs = stmt.executeQuery(strSql);
	//System.out.println(strSql);
	String category="";
	String categoryid="";
	while(rs.next()) {
		category+=rs.getString("category")+",";		
		categoryid+=rs.getString("doc_no")+",";
  		} 
	category=category.substring(0, category.length()-1);
	response.getWriter().write(category+"####"+categoryid);
	stmt.close();
	conn.close();
  %>
  
