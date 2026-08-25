<%@page import="com.common.ClsCommon"%>    
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
<%@page import="java.io.*" %>
<%@page import="org.apache.struts2.ServletActionContext" %>
<%@page import="com.dashboard.realestate.propinspanalysis.ClsPropInspAnalysisAction"%>               
<%
	Connection conn = null;       
	ClsConnection ClsConnection=new ClsConnection();        
	ClsCommon ClsCommon=new ClsCommon();
	int docno=request.getParameter("docno")==null || request.getParameter("docno")==""?0:Integer.parseInt(request.getParameter("docno").trim());
	String doctype=request.getParameter("doctype")==null || request.getParameter("doctype")==""?"0":request.getParameter("doctype").trim().toString();
	String dtype=request.getParameter("dtype")==null || request.getParameter("dtype")==""?"0":request.getParameter("dtype").trim().toString();
	String userid=request.getParameter("userid")==null || request.getParameter("userid")==""?"0":request.getParameter("userid").trim().toString();
	int val=0;      
	try{   
	 	conn = ClsConnection.getMyConnection();               
	 	ClsPropInspAnalysisAction pamaction=new ClsPropInspAnalysisAction();    
	 	val=pamaction.printAction(docno,doctype,dtype,userid);                 	
	 	System.out.println("IN send mail==");      
	}catch(Exception e){    
	 	e.printStackTrace();	
	 	conn.close();
   }finally{
	   conn.close();
   }
   response.getWriter().print(val);    
%>