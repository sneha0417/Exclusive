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
		
		String strSql = "select doc_no,monthname from hr_month where status=3";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String monthname="";
		String monthnameid="";
		while(rs.next()) {
			monthname+=rs.getString("monthname")+",";	
			monthnameid+=rs.getString("doc_no")+",";
	  		} 
		
		monthname=monthname.substring(0, monthname.length()>0?monthname.length()-1:0);
		
		response.getWriter().write(monthname+"####"+monthnameid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
