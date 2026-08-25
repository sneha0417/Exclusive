 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>

<%	
ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
 int method=0;
		 
		String strSql = "select method from gl_config where field_nme='chlexportdata'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String dtype="";
		if(rs.next()) {
			method=rs.getInt("method");
	  		} 
		 
		 
		response.getWriter().print(method);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>