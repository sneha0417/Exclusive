<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%	
System.out.println("viewdetails");
ClsConnection objconn=new ClsConnection();
Connection conn = null;
int method=0;
try{
	conn = objconn.getMyConnection();
	Statement stmt = conn.createStatement();
	String strSql = "select method from gl_config where field_nme='printcheck'";
	System.out.println("strSql"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);
	while(rs.next()) {
		method=rs.getInt("method");
	} 
	stmt.close();
	conn.close();
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(method+"");

%>
  