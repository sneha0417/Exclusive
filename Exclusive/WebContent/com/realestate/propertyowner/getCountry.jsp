<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();
	
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		
		String strSql = "select DOC_NO, NATION from my_natm";
		System.out.println(strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		
		String country="",countryId="";
		while(rs.next()) {
			country+=rs.getString("NATION")+":";
			countryId+=rs.getString("DOC_NO")+":";
				} 
		 
		 /*  country=country.substring(0, country.length()-1);
		countryId=countryId.substring(0, countryId.length()-1);   */
		
		response.getWriter().print(countryId+"####"+country);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>