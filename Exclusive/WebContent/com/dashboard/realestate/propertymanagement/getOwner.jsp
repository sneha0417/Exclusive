
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
ClsConnection ClsConnection=new ClsConnection();


    String menubrch=request.getParameter("menubranch");
	Connection conn = null;
	
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
 
	 String strSql = "SELECT doc_no,primary_owner FROM rl_propertryowner " ;
		System.out.println("sql ====== "+strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		
		String owner="",ownerId="";
		while(rs.next()) {
			owner+=rs.getString("primary_owner")+",";					
			ownerId+=rs.getString("doc_no")+",";
					
	  		} 
	 
		response.getWriter().write(ownerId+"####"+owner);
  
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
 
 
 
 
 
 
 
 
 