<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection= new ClsConnection();

 	Connection conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select reg_name,doc_no from my_aregion where status<>7";
	ResultSet rs = stmt.executeQuery(strSql);
	System.out.println(strSql);
	String brand="";
	String brandid="";
	while(rs.next()) {
		brand+=rs.getString("reg_name")+",";		
		brandid+=rs.getString("doc_no")+",";
  		} 
	brand=brand.substring(0, brand.length()-1);
	response.getWriter().write(brand+"***"+brandid);
	stmt.close();
	conn.close();
  %>