
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	




String std_cost = request.getParameter("std_cost")==null?"0":request.getParameter("std_cost").trim();

//System.out.println("----std_cost-----"+std_cost);
String brandid = request.getParameter("brandid")==null?"0":request.getParameter("brandid").trim();


String psrno = request.getParameter("psrno")==null?"0":request.getParameter("psrno").trim();

 

//System.out.println("----brandid-----"+brandid);
double std_costs=Double.parseDouble(std_cost);
double per_margin=0;
ClsConnection ClsConnection=new ClsConnection();

Connection conn =null;
try
{
  conn = ClsConnection.getMyConnection();

Statement stmt=conn.createStatement();

String chk="select per_margin from my_brandmargin where "+std_costs+" between from_amt and to_amt and brdid='"+brandid+"' ";

//System.out.println("----chk-----"+chk);

ResultSet rs=stmt.executeQuery(chk); 
if(rs.next())
{
	
	per_margin=rs.getDouble("per_margin");
}

if(per_margin==0)
{
String chk1="select per_margin from my_brandmargin where doc_no=(select max(doc_no) from my_brandmargin where  brdid='"+brandid+"') ";

//System.out.println("----chk1-----"+chk1);

ResultSet rs1=stmt.executeQuery(chk1); 
if(rs1.next())
{
	
	per_margin=rs1.getDouble("per_margin");
}
}
double sellingprice=0;
String chk2="select nettotal/qty sellingprice from my_invd where doc_no=(select max(doc_no) from my_invd where psrno='"+psrno+"') ";

//System.out.println("----chk2-----"+chk2);

ResultSet rs2=stmt.executeQuery(chk2); 
if(rs2.next())
{
	
	sellingprice=rs2.getDouble("sellingprice");
}



//System.out.println("----per_margin-----"+per_margin);
	response.getWriter().print(per_margin+"::"+sellingprice);
	stmt.close();
	conn.close();
}
catch(Exception e)
{
	conn.close();
	e.printStackTrace();
}
  %>
  













					