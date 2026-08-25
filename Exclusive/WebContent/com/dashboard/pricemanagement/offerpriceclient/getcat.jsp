<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();

	Connection conn = null;
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		
		String strSql = " select cat_name,doc_no from my_clcatm where dtype='CRM' and status=3";      
				
		// System.out.println("-----------"+strSql);
		
		ResultSet rs = stmt.executeQuery(strSql);
		
		String cat="",catid="";
		while(rs.next()) {
			cat+=rs.getString("cat_name")+",";
		    catid+=rs.getString("doc_no")+",";
				} 
		
		String cats[]=cat.split(",");
		String catids[]=catid.split(",");
		
		cat=cat.substring(0, cat.length()-1);
		catid=catid.substring(0, catid.length()-1);
		
		response.getWriter().write(catid+"####"+cat);
		 
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  