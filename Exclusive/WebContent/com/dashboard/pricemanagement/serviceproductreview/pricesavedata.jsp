  <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
ClsConnection ClsConnection=new ClsConnection();
 
 
 
String pdocno=request.getParameter("psrno");
 
String std_cost=request.getParameter("std_cost")==null||request.getParameter("std_cost")==""?"0":request.getParameter("std_cost");
String fixing=request.getParameter("fixing")==null||request.getParameter("fixing")==""?"0":request.getParameter("fixing");
String labourcharge=request.getParameter("labourcharge")==null||request.getParameter("labourcharge")==""?"0":request.getParameter("labourcharge");

 
 
	  Connection conn=null;
	    String sql="";
	    try
	    {
	   	
	    conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
 
			
			String updatesqls1=" update my_main set stdprice="+std_cost+",fixingprice="+fixing+" where psrno="+pdocno+" ";
			
			
			System.out.println("======updatesqls1========"+updatesqls1);
			
		    stmt.executeUpdate(updatesqls1);
			
			 
		      
		 
 stmt.close();
		 
	conn.close();
	 response.getWriter().print(1);
    	
    }
    catch(Exception e)
    {
    	e.printStackTrace();
    	
    	
    	conn.close();
    	 response.getWriter().print(2);
    }
	 	
	 	
	 	
%>



 