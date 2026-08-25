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
		
		int statusid=Integer.parseInt(request.getParameter("statusid").trim());
		int srno=Integer.parseInt(request.getParameter("srno").trim());
		int result=0;
		
		String strSql = "update is_pgline set status=7 where status_id="+statusid+" and srno="+srno+"";
		int rs = stmt.executeUpdate(strSql);
		
		response.getWriter().print(rs);

		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
	  
%>
  
