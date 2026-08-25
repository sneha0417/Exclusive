<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 
<%
String wdate=request.getParameter("wdate")==null || request.getParameter("wdate")==""?"0":request.getParameter("wdate");
String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno"); 
String remarks=request.getParameter("remarks")==null || request.getParameter("remarks")==""?"0":request.getParameter("remarks"); 
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
	
	if(!(wdate.equalsIgnoreCase("undefined"))&&!(wdate.equalsIgnoreCase(""))&&!(wdate.equalsIgnoreCase("0"))){
		sqlwdate=objcommon.changeStringtoSqlDate(wdate);   
    }
	String strsql="update rl_propertymaster set terms_warranty='"+sqlwdate+"' where doc_no='"+docno+"'";	         
	//,lstdate=now(),lstuser="+session.getAttribute("USERID").toString()+"    
			
	 String strsql1="insert into gl_bpmt( date, userid, formid, warrantydate, remarks) values(now(),'"+userid+"','"+docno+"','"+sqlwdate+"','"+remarks+"')";	
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