<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String existingbrv=request.getParameter("existingbrv")==null?"":request.getParameter("existingbrv");
String newbrv=request.getParameter("newbrv")==null?"":request.getParameter("newbrv");
String contractdocno=request.getParameter("contractdocno")==null?"":request.getParameter("contractdocno");
String branchid=session.getAttribute("BRANCHID")==null?"":session.getAttribute("BRANCHID").toString();
String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
ClsConnection objconn=new ClsConnection();
Connection conn=null;
int errorstatus=0;
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	String strinsertoldentry="insert into rl_contractpdcupdate(contractdocno,oldbrv,newbrv,brhid,userid,status)values("+contractdocno+","+existingbrv+","+newbrv+","+branchid+","+userid+",3)";
	int insertoldentry=stmt.executeUpdate(strinsertoldentry);
	if(insertoldentry<=0){
		errorstatus=1;
	}
	String strupdate="update rl_tncpayment set refno="+newbrv+" where rdocno="+contractdocno+" and refno="+existingbrv;
	int update=stmt.executeUpdate(strupdate);
	if(update<=0){
		errorstatus=1;
	}
	PreparedStatement stmtlog=conn.prepareStatement("insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
	stmtlog.setInt(1,Integer.parseInt(contractdocno));
	stmtlog.setInt(2,Integer.parseInt(branchid));
	stmtlog.setString(3,"BPCU");
	stmtlog.setInt(4, Integer.parseInt(userid));
	stmtlog.setInt(5, 0);
	stmtlog.setInt(6, 0);
	stmtlog.setString(7, "A");
	int log=stmtlog.executeUpdate();
	if(log<=0){
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