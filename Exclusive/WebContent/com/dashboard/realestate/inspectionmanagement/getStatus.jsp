
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
ClsConnection ClsConnection=new ClsConnection();


    String menubrch=request.getParameter("menubranch");
	Connection conn = null;
	
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
/* 		
		String strSql = "select branchname,mclose,doc_no,(select code from my_curr where doc_no=curId) as curr,"
				+"curId from my_brch where cmpid='"+session.getAttribute("COMPANYID")+"'"; */
		

	 String strSql = "select rowno,name from rl_istatus where status=1 order by seqno" ;
		System.out.println("sql ====== "+strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		
		String stat="",statId="";
		while(rs.next()) {
			stat+=rs.getString("name")+",";					
			statId+=rs.getString("rowno")+",";
					
	  		} 
	
		String brn[]=stat.split(",");
		String brnId[]=statId.split(",");
		
		
		response.getWriter().write(statId+"####"+stat);
 
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
 
 
 
 
 
 
 
 
 