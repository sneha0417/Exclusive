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
		
		String strSql = "select refno,name from hr_timesheetset where reftype='L'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String leave="";
		String leaveid="";
		while(rs.next()) {
			leave+=rs.getString("name")+",";		
			leaveid+=rs.getString("refno")+",";
	  		} 
		
		leave=leave.substring(0, leave.length()>0?leave.length()-1:0);
		
		response.getWriter().write(leave+"####"+leaveid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
