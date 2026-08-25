<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

String usertoid=request.getParameter("usertoid").trim();
//System.out.println("===jobtype==="+usertoid);

String msg=request.getParameter("msg").trim();
String userfrmid=session.getAttribute("USERID").toString().trim();

   java.util.Date date=new java.util.Date();
   java.sql.Date sd=ClsCommon.getSqlDate(date);
   
 	Connection conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "insert into my_mesngr(userfrm, userto, mesg, date) values("+userfrmid+",'"+usertoid+"','"+msg+"','"+sd+"')";
	//System.out.println("strSql======"+strSql);
	int rs = stmt.executeUpdate(strSql);
	
	System.out.println("result set"+rs);
	
	response.getWriter().print(rs);
	System.out.println("aaaaaa       "+rs);
	stmt.close();
	conn.close();
	  
  %>
  
