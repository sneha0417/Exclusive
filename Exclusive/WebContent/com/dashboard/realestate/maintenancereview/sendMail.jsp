<%@page import="com.common.ClsCommon"%>    
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
<%@page import="java.io.*" %>
<%@page import="org.apache.struts2.ServletActionContext" %>
<%@page import="com.dashboard.realestate.maintenancereview.ClsMaintenanceReviewAction"%>               
<%
	Connection conn = null;       
	ClsConnection ClsConnection=new ClsConnection();        
	ClsCommon ClsCommon=new ClsCommon();
	String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").trim().toString();
	String frmld=request.getParameter("frmld")==null || request.getParameter("frmld")==""?"0":request.getParameter("frmld").trim().toString();
	String from=request.getParameter("from")==null || request.getParameter("from")==""?"0":request.getParameter("from").trim().toString();
	String to=request.getParameter("to")==null || request.getParameter("to")==""?"0":request.getParameter("to").trim().toString();   
	int val=0;
	try{   
	 	conn = ClsConnection.getMyConnection();               
	 	ClsMaintenanceReviewAction pamaction=new ClsMaintenanceReviewAction();
	 	pamaction.emailAction(docno,frmld,from,to);   	
	 	System.out.println("IN send mail==");   
	 	val=1;
	}catch(Exception e){    
	 	e.printStackTrace();	
	 	conn.close();
   }finally{
	   conn.close();
   }
   response.getWriter().print(val);    
%>