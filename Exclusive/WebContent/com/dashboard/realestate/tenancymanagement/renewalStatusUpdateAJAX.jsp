<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String propdocno=request.getParameter("propdocno")==null?"":request.getParameter("propdocno");
String cmbrenewalstatus=request.getParameter("cmbrenewalstatus")==null?"":request.getParameter("cmbrenewalstatus");
String renewalremarks=request.getParameter("renewalremarks")==null?"":request.getParameter("renewalremarks");
String vocno=request.getParameter("vocno")==null?"":request.getParameter("vocno");
String strrenewalstatus=request.getParameter("strrenewalstatus")==null?"":request.getParameter("strrenewalstatus");
ClsConnection objconn=new ClsConnection();
Connection conn=null;
int errorstatus=0;
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	String strsql="update rl_tncm set renewalremarks='"+renewalremarks+"',renewalstatus="+cmbrenewalstatus+" where doc_no="+docno;
	System.out.println(strsql);
	int updatemaster=stmt.executeUpdate(strsql);
	if(updatemaster<=0){
		errorstatus=1;
	}
	if(cmbrenewalstatus.equalsIgnoreCase("14")){
		String strupdateprop="update rl_propertymaster set pforsale='Sale',pforrent='',pforhc='' where doc_no="+propdocno;
		int updateprop=stmt.executeUpdate(strupdateprop);
		if(updateprop<=0){
			errorstatus=1;
		}
	}
	if(cmbrenewalstatus.equalsIgnoreCase("13")){
		String strupdateprop="update rl_propertymaster set pforsale='',pforrent='',pforhc='',mgprpty=0 where doc_no="+propdocno;
		int updateprop=stmt.executeUpdate(strupdateprop);
		if(updateprop<=0){
			errorstatus=1;
		}
	}
	if(cmbrenewalstatus.equalsIgnoreCase("15")){
		String strupdateprop="update rl_propertymaster set mgprpty=0 where doc_no="+propdocno;
		int updateprop=stmt.executeUpdate(strupdateprop);
		if(updateprop<=0){
			errorstatus=1;
		}
	}
	String branchid=session.getAttribute("BRANCHID")==null?"":session.getAttribute("BRANCHID").toString();
	String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
	String username=session.getAttribute("USERNAME")==null?"":session.getAttribute("USERNAME").toString();
	String systemremarks="Status Updation to "+strrenewalstatus+" of TNC "+vocno+" by "+username;
	String strloginsert="insert into rl_tncmgmtlog(docno, brhid, userid, logdate, process, remarks, systemremarks)values("+docno+","+branchid+","+userid+",now(),1,'"+renewalremarks+"','"+systemremarks+"')";
	System.out.println(strloginsert);
	int loginsert=stmt.executeUpdate(strloginsert);
	if(loginsert<=0){
		errorstatus=1;
	}
	if(errorstatus==0){
		conn.commit();
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>