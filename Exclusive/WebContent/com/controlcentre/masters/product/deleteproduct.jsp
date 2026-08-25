<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
 

Connection conn =null;
	
ClsConnection  ClsConnection=new ClsConnection();
int method=0;
System.out.println("---2345678987654321123456789876543211234567890---");
try
{
  conn = ClsConnection.getMyConnection();

Statement stmt=conn.createStatement();

String chk=" select (sum(op_qty)-(sum(out_qty)+sum(rsv_qty)+sum(del_qty))) qty from my_prddin where prdid=8  group by prdid  "
           +" having (sum(op_qty)-(sum(out_qty)+sum(rsv_qty)+sum(del_qty)))>0 ";
ResultSet rs=stmt.executeQuery(chk); 
if(rs.next())
{
	
	method=1;
}
conn.close();
stmt.close();
System.out.println("-----method----"+method);
response.getWriter().print(method);
}
catch(Exception e)
{

	e.printStackTrace();
	conn.close();	
}
//System.out.println("-----method----"+method);
	
  %>
  













					