<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String rowno=request.getParameter("rowno")==null || request.getParameter("rowno")==""?"0":request.getParameter("rowno");
ClsConnection objconn=new ClsConnection();          
Connection conn=null;         
int status=0,val=0;  
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strgetmsg="delete from re_mreqmgmt where rowno='"+rowno+"'";    
	System.out.println("strSql===="+strgetmsg);               
	val=stmt.executeUpdate(strgetmsg);       
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(val);  
%>