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
		
		String strSql = "select acno from my_account where codeno='PDCRV'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String pdcaccount="";
		while(rs.next()) {
			pdcaccount=rs.getString("acno");
				} 
		response.getWriter().write(pdcaccount);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  