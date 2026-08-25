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
		
		String strSql = "select name,doc_no from gw_projects where status=1";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String name="";
		String nameid="";
		while(rs.next()) {
			name+=rs.getString("name")+",";		
			nameid+=rs.getString("doc_no")+",";
	  		} 
		
		name=name.substring(0, name.length()>0?name.length()-1:0);
		
		response.getWriter().write(name+"####"+nameid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
