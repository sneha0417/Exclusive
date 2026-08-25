<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String optdatechange=request.getParameter("optdatechange")==null?"":request.getParameter("optdatechange");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String datechangeremarks=request.getParameter("datechangeremarks")==null?"":request.getParameter("datechangeremarks");
String vocno=request.getParameter("vocno")==null?"":request.getParameter("vocno");
int errorstatus=0;
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	java.sql.Date sqldate=null;
	if(date!=null && !date.equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(date);
	}
	int propdocno=0;
	String strgetdata="select period_to todate,prtype from rl_tncm where doc_no="+docno;
	ResultSet rsgetdata=stmt.executeQuery(strgetdata);
	java.sql.Date sqlexistdate=null;
	while(rsgetdata.next()){
		sqlexistdate=rsgetdata.getDate("todate");
		propdocno=rsgetdata.getInt("prtype");
	}
	String branch=session.getAttribute("BRANCHID")==null?"":session.getAttribute("BRANCHID").toString();
	String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
	String username=session.getAttribute("USERNAME")==null?"":session.getAttribute("USERNAME").toString();
	String systemnote="";
	if(optdatechange.equalsIgnoreCase("1")){
		systemnote="Date Change of TNC "+vocno+" for Preclosure from "+objcommon.changeSqltoString(sqlexistdate)+" to "+date+" by "+username;
	}
	else if(optdatechange.equalsIgnoreCase("2")){
		systemnote="Date Change of TNC "+vocno+" for Extension from "+objcommon.changeSqltoString(sqlexistdate)+" to "+date+" by "+username;
	}
	
	String strupdatemaster="update rl_tncm set renewalremarks='"+datechangeremarks+"',lastupdateddate='"+sqlexistdate+"',datechangetype="+optdatechange+",period_to='"+sqldate+"' where doc_no="+docno;
	int updatemaster=stmt.executeUpdate(strupdatemaster);
	if(updatemaster<=0){
		errorstatus=1;
	}
	String strupdateprop="update rl_propertymaster set cnt_date='"+sqldate+"' where doc_no="+propdocno;
	int updateprop=stmt.executeUpdate(strupdateprop);
	if(updateprop<=0){
		errorstatus=1;
	}
	String strloginsert="insert into rl_tncmgmtlog(docno, brhid, userid, logdate, process, remarks, systemremarks)values("+docno+","+branch+","+userid+",now(),1,'"+datechangeremarks+"','"+systemnote+"')";
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