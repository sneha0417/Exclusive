<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%		Connection conn = null;
try{
	String curr=request.getParameter("curr");
ClsConnection ClsConnection=new ClsConnection();
 	  conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select c_rate from my_curr where doc_no='"+curr+"'";
	ResultSet rs = stmt.executeQuery(strSql);
	Double rate=0.0;
	while(rs.next()) {
		rate=rs.getDouble("c_rate");
  		} 
	response.getWriter().write(rate.toString());
	stmt.close();
	conn.close();
}
catch(Exception e)
{
	conn.close();
}
  %>
  
