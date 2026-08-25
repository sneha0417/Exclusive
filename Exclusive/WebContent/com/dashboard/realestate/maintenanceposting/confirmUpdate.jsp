<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String confirm=request.getParameter("confirm")==null?"":request.getParameter("confirm");
String vocno=request.getParameter("vocno")==null?"":request.getParameter("vocno");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String jvtrno=request.getParameter("jvtrno")==null?"":request.getParameter("jvtrno");          
String block=request.getParameter("block")==null || request.getParameter("block")==""?"0":request.getParameter("block");
ClsConnection objconn=new ClsConnection();
Connection conn=null;
String msg="",desc="";
int val=0;   
try{
	conn=objconn.getMyConnection();
	String userid=session.getAttribute("USERID").toString();   
	Statement stmt=conn.createStatement();
	int insertval=0,conf=0;
	if(block.equalsIgnoreCase("1")){     
		 String strsql1="update my_jvtran j left join re_mreq r on r.jvtrno=j.tr_no set j.status=7,r.jvtrno=0,r.blockamt=0,r.jv_vocno=0 where tr_no='"+jvtrno+"'";                          
		 insertval=stmt.executeUpdate(strsql1);  
		 desc="Amount released";
	}else{
		 String strsql1="update re_mreq set mpconfirm=1 where voc_no='"+vocno+"' and branch='"+brhid+"'";  
		 insertval=stmt.executeUpdate(strsql1);
		 desc="Document confirmed";    
	}
	if(insertval>0){
			String sql2="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,description) values("+vocno+",'"+brhid+"','MAPT',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','"+desc+"')";   
			System.out.println(sql2);                 
			val=stmt.executeUpdate(sql2);    
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