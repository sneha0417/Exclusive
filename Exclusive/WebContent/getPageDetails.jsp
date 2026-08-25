<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
ClsConnection ClsConnection=new ClsConnection();

	Connection conn = null;
	
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String name=request.getParameter("name");
		
		String strSql = "select func,doc_type from my_menu where menu_name='"+name+"'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		while(rs.next()) {
					String func=rs.getString("func");
					String doc_type=rs.getString("doc_type");
					response.getWriter().write(func+"$$$$$"+doc_type);
			  session.setAttribute("FormName", name);
			  session.setAttribute("Code", doc_type);
			  System.out.println("==========="+func+"$$$$$"+doc_type);
		} 
		
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
