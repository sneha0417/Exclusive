<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();

String regionId = request.getParameter("region")==null?"":request.getParameter("region").trim().toString();

System.out.println("regionId===="+regionId);
String sql1="";
 	Connection conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
		if(regionId!=""){
		sql1=" and reg_id="+regionId;
	}
	String strSql = "select country_name,doc_no from my_acountry where status<>7 "+sql1;
	
	ResultSet rs = stmt.executeQuery(strSql);
	System.out.println(strSql);
	String brand="";
	String brandid="";
	while(rs.next()) {
		brand+=rs.getString("country_name")+",";		
		brandid+=rs.getString("doc_no")+",";
  		} 
	brand=brand.substring(0, brand.length()-1);
	response.getWriter().write(brand+"***"+brandid);
	stmt.close();
	conn.close();
  %>