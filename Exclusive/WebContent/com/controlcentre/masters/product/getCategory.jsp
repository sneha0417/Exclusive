<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
Connection conn = ClsConnection.getMyConnection();
String temp=request.getParameter("id");
 	try{
	Statement stmt = conn.createStatement ();
	String strSql = "select category,doc_no  from my_catm where status <> 7 ";
	
	ResultSet rs = stmt.executeQuery(strSql);
	String category="";
	String categoryid="";
	while(rs.next()) {
		category+=rs.getString("category")+",";		
		categoryid+=rs.getString("doc_no")+",";
  		} 
	//model=model.substring(0, model.length()-1);
	category=category.substring(0, category.length()>0?category.length()-1:0);
	response.getWriter().write(category+"####"+categoryid);
	
 	}
 	catch(Exception e){
 		e.printStackTrace();
 		
 	}
 	finally{
 		conn.close();
 	}
  %>
  
