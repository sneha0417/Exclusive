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
		
		String strSql = "select m.doc_no,m.desc1 from hr_paycode p left join hr_setpaycat m on p.catid=m.doc_no where p.status=3 and m.status=3 and p.timesheet=1";
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
  
