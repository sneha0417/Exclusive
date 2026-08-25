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
		
		String strSql = "select method from gl_config where field_nme='tax'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String method="";
		while(rs.next()) {
			method=rs.getString("method");
		} 

		response.getWriter().write(method);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  