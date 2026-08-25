 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
int method=0;
double value=0;
Connection conn = null;
try
{	ClsConnection ClsConnection=new ClsConnection();
  conn = ClsConnection.getMyConnection();

Statement stmt=conn.createStatement();

 

String chk="select method,coalesce(value,0) value   from gl_prdconfig where field_nme='roundof' ";
System.out.println("==========chk================="+chk);

ResultSet rs=stmt.executeQuery(chk); 
if(rs.next())
{
	
	method=rs.getInt("method");
	
	value=rs.getDouble("value");
}

 
	response.getWriter().print(method+"::"+value);
	stmt.close();
	conn.close();
}
catch(Exception e)
{
	
	conn.close();
}
  %>