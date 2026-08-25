<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();

 	Connection conn =null;
try{
	conn= ClsConnection.getMyConnection();
Statement stmt = conn.createStatement ();
	String strSql = "select fname,doc_no from gl_vehfin where status <> 7;";
	ResultSet rs = stmt.executeQuery(strSql);
	//System.out.println(strSql);
	String fin="";
	String finid="";
	while(rs.next()) {
		fin+=rs.getString("fname")+",";		
		finid+=rs.getString("doc_no")+",";
  		} 
	if(fin.length()>0){
		fin=fin.substring(0, fin.length()-1);	
	}
	stmt.close();
	conn.close();
	response.getWriter().write(fin+"####"+finid);
	
 
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
	%>
  
