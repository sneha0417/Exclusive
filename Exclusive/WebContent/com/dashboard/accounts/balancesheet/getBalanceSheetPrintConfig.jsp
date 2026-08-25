<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	

	ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	
	try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			
			String strSql = "select method from gl_config where field_nme='balanceSheetPrint'";
			ResultSet rs = stmt.executeQuery(strSql);
			
			String method="";
			while(rs.next()) {
				method=rs.getString("method");
			} 
			response.getWriter().write(method);
			
			stmt.close();
			conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	} finally{
		conn.close();
	}
  %>
  