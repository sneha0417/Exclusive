<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
Connection conn = ClsConnection.getMyConnection();
try{
	
String temp=request.getParameter("id");
System.out.println(temp);
 
	Statement stmt = conn.createStatement ();
	String strSql = "select level from gl_vehgroup where status <> 7 and doc_no="+temp;
	System.out.println(strSql);
	ResultSet rs = stmt.executeQuery(strSql);
	//System.out.println(strSql);
	String level="";

	if(rs.next()) {
		level=rs.getString("level");		

  		} 
	response.getWriter().write(level);
	stmt.close();
	conn.close();
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>
  
