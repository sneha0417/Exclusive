<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String formtype=request.getParameter("formtype")==null?"":request.getParameter("formtype");
Connection conn=null;
ClsConnection objconn=new ClsConnection();
String formname="";
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select menu_name from my_menu where doc_type='"+formtype+"' and gate='E'";
	ResultSet rs=stmt.executeQuery(strsql);
	if(rs.next()){
		formname=rs.getString("menu_name");
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(formname);
%>