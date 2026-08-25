<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 
<%
String vndacno=request.getParameter("vndacno")==null || request.getParameter("vndacno")==""?"0":request.getParameter("vndacno");
String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno");
String rate=request.getParameter("rate")==null || request.getParameter("rate")==""?"0":request.getParameter("rate");
String margin=request.getParameter("margin")==null || request.getParameter("margin")==""?"0":request.getParameter("margin");
int val=0;
Connection conn=null;    
try{
	ClsConnection objconn=new ClsConnection();         
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();  
	double marg=Double.parseDouble(margin);
	String strsql="update re_mreq set est_amt='"+rate+"',jbprov='"+vndacno+"',margin="+marg+",statusid=2 where doc_no='"+docno+"'";       	                         
	//,lstdate=now(),lstuser="+session.getAttribute("USERID").toString()+"      
	val=stmt.executeUpdate(strsql);     
	response.getWriter().print(val);     
}
catch(Exception e){  
	e.printStackTrace();
}
finally{
	conn.close();
}
%>