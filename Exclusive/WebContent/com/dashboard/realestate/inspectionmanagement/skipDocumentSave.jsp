<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.*"%>
 
<%

String pdocno=request.getParameter("pdocno")==null || request.getParameter("pdocno")==""?"0":request.getParameter("pdocno");
String tdocno=request.getParameter("tdocno")==null || request.getParameter("tdocno")==""?"0":request.getParameter("tdocno");
String insdate=request.getParameter("insdate")==null || request.getParameter("insdate")==""?"0":request.getParameter("insdate");
String instype=request.getParameter("instype")==null?"":request.getParameter("instype");    

ClsCommon ClsCommon = new ClsCommon();
ClsConnection objconn=new ClsConnection();
Connection conn=null;
int val=0;
java.sql.Date sqlinsdate=null;
int monthadd=0;   
try{
	
	conn=objconn.getMyConnection();
	String userid=session.getAttribute("USERID").toString();
	String brhid=session.getAttribute("BRANCHID").toString();
	Statement stmt=conn.createStatement();
	if(!(insdate.equalsIgnoreCase("undefined"))&&!(insdate.equalsIgnoreCase(""))&&!(insdate.equalsIgnoreCase("0"))){
		sqlinsdate=ClsCommon.changeStringtoSqlDate(insdate);
	}
	if(instype.equalsIgnoreCase("M")){
		monthadd=1;
	}else if(instype.equalsIgnoreCase("Q")){
		monthadd=3;
	}else if(instype.equalsIgnoreCase("HY")){
		monthadd=6;   
	}else{
		monthadd=0;
	}   
	String strsql="insert into rl_propinspm (propdocno, tncdocno, inspdate, brhid, userid, status, insptype, insdate, skipped) values('"+pdocno+"','"+tdocno+"',now(),'"+brhid+"','"+userid+"',3,'Inspection','"+sqlinsdate+"',1)";
	System.out.println("insert sql=" + strsql);
	val=stmt.executeUpdate(strsql);     
	if(val>0){
		String strsql1="update rl_propertymaster set ins_date=DATE_ADD('"+sqlinsdate+"',INTERVAL "+monthadd+" MONTH)  where doc_no="+pdocno+""; 
		System.out.println("strsql1=" + strsql1);      
	    val=stmt.executeUpdate(strsql1);  
	}
	System.out.println("val=" + val);
	response.getWriter().print(val);      
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}     
%>