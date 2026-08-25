<%@page import="com.common.ClsCommon"%>    
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
<%@page import="java.io.*" %>
<%@page import="org.apache.struts2.ServletActionContext" %>
<%@page import="com.dashboard.realestate.propertyaccountmanagement.ClsPropertyAccountManagementAction"%>               
<%
	Connection conn = null;       
	ClsConnection ClsConnection=new ClsConnection();        
	ClsCommon ClsCommon=new ClsCommon();
	String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").trim().toString();
	String acno=request.getParameter("acno")==null || request.getParameter("acno")==""?"0":request.getParameter("acno").trim().toString();
	String fdate=request.getParameter("fdate")==null || request.getParameter("fdate")==""?"0":request.getParameter("fdate").trim().toString();
	String tdate=request.getParameter("tdate")==null || request.getParameter("tdate")==""?"0":request.getParameter("tdate").trim().toString();   
	int val=0;
	try{   
	 	conn = ClsConnection.getMyConnection();               
	 	ClsPropertyAccountManagementAction pamaction=new ClsPropertyAccountManagementAction();
	 	pamaction.emailAction(docno,acno,fdate,tdate);   	
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