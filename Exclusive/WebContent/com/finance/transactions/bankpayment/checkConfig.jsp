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
		String sql = "",result="";
		int AlreadyExists=0;

		String chequeno=request.getParameter("chequeno");
		String bankacno=request.getParameter("bankacno");
		String docno=request.getParameter("docno");
		String mode=request.getParameter("mode");
	    
		
	        sql = "select method from gl_config where field_nme like'paymentauthorizationformprint'";
		
	    ResultSet rs = stmt.executeQuery(sql);
		
		while(rs.next()) {
			result=rs.getString("method");
		} 
		
		response.getWriter().print(result);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  