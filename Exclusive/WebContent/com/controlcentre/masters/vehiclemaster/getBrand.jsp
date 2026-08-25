<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
 	Connection conn = null;
try{	
	conn=ClsConnection.getMyConnection();
Statement stmt = conn.createStatement ();
	String strSql = "select brand_name,doc_no from gl_vehbrand where status<>7";
	ResultSet rs = stmt.executeQuery(strSql);
	//System.out.println(strSql);
	String brand="";
	String brandid="";
	while(rs.next()) {
		brand+=rs.getString("brand_name")+",";		
		brandid+=rs.getString("doc_no")+",";
  		} 
	if(brand.length()>0){
		brand=brand.substring(0, brand.length()-1);	
	}
	stmt.close();
	conn.close();
	response.getWriter().write(brand+"***"+brandid);
	
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
%>
  
