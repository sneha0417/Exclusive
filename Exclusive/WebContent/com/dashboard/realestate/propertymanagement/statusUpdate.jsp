<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 
<%
String status=request.getParameter("status")==null || request.getParameter("status")==""?"":request.getParameter("status");
String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno"); 
String remarks=request.getParameter("remarks")==null || request.getParameter("remarks")==""?"":request.getParameter("remarks"); 

String mng=request.getParameter("mng")==null || request.getParameter("mng")==""?"":request.getParameter("mng"); 

int val=0,val1=0;
Connection conn=null;    
java.sql.Date sqlwdate = null;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement(); 
	Statement stmt1=conn.createStatement(); 
	String userid=session.getAttribute("USERID").toString();
	 
	String str="";
			
	/* if(mng !="")
	{
		str+=" , mgprpty="+mng;
	} */
	
	String strsql="update rl_propertymaster set active='"+status+"' , mgprpty="+mng+ " where doc_no='"+docno+"'";	     
			
	String strsql1="insert into gl_bpmt( date, userid, formid, status, remarks) values(now(),'"+userid+"','"+docno+"','"+status+"','"+remarks+"')";	
	val1=stmt1.executeUpdate(strsql1);    
	
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