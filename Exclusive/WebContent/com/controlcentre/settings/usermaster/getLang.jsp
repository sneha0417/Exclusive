<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
Connection conn=null ;
try{
 	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select lang from my_langconfig;";
	ResultSet rs = stmt.executeQuery(strSql);
	String lang="";
	while(rs.next()) {
		lang+=rs.getString("lang")+",";
  		} 
	lang=lang.substring(0, lang.length()-1);
	response.getWriter().write(lang);
	stmt.close();
	conn.close();
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}  
  %>
  
