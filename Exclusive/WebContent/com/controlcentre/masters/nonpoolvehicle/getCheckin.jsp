<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
ClsConnection ClsConnection=new ClsConnection();


Connection conn =null;
try{
 	
 	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select doc_no,sal_name from my_salesman where status<>7 and sal_type='CHK'";
	ResultSet rs = stmt.executeQuery(strSql);
	String check="";
	String id="";
	while(rs.next()) {
		check+=rs.getString("sal_name")+",";		
		id+=rs.getString("doc_no")+",";
  		} 
	if(check.length()>0){
		check=check.substring(0, check.length()-1);	
	}
	stmt.close();
	conn.close();
	response.getWriter().write(check+"***"+id);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
	%>
  
