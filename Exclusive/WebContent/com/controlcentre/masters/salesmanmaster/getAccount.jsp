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
		
		String test=request.getParameter("id");
		
		String strSql = "select description,doc_no from my_head where atype='"+test+"'";
		ResultSet rs = stmt.executeQuery(strSql);
	
		String desc="";
		String id="";
		while(rs.next()) {
			desc+=rs.getString("description")+",";		
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
  
