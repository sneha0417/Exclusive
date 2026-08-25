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
		
		String strSql = "select distinct(atype) from my_head where atype='GL' or atype='AP'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String desc="";
		
		while(rs.next()) {
			desc+=rs.getString("atype")+",";		
	  		} 
		
		desc=desc.substring(0, desc.length()-1);
		response.getWriter().write(desc);
	  
		stmt.close();
	 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
  
