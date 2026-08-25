<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
 	Connection conn =null;
ClsConnection ClsConnection=new ClsConnection();
try{	
	conn=ClsConnection.getMyConnection();
Statement stmt = conn.createStatement ();
	String strSql = "select desc1,status from gl_tariftype";
	ResultSet rs = stmt.executeQuery(strSql);
	//System.out.println(strSql);
	String tariftype="";
	String status="";
	while(rs.next()) {
		if(rs.getString("status").equalsIgnoreCase("1")){
			tariftype+=rs.getString("desc1")+",";	
		}
		
		//System.out.println(rs.getString("desc1"));
		
		
		
  		} 
	if(tariftype.length()>0){
		tariftype=tariftype.substring(0, tariftype.length()-1);	
	}
	
	response.getWriter().write(tariftype+"***"+status);
	stmt.close();
	conn.close();
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
%>