<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
ClsConnection ClsConnection=new ClsConnection();
Connection conn = ClsConnection.getMyConnection();
try{
String a = request.getParameter("id");

	Statement stmt = conn.createStatement();
	ResultSet rs1 = stmt.executeQuery("select inname from gl_vehin where doc_no="+ a);
	String d1 = "";
	if (rs1.next()) {
		d1 += rs1.getString(1);
		
		System.out.println(d1);
	}
	response.getWriter().write(d1);
	stmt.close();
	conn.close();
	
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
%>