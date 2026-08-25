<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String comment=request.getParameter("comment")==null?"":request.getParameter("comment");
String vocno=request.getParameter("vocno")==null?"":request.getParameter("vocno");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
ClsConnection objconn=new ClsConnection();
Connection conn=null;     
String msg="";
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	String userid=session.getAttribute("USERID").toString();
	Statement stmt=conn.createStatement();
	String strsql="insert into rl_comments(voc_no,brhid,dtype,userid,msgdate,msg) values('"+vocno+"','"+brhid+"','MAD',"+userid+",now(),'"+comment+"')";
	int insertval=stmt.executeUpdate(strsql);
	   
	if(insertval>0){    
		conn.commit();
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