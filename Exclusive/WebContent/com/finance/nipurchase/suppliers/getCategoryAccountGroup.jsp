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
		String category=request.getParameter("category");
		
		String strSql = "select acc_group from my_clcatm where status=3 and doc_no="+category;
		ResultSet rs = stmt.executeQuery(strSql);
		
		String groupid="";
		while(rs.next()) {
			groupid=rs.getString("acc_group");
		} 
		
		response.getWriter().write(groupid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
