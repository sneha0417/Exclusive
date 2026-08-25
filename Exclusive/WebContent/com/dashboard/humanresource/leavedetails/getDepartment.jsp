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
		
		String strSql = "select doc_no,desc1 from hr_setdept where status=3";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String department="";
		String departmentid="";
		while(rs.next()) {
			department+=rs.getString("desc1")+",";	
			departmentid+=rs.getString("doc_no")+",";
	  		} 
		
		department=department.substring(0, department.length()>0?department.length()-1:0);
		
		response.getWriter().write(department+"####"+departmentid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
