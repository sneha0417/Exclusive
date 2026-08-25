<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*" %>

<%
Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();
int status=0;
String docno=request.getParameter("docno").toString();

try{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	String sql="select * from av_fuelpriced where invoiced=1 and rdocno="+docno+" ";
	ResultSet rs=stmt.executeQuery(sql);
	if(rs.next()){
		status=1;
	}
}
catch(Exception e){
	e.printStackTrace();
	response.getWriter().print(0);
}
finally{
	conn.close();
}
response.getWriter().print(status);
%>