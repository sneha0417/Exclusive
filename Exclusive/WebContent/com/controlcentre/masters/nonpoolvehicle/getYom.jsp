<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
ClsConnection ClsConnection=new ClsConnection();


 	Connection conn = null;
try{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select yom,doc_no from gl_yom";
	ResultSet rs = stmt.executeQuery(strSql);
	String yom="";
	String id="";
	while(rs.next()) {
		yom+=rs.getString("yom")+",";		
		id+=rs.getString("doc_no")+",";
  		} 
	
	if(yom.length()>0){
		yom=yom.substring(0, yom.length()-1);	
	}
	stmt.close();
	conn.close();
	response.getWriter().write(yom+"***"+id);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
	%>
  
