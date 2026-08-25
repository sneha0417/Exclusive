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
	String strSql = "select category,doc_no  from my_catm where status <> 7 ";
	
	System.out.println("===strSql====="+strSql);
	ResultSet rs = stmt.executeQuery(strSql);
	String model="";
	String modelid="";
	while(rs.next()) {
		model+=rs.getString("category")+",";		
		modelid+=rs.getString("doc_no")+",";
  		} 
	//model=model.substring(0, model.length()-1);
	model=model.substring(0, model.length()>0?model.length()-1:0);
	response.getWriter().write(model+"####"+modelid);
	stmt.close();
	conn.close();
 	}
 	catch(Exception e){
 		e.printStackTrace();
 		conn.close();
 	}
  %>
  
