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

String docno=request.getParameter("docno").toString();

String formcode=request.getParameter("dtype").toString();

String brhid=request.getParameter("brhid").toString();

 
	  Connection conn=null;
	    String sql="";
	    int resultSet=0;
	    try
	    {
	   	
	    conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		//  System.out.println("----chk------"+chk);
		  
 	 

				String termsql="delete from my_trterms where rdocno='"+docno+"' and brhid='"+brhid+"' and dtype='"+formcode+"'";
				
		System.out.println("===termsql===="+termsql);
				Statement stnmt1=conn.createStatement(); 
			  resultSet=	stnmt1.executeUpdate (termsql);
		 
		  
 stmt.close();
		 
	conn.close();
	 response.getWriter().print(resultSet);
    	
    }
    catch(Exception e)
    {
    	e.printStackTrace();
    	
    	
    	conn.close();
    	 response.getWriter().print(resultSet);
    }
	 	
	 	
	 	
%>



 