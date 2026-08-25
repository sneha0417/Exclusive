<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
ClsConnection ClsConnection=new ClsConnection();
 	Connection conn = null;
	String branch=request.getParameter("branch")==null?"0":request.getParameter("branch").toString();
try{
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select  mclose from my_brch where doc_no="+branch;
	System.out.println(strSql);
	ResultSet rs = stmt.executeQuery(strSql);
	java.sql.Date mclosedate=null;
	while(rs.next()){
		mclosedate=rs.getDate("mclose");
	}
	stmt.close();
	conn.close();

	response.getWriter().write(mclosedate+"");
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
	%>