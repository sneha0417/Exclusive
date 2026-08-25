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
	String strSql = "select department, doc_no from my_dept where status<>7";
	ResultSet rs = stmt.executeQuery(strSql);
	//System.out.println(strSql);
	String dept="";
	String deptid="";
	while(rs.next()) {
		dept+=rs.getString("department")+",";		
		deptid+=rs.getString("doc_no")+",";
  		} 
	if(dept.length()>0){
		dept=dept.substring(0, dept.length()-1);	
	}
	
	response.getWriter().write(dept+"###"+deptid);
	
}
catch(Exception e){
	e.printStackTrace();
	
}
finally{
	conn.close();
}
%>
  
