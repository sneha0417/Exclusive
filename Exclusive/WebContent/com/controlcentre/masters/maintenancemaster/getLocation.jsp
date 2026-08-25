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
		
		String test=session.getAttribute("BRANCHID").toString();
		
		String strSql = "select doc_no,loc_name from my_locm where status<>7 and brhid="+test;
		ResultSet rs = stmt.executeQuery(strSql);
		
		String desc="";
		String id="";
		while(rs.next()) {
			desc+=rs.getString("loc_name")+",";		
			id+=rs.getString("doc_no")+",";
	  		} 
		desc=desc.substring(0, desc.length()-1);
		
		response.getWriter().write(desc+"***"+id);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}

%>
  
