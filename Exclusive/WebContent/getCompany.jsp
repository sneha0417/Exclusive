<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	

	ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	
	try{
		String cmp="",cmpId="",amcRenewalMsg="";
		 	 
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select company,comp_id,COALESCE(if(projectstatus=2 and DATEDIFF(era,CURDATE())=0,'AMC Expires Today',"
				+ "if(projectstatus=2 and (DATEDIFF(era,CURDATE()) between 1 and 10),CONCAT('AMC Expires in ',DATEDIFF(era,CURDATE()),' Day(s)'),"
				+ "if(projectstatus=2 and (DATEDIFF(era,CURDATE())<0),CONCAT('AMC Renewal Pending ',DATEDIFF(CURDATE(),era),' Day(s)'),''))),'') amcRenewalMsg from my_comp";
		ResultSet rs = stmt.executeQuery(strSql);
		
		while(rs.next()) {
			cmp+=rs.getString("company")+",";
			cmpId+=rs.getString("comp_id")+",";
			amcRenewalMsg=rs.getString("amcRenewalMsg");
	  		} 
		 
		response.getWriter().write(cmp+"####"+cmpId+"####"+amcRenewalMsg);

		stmt.close();
		conn.close();
		
 
	}catch(Exception e){
	 
	 response.getWriter().print("NOTGET");	 
	 	e.printStackTrace();
	 	
	  
	}finally{
		
		if(conn!=null)
	 	{
			// System.out.println("--1-conn----"+conn) ;
		conn.close();
	 	}
	}
  %>
  
