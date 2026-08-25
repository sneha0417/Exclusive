 

<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
int method=0;
int method1=0;
Connection conn = null;
try
{	ClsConnection ClsConnection=new ClsConnection();   
  conn = ClsConnection.getMyConnection();

Statement stmt=conn.createStatement();

String chk="select method  from gl_prdconfig where field_nme='batch_no'";
ResultSet rs=stmt.executeQuery(chk); 
if(rs.next())
{
	
	method=rs.getInt("method");
}
String chk2="select method  from gl_prdconfig where field_nme='exp_date'";
ResultSet rs2=stmt.executeQuery(chk2); 
if(rs2.next())
{
	
	method1=rs2.getInt("method");
}

//System.out.println("-----method----"+method);
	response.getWriter().print(method+"::"+method1);
	stmt.close();
	conn.close();
}
catch(Exception e)
{
	
	conn.close();
}
  %>