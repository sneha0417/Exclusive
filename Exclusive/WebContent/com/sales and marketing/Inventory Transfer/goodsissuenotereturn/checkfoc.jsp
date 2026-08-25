


<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
int method=0;
Connection conn =null;
try
{
  conn = ClsConnection.getMyConnection();

Statement stmt=conn.createStatement();

String chk="select method  from gl_prdconfig where field_nme='foc'";
ResultSet rs=stmt.executeQuery(chk); 
if(rs.next())
{
	
	method=rs.getInt("method");
}

//System.out.println("-----method----"+method);
	response.getWriter().print(method);
	stmt.close();
	conn.close();
}
catch(Exception e)
{
	conn.close();
}
  %>
  













					