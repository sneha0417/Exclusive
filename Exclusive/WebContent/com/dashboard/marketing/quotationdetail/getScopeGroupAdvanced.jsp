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
		
		String contrmode=request.getParameter("contrmode")==""?"0":request.getParameter("contrmode");
		
		String strSql ="";
		
		if(!(contrmode.equalsIgnoreCase("AMC") || contrmode.equalsIgnoreCase("amc"))) {
		    strSql = "select doc_no, scopegroup from my_scopegrp where status=3 and doc_no=2";
		} else {
			strSql = "select doc_no, scopegroup from my_scopegrp where status=3 and doc_no=1";
		}
		
		ResultSet rs = stmt.executeQuery(strSql);

		String scopegroup="";
		String scopegroupid="";
		while(rs.next()) {
			scopegroup+=rs.getString("scopegroup")+",";		
			scopegroupid+=rs.getString("doc_no")+",";
	  		} 
		
		scopegroup=scopegroup.substring(0, scopegroup.length()>0?scopegroup.length()-1:0);
		
		response.getWriter().write(scopegroup+"####"+scopegroupid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}
  %>
  
