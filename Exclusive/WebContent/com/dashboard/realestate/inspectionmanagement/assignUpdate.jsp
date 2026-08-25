<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String status=request.getParameter("status")==null || request.getParameter("status")==""?"":request.getParameter("status");
String remarks=request.getParameter("remarks")==null || request.getParameter("remarks")==""?"":request.getParameter("remarks");
String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"":request.getParameter("docno");
String tdocno=request.getParameter("tdocno")==null || request.getParameter("tdocno")==""?"":request.getParameter("tdocno");
ClsConnection objconn=new ClsConnection();
Connection conn=null;
String msg="";



try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	String userid=session.getAttribute("USERID").toString();
	Statement stmt=conn.createStatement();
	Statement stmt1=conn.createStatement();
	int insertval=0,updateval=0;
	 
	String strsql="update rl_propertymaster set insassignuser="+status+" where doc_no="+docno+""; 
	System.out.println(strsql);
	updateval=stmt.executeUpdate(strsql);
	
	
	 
	if(updateval>0){ 
		msg="1";
		conn.commit();
	} 
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(msg);
%>