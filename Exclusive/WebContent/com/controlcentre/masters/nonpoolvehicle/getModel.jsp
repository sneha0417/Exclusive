<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
ClsConnection ClsConnection=new ClsConnection();



Connection conn = null;
try{
	conn=ClsConnection.getMyConnection();
String temp=request.getParameter("id");
 	
	Statement stmt = conn.createStatement ();
	String strSql = "select vtype,doc_no  from gl_vehmodel where status <> 7 and brandid="+temp;
	ResultSet rs = stmt.executeQuery(strSql);
	String model="";
	String id="";
	while(rs.next()) {
		model+=rs.getString("vtype")+",";		
		id+=rs.getString("doc_no")+",";
  		} 
	if(model.length()>0){
		model=model.substring(0, model.length()>0?model.length()-1:0);	
	}
	
	stmt.close();
	conn.close();
	response.getWriter().write(model+"***"+id);
	
	}
 	catch(Exception e){
 		e.printStackTrace();
 		conn.close();
 	}
finally{
	conn.close();
}
  %>
