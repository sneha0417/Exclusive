<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();

 	Connection conn = null;
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "SELECT sal_name,doc_no from my_salm where status<>7";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String salesagent="";
		String salesagentid="";
		while(rs.next()) {
			salesagent+=rs.getString("sal_name")+",";		
			salesagentid+=rs.getString("doc_no")+",";
	  		} 
		
		salesagent=salesagent.substring(0, salesagent.length()>0?salesagent.length()-1:0);
		
		response.getWriter().write(salesagent+"####"+salesagentid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}
  %>
  
