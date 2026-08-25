<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();

String regionId = request.getParameter("region")==null?"":request.getParameter("region").trim().toString();
String countryId =request.getParameter("country")==null?"":request.getParameter("country").trim().toString();


String sql1="";
String sql2="";
 	Connection conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	if(regionId!=""){
		sql1=" and reg_id="+regionId;
	}
	if(countryId!=""){
		sql2=" and country_id="+countryId;
	}
	String strSql = "select city_name,doc_no from my_acity where status<>7 "+sql1+sql2;
	ResultSet rs = stmt.executeQuery(strSql);
	System.out.println(strSql);
	String brand="";
	String brandid="";
	while(rs.next()) {
		brand+=rs.getString("city_name")+",";		
		brandid+=rs.getString("doc_no")+",";
  		} 
	brand=brand.substring(0, brand.length()-1);
	response.getWriter().write(brand+"***"+brandid);
	stmt.close();
	conn.close();
  %>