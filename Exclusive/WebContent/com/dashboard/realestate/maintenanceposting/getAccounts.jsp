<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String vocno=request.getParameter("vocno")==null || request.getParameter("vocno")==""?"0":request.getParameter("vocno");
String brhid=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid");
ClsConnection objconn=new ClsConnection();          
Connection conn=null;         
int status=0,val=0;  
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strgetmsg="select coalesce(max(statusid),0) mstatus from re_mreq where voc_no='"+vocno+"' and branch='"+brhid+"'";
	System.out.println("strSql===="+strgetmsg);               
	ResultSet rs=stmt.executeQuery(strgetmsg);       
	while(rs.next()){
		status=rs.getInt("mstatus");  
	}
	System.out.println("status===="+status);     
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(status);  
%>