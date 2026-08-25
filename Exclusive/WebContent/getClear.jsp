<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
ClsConnection ClsConnection=new ClsConnection();

	Connection conn = null;
	
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmtsys = conn.createStatement();
		
		CallableStatement s = conn.prepareCall("{CALL zz_spclearAll()}");
		int val = s.executeUpdate();
		
		
		
		response.getWriter().write(val+"####"+val);
		
		stmtsys.close();
		conn.close ();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
