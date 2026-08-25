<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
	ClsConnection ClsConnection=new ClsConnection();

	Connection conn = null;
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		
		String scopegroup=request.getParameter("scopegroup")==""?"0":request.getParameter("scopegroup");
		
		String scope="",scopeid="",scopeproduct="1";
		
		if(scopegroup.equalsIgnoreCase("3")) {
			
			String strSql = "select doc_no,scode,product from my_scope where status=3 and groupid=3";
		    ResultSet rs = stmt.executeQuery(strSql);
			
			while(rs.next()) {
				scope=rs.getString("scode");		
				scopeid=rs.getString("doc_no");
				scopeproduct=rs.getString("product");
		  	} 
		} 
		
		response.getWriter().write(scope+"####"+scopeid+"####"+scopeproduct);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}
  %>
  
