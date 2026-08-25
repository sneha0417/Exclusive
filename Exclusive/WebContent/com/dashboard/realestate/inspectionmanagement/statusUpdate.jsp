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
	String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
	Statement stmt=conn.createStatement();
	Statement stmt1=conn.createStatement();
	int insertval=0,updateval=0;
	 
	String strsql="update rl_propertymaster set ins_status="+status+" where doc_no="+docno+""; 
	updateval=stmt.executeUpdate(strsql);
	
	String strsql1="insert into rl_inspection(pdocno,tdocno,status,remarks,userId,created_date)values('"+docno+"','"+tdocno+"','"+status+"','"+remarks+"','"+userid+"',now()) ";
 
	System.out.println("insert Querty=" + strsql1);
	insertval=stmt1.executeUpdate(strsql1);
	 
	if(updateval>0 && insertval>0){ 
		msg="1";
		conn.commit();
	} 
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(msg);
%>