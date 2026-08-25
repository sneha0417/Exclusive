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
		
		String strSql = "SELECT doc_no,desc1 FROM hr_setagent where status=3";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String salesagent="";
		String salesagentid="";
		while(rs.next()) {
			salesagent+=rs.getString("desc1")+",";		
			salesagentid+=rs.getString("doc_no")+",";
	  		} 
		
		salesagent=salesagent.substring(0, salesagent.length()>0?salesagent.length()-1:0);
		
		response.getWriter().write(salesagent+"####"+salesagentid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
