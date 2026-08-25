<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
	Connection conn = null;

	try{
		ClsConnection connDAO = new ClsConnection();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String cardtype=request.getParameter("cardtype");
		String netamt=request.getParameter("netamt");
		String paytype=request.getParameter("paytype");
		String comm=request.getParameter("comm");
		String index=request.getParameter("index");
				
		//response.getWriter().write(commissionNetTotal+":"+commissionTotal+":"+index);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  