<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 
<%
String rowno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno");
String claim=request.getParameter("claim")==null || request.getParameter("claim")==""?"0":request.getParameter("claim");
int val=0;
Connection conn=null;    
try{
	ClsConnection objconn=new ClsConnection();         
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();          
	String strsql="update rl_prinvagent set claimval="+claim+",astatus=1 where rowno='"+rowno+"'";              	                         
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