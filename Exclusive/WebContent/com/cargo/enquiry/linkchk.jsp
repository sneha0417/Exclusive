<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
   
      String masterdoc_no=request.getParameter("masterdoc_no")==null?"0":request.getParameter("masterdoc_no");

 
 	Connection conn = null;
try{	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0;
	   
 
	 
	String strSql21 = "select rrefno from cr_qotm where   rrefno='"+masterdoc_no+"' ";
	
	 
	ResultSet rs11 = stmt.executeQuery(strSql21);

	if(rs11.next()) {
		val=1;
		} 
	 
	
	
 
	

	
	stmt.close();
	conn.close();
	 System.out.println("--in-val--"+val);
	response.getWriter().print(val);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>