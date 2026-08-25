<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	

	Connection conn = null;
	
	try{
		ClsConnection connDAO = new ClsConnection();
	 	conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select desc1,doc_no from my_vndtax where status=3 order by doc_no";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String type="";
		String typeid="";
		while(rs.next()) {
			type+=rs.getString("desc1")+",";		
			typeid+=rs.getString("doc_no")+",";
	  		} 
		
		type=type.substring(0, type.length()>0?type.length()-1:0);
		
		response.getWriter().write(type+"####"+typeid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
