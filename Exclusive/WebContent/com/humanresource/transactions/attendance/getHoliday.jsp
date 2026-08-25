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
		
		String strSql = "select refno,name from hr_timesheetset where reftype='H'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String holiday="";
		String holidayid="";
		while(rs.next()) {
			holiday+=rs.getString("name")+",";		
			holidayid+=rs.getString("refno")+",";
	  		} 
		
		holiday=holiday.substring(0, holiday.length()>0?holiday.length()-1:0);
		
		response.getWriter().write(holiday+"####"+holidayid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
