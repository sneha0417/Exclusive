<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String status=request.getParameter("status")==null?"":request.getParameter("status");
String confirm=request.getParameter("confirm")==null?"":request.getParameter("confirm");
String vocno=request.getParameter("vocno")==null?"":request.getParameter("vocno");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
ClsConnection objconn=new ClsConnection();
Connection conn=null;
String msg="",desc="";
try{
	conn=objconn.getMyConnection();
	String userid=session.getAttribute("USERID").toString();
	Statement stmt=conn.createStatement();
	int insertval=0,conf=0;
	if(!confirm.equalsIgnoreCase("")){
	conf=Integer.parseInt(confirm);
	}
	if(conf>0){
		String strsql1="update re_mreq set confirm=1 where voc_no='"+vocno+"' and branch='"+brhid+"'";  
		 insertval=stmt.executeUpdate(strsql1);
		 desc="Document Confirmed";
	}else{
	 String strsql="update re_mreq set statusid="+status+" where voc_no='"+vocno+"' and branch='"+brhid+"'";      
	 insertval=stmt.executeUpdate(strsql);
	 desc="Status updated";
	}        
	if(insertval>0){
			String sqllog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,description) values("+vocno+",'"+brhid+"','MMT',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','"+desc+"')";               
			System.out.println(sqllog);                       
			int val1=stmt.executeUpdate(sqllog); 
		msg="1";
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