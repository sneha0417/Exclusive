
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
 
	 String strSql = "SELECT doc_no,prtype  FROM rl_propertytype  order by doc_no" ;
		System.out.println("sql ====== "+strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		
		String ptype="",ptypeId="";
		while(rs.next()) {
			ptype+=rs.getString("prtype")+",";					
			ptypeId+=rs.getString("doc_no")+",";
					
	  		} 
	 
		response.getWriter().write(ptypeId+"####"+ptype);
  
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
 
 
 
 
 
 
 
 
 