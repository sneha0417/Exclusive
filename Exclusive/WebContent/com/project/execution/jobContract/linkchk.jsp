<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");
Connection conn = null;
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0;

	String strSql2 = "select * from cm_srvcontrpd where tr_no="+docno+" and invtrno!=0";
	System.out.println("---1 inv-"+strSql2);
	ResultSet rs1 = stmt.executeQuery(strSql2);

	if(rs1.next()) {
		val=1;
	}
 
	String strSql3 = "select * from cm_servplan where doc_no="+docno+" and status=5 ";
	System.out.println("---2 servc-"+strSql2);
	ResultSet rs3 = stmt.executeQuery(strSql3);

	if(rs3.next()) {
		val=1;
	}
	
	stmt.close();
	conn.close();

	response.getWriter().print(val);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
%>