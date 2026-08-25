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
		
		String strSql = "SELECT doc_no,name,(SELECT max(doc_no) FROM hr_timesheetset where reftype='L') totleaves FROM hr_timesheetset where reftype='L'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String leave="";
		String leaveid="";
		String leavecount="";
		while(rs.next()) {
			leave+=rs.getString("name")+",";		
			leaveid+=rs.getString("doc_no")+",";
			leavecount+=rs.getString("totleaves")+",";
	  		} 
		
		leave=leave.substring(0, leave.length()>0?leave.length()-1:0);
		
		response.getWriter().write(leave+"####"+leaveid+"####"+leavecount);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
