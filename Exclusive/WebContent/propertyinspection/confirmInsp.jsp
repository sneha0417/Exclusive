<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String propdocno=request.getParameter("propdocno")==null?"":request.getParameter("propdocno");
String tncdocno=request.getParameter("tncdocno")==null?"":request.getParameter("tncdocno");
String inspdocno=request.getParameter("inspdocno")==null?"":request.getParameter("inspdocno");
String insptype=request.getParameter("insptype")==null?"":request.getParameter("insptype");
Connection conn=null;
int errorstatus=0;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	String strupdate="",strupdate2="";
	String strinspduration="";
	if(insptype.equalsIgnoreCase("Inspection")){
		strupdate="update rl_propertymaster set ins_status=4,inspdocno=0,ins_date=(case"+
		" when terms_insptype='Q' then date_add(curdate(),interval 3 month)"+
		" when terms_insptype='HY' then date_add(curdate(),interval 6 month)"+
		" when terms_insptype='M' then date_add(curdate(),interval 1 month) end) where doc_no="+propdocno;
	}
	else if(insptype.equalsIgnoreCase("Hand Over")){
		strupdate="update rl_tncm set handoveruser=0,handover=1 where doc_no="+tncdocno;
		strupdate2="update rl_propertymaster set inspdocno=0 where doc_no="+propdocno;
	}
	else if(insptype.equalsIgnoreCase("Hand Back")){
		strupdate="update rl_tncm set handbackuser=0,handback=1 where doc_no="+tncdocno;
		strupdate2="update rl_propertymaster set inspdocno=0 where doc_no="+propdocno;
	}
	
	System.out.println(strupdate);
	int updateproperty=stmt.executeUpdate(strupdate);
	if(updateproperty<=0){
		errorstatus=1;
	}
	if(!strupdate2.equalsIgnoreCase("")){
		int updateproperty2=stmt.executeUpdate(strupdate2);
		if(updateproperty2<=0){
			errorstatus=1;
		}	
	}
	
	String branchid=session.getAttribute("BRANCHID")==null?"0":session.getAttribute("BRANCHID").toString();
	String userid=session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString();
	
	PreparedStatement stmtlog=conn.prepareStatement("insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
	stmtlog.setInt(1,Integer.parseInt(inspdocno));
	stmtlog.setInt(2,Integer.parseInt(branchid));
	stmtlog.setString(3,"BPI");
	stmtlog.setInt(4, Integer.parseInt(userid));
	stmtlog.setInt(5, 0);
	stmtlog.setInt(6, 0);
	stmtlog.setString(7, "A");
	int loginsert=stmtlog.executeUpdate();
	if(loginsert<=0){
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