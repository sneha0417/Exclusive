<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
 	Connection conn = ClsConnection.getMyConnection();

try{
	Statement stmt = conn.createStatement ();
	String strSql = "select doc_no,yom from gl_yom";
	ResultSet rs = stmt.executeQuery(strSql);
	String yom="";
	String yomid="";
	while(rs.next()) {
		yom+=rs.getString("yom")+",";		
		yomid+=rs.getString("doc_no")+",";
  		} 
	if(yom.length()>0){
		yom=yom.substring(0, yom.length()-1);	
	}
	
	response.getWriter().write(yom+"####"+yomid);
	stmt.close();
	conn.close();
 
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>
  
