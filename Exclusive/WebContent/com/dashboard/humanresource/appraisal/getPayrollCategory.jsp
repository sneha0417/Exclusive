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
		
		String strSql = "select doc_no,desc1 from hr_setpaycat where status=3";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String payrollcategory="";
		String payrollcategoryid="";
		while(rs.next()) {
			payrollcategory+=rs.getString("desc1")+",";		
			payrollcategoryid+=rs.getString("doc_no")+",";
	  		} 
		
		payrollcategory=payrollcategory.substring(0, payrollcategory.length()>0?payrollcategory.length()-1:0);
		
		response.getWriter().write(payrollcategory+"####"+payrollcategoryid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
