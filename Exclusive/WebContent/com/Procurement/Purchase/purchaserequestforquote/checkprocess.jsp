


<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
String masterdoc_no=request.getParameter("masterdoc_no")==null?"0":request.getParameter("masterdoc_no");
int pstatus=0;
	Connection conn = null;
try{	ClsConnection ClsConnection=new ClsConnection();
  conn = ClsConnection.getMyConnection();

Statement stmt=conn.createStatement();

String chk="select pstatus from my_prfqm where doc_no='"+masterdoc_no+"'";
System.out.println("-----chk----"+chk);
ResultSet rs=stmt.executeQuery(chk); 
if(rs.next())
{
	
	pstatus=rs.getInt("pstatus");
}

//System.out.println("-----method----"+method);
	response.getWriter().print(pstatus);
	stmt.close();
	conn.close();
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
  %>
  













					