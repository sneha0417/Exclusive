<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String status=request.getParameter("status")==null?"":request.getParameter("status");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
ClsConnection objconn=new ClsConnection();
Connection conn=null;
String msg="";
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select statusid from re_mreq  where doc_no="+docno+"";
	ResultSet res=stmt.executeQuery(strsql);
	  while(res.next()){
		  msg=res.getString("statusid");
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