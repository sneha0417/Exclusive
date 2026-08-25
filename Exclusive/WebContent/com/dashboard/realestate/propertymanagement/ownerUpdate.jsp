<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 
<%
String ownerid=request.getParameter("ownerid")==null || request.getParameter("ownerid")==""?"0":request.getParameter("ownerid");
String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno"); 
String remarks=request.getParameter("remarks")==null || request.getParameter("remarks")==""?"":request.getParameter("remarks"); 

int val=0,val1=0;
Connection conn=null;    
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();      
	Statement stmt1=conn.createStatement(); 
	String userid=session.getAttribute("USERID").toString();
	
	String strsql="update rl_propertymaster set owid='"+ownerid+"' where doc_no='"+docno+"'";	         
	//,lstdate=now(),lstuser="+session.getAttribute("USERID").toString()+"   
	val=stmt.executeUpdate(strsql);    
	

	String strsql1="insert into gl_bpmt( date, userid, formid, ownerid, remarks) values(now(),'"+userid+"','"+docno+"','"+ownerid+"','"+remarks+"')";	
	val1=stmt1.executeUpdate(strsql1);    
	
	response.getWriter().print(val);     
}
catch(Exception e){  
	e.printStackTrace();
}
finally{
	conn.close();
}
%>