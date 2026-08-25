<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
	Connection conn=null;
try{
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select timezone,doc_no from my_timezone where status=3";
	ResultSet rs = stmt.executeQuery(strSql);
	String zone="";
	String zoneid="";
	while(rs.next()) {
		zone+=rs.getString("timezone")+":::";		
		zoneid+=rs.getString("doc_no")+":::";
				
  		} 
	zone=zone.substring(0, zone.length()-1);
	stmt.close();
	response.getWriter().write(zone+"***"+zoneid);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
	%>