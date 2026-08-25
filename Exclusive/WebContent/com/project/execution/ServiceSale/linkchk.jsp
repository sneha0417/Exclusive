<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
   
      String masterdoc_no=request.getParameter("masterdoc_no")==null?"0":request.getParameter("masterdoc_no");



int tr_no=0;
 	Connection conn = null;
try{	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0;
	
 
	String strSql2 = "select * from my_srvsaleretm where rrefno='"+masterdoc_no+"' ";
	
	// System.out.println("---1-"+strSql2);
	ResultSet rs1 = stmt.executeQuery(strSql2);

	if(rs1.next()) {
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