<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();

 	Connection conn = ClsConnection.getMyConnection();
try{
	Statement stmt = conn.createStatement ();
	String strSql = "select vtype,doc_no  from gl_vehmodel where status <> 7 ";
	ResultSet rs = stmt.executeQuery(strSql);
	String model="";
	String modelid="";
	while(rs.next()) {
		model+=rs.getString("vtype")+",";		
		modelid+=rs.getString("doc_no")+",";
  		} 
	if(model.length()>0){
		model=model.substring(0, model.length()-1);	
	}
	
	response.getWriter().write(model+"####"+modelid);
	stmt.close();
	conn.close();
 
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	
	%>
  
