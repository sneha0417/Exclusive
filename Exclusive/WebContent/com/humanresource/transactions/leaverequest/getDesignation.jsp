<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

	
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "SELECT doc_no,desc1 FROM hr_setdesig where status=3";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String designation="";
		String designationid="";
		while(rs.next()) {
			designation+=rs.getString("desc1")+",";		
			designationid+=rs.getString("doc_no")+",";
	  		} 
		
		designation=designation.substring(0, designation.length()>0?designation.length()-1:0);
		
		response.getWriter().write(designation+"####"+designationid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
