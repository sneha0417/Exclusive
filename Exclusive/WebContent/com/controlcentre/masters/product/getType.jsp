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
	String strSql = "select DOC_NO, PRODUCTTYPE from my_ptype where status<>7";
	ResultSet rs = stmt.executeQuery(strSql);
	//System.out.println(strSql);
	String type="";
	String typeid="";
	while(rs.next()) {
		type+=rs.getString("PRODUCTTYPE")+",";		
		typeid+=rs.getString("DOC_NO")+",";
  		} 
	if(type.length()>0){
		type=type.substring(0, type.length()-1);	
	}
	
	response.getWriter().write(type+"###"+typeid);
	
}
catch(Exception e){
	e.printStackTrace();
	
}
finally{
	conn.close();
}
%>
  
