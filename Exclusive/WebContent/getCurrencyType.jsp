<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
ClsConnection ClsConnection=new ClsConnection();

	Connection conn = null;
	
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String curr=request.getParameter("curr");
		
		String strSql = "select type,c_rate from my_curr where doc_no='"+curr+"'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String type="",rate="";
		while(rs.next()) {
			type+=rs.getString("type")+",";
			rate+=rs.getString("c_rate")+",";
	  		} 
		
		type=type.substring(0, type.length()-1);
		rate=rate.substring(0, rate.length()-1);
		
		response.getWriter().write(type+"####"+rate);
		
		session.setAttribute("CURRENCYTYPE", type);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
