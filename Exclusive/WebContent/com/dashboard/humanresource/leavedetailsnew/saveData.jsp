<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 
<%
String leaveid=request.getParameter("leaveid")==null || request.getParameter("leaveid")==""?"0":request.getParameter("leaveid");
String empdocno=request.getParameter("empdocno")==null || request.getParameter("empdocno")==""?"0":request.getParameter("empdocno");
String days=request.getParameter("days")==null || request.getParameter("days")==""?"0":request.getParameter("days");
int val=0;
Connection conn=null;         
try{
	ClsConnection objconn=new ClsConnection();         
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	String strsql="insert into hr_setcreditleave( date, empid, leaveid, cdtleaves, userid, status) values(now(),'"+empdocno+"','"+leaveid+"','"+days+"','"+session.getAttribute("USERID").toString()+"',3)";                                        	                         
	System.out.println("====="+strsql);                   
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