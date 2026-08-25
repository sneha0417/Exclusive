<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
ClsConnection objconn=new ClsConnection();
Connection conn=null;
int errorstatus=0;
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	String strupdatejv="update rl_tncpayment pyt left join my_jvtran jv on jv.tr_no=pyt.ownerpytsettletrno set jv.status=3 where pyt.rdocno="+docno;
	int updatejv=stmt.executeUpdate(strupdatejv);
	if(updatejv<=0){
		errorstatus=1;
	}
	String strupdate="update rl_tncm set ownerpytsettlement=1 where doc_no="+docno;
	int update=stmt.executeUpdate(strupdate);
	if(update<=0){
		errorstatus=1;
	}
	if(errorstatus==0){
		conn.commit();
	}
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>