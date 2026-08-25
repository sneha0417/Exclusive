<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
	Connection conn = null;
	ClsConnection connDAO=new ClsConnection();

	
	try{
	 	conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select doc_no allowanceid,code allowance from hr_setallowance where status=3 and doc_no>0";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String allowance="";
		String allowanceid="";
		while(rs.next()) {
			allowance+=rs.getString("allowance")+",";		
			allowanceid+=rs.getString("allowanceid")+",";
	  		} 
				
		String sql = "select count(doc_no) totallowances from hr_setallowance where status=3 and doc_no>0";
		ResultSet rs1 = stmt.executeQuery(sql);
		
		String allowancecount="";
		while(rs1.next()) {
			allowancecount=rs1.getString("totallowances");
	  		}
		
		allowance=allowance.substring(0, allowance.length()>0?allowance.length()-1:0);
		
		response.getWriter().write(allowance+"####"+allowanceid+"####"+allowancecount);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
