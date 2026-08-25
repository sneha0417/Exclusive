<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 
<%
String rowno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno");
String invno=request.getParameter("invno")==null || request.getParameter("invno")==""?"0":request.getParameter("invno");
String status=request.getParameter("status")==null || request.getParameter("status")==""?"0":request.getParameter("status");
String confirm=request.getParameter("confirm")==null || request.getParameter("confirm")==""?"0":request.getParameter("confirm");
int val=0;
Connection conn=null;    
try{
	ClsConnection objconn=new ClsConnection();         
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	if(confirm.equalsIgnoreCase("1")){
		String strsql="update rl_prinvagent set confirm=1 where rowno='"+rowno+"'";                 	                         
		System.out.println("====="+strsql);    
		val=stmt.executeUpdate(strsql); 
	}else{
		String strsql="update rl_prinvagent set astatus='"+status+"' where rowno='"+rowno+"'";            	                         
		System.out.println("====="+strsql);
		val=stmt.executeUpdate(strsql);    
	}
	    
	response.getWriter().print(val);     
}
catch(Exception e){  
	e.printStackTrace();
}
finally{
	conn.close();
}
%>