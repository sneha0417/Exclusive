<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();


	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		String refno=request.getParameter("refno")==""?"0":request.getParameter("refno");
		
		String strSql = "select alpha from hr_timesheetset where refno="+refno+"";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String alpha="";
		while(rs.next()) {
			alpha=rs.getString("alpha");
		} 
		
		response.getWriter().write(alpha);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  