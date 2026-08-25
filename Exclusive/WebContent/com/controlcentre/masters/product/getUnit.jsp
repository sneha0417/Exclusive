<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
 	Connection conn = null;
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn=ClsConnection.getMyConnection();
Statement stmt = conn.createStatement ();
	String strSql = "select UNIT,doc_no from my_unitm where status<>7";
	ResultSet rs = stmt.executeQuery(strSql);
	//System.out.println(strSql);
	String unit="";
	String unitid="";
	while(rs.next()) {
		unit+=rs.getString("UNIT")+",";		
		unitid+=rs.getString("DOC_NO")+",";
  		} 
	if(unit.length()>0){
		unit=unit.substring(0, unit.length()-1);	
	}
	
	response.getWriter().write(unit+"###"+unitid);
	
}
catch(Exception e){
	e.printStackTrace();
	
}
finally{
	conn.close();
}
%>
  
