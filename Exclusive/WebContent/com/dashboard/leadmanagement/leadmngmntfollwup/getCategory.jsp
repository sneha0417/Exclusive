<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection conobj= new ClsConnection();
	Connection conn = null;
	
	try{
	 	conn = conobj.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "SELECT category,doc_no FROM my_clcatm where status<>7 and dtype='CRM'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String category="";
		String categoryid="";
		while(rs.next()) {
			category+=rs.getString("category")+",";		
			categoryid+=rs.getString("doc_no")+",";
	  		} 
		
		category=category.substring(0, category.length()>0?category.length()-1:0);
		
		response.getWriter().write(category+"####"+categoryid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
