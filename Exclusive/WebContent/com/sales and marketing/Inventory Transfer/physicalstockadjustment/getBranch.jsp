
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
 
		

	 String strSql = "select b.branchname,b.doc_no from my_brch b where  b.status<>7" ;
		//System.out.println("sql ====== "+strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		
		String brnch="",currency="",brnchId="",currId="",mClose="",curType="";
	 
		while(rs.next()) {
					brnch+=rs.getString("branchname")+",";
					 
					brnchId+=rs.getString("doc_no")+",";
					
					
					  
	  		} 
	
 
		
		response.getWriter().write(brnchId+"####"+brnch);
 
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
 
 
 
 
 
 
 
 
 