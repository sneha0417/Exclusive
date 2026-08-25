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
		
		String strSql = "select doc_no,desc1,code from hr_setallowance where status=3 and doc_no>0";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String allowance="";
		String allowanceid="";
		while(rs.next()) {
			allowance+=rs.getString("code")+",";		
			allowanceid+=rs.getString("doc_no")+",";
	  		} 
		
		allowance=allowance.substring(0, allowance.length()>0?allowance.length()-1:0);
		
		response.getWriter().write(allowance+"####"+allowanceid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
