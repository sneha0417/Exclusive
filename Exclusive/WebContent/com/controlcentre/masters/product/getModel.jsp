<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
Connection conn = ClsConnection.getMyConnection();
String temp=request.getParameter("id");
 	try{
	Statement stmt = conn.createStatement ();
	String strSql = "select DOC_NO, MODEL  from my_model where status <> 7 and brandid="+temp;
	ResultSet rs = stmt.executeQuery(strSql);
	String model="";
	String modelid="";
	while(rs.next()) {
		model+=rs.getString("MODEL")+",";		
		modelid+=rs.getString("doc_no")+",";
  		} 
	//model=model.substring(0, model.length()-1);
	model=model.substring(0, model.length()>0?model.length()-1:0);
	response.getWriter().write(model+"####"+modelid);
	
 	}
 	catch(Exception e){
 		e.printStackTrace();
 		
 	}
 	finally{
 		conn.close();
 	}
  %>
  
