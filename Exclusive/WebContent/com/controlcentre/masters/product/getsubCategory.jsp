<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
Connection conn = ClsConnection.getMyConnection();
String catid=request.getParameter("id");
System.out.println("===catid===="+catid);
 	try{
	Statement stmt = conn.createStatement ();
	String strSql = "select subcategory,doc_no  from my_scatm where status <>7 and catid="+catid+"";
	System.out.println("===strSql===="+strSql);
	ResultSet rs = stmt.executeQuery(strSql);
	String scategory="";
	String scategoryid="";
	while(rs.next()) {
		scategory+=rs.getString("subcategory")+",";		
		scategoryid+=rs.getString("doc_no")+",";
  		} 
	//model=model.substring(0, model.length()-1);
	scategory=scategory.substring(0, scategory.length()>0?scategory.length()-1:0);
	response.getWriter().write(scategory+"###"+scategoryid);
	
 	}
 	catch(Exception e){
 		e.printStackTrace();
 		
 	}
 	finally{
 		conn.close();
 	}
  %>
  
