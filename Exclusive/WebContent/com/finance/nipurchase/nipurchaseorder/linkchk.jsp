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
	   
 
	 
	String strSql21 = "select * from my_srvpurm where refno='"+masterdoc_no+"' ";
	
	 
	ResultSet rs11 = stmt.executeQuery(strSql21);

	if(rs11.next()) {
		val=1;
 		} 
	 
	
 
 
	
	int appr=0;
	
	String strSql1 = "select  * from my_apprmaster where dtype='NPO' and status=3 ";
	
 
	ResultSet rs1 = stmt.executeQuery(strSql1);

	if(rs1.next()) {
		appr=1;
 		} 
	
	if(appr==1)
	{
		String strSql11 = "select  * from my_srvlpom where status=3 and doc_no='"+masterdoc_no+"' ";
		
		 
		ResultSet rs111 = stmt.executeQuery(strSql11);

		if(rs111.next()) {
			val=1;
	 		} 
		
		
	}
	
	
	
	
	
	stmt.close();
	conn.close();
	 System.out.println("---val--"+val);
	response.getWriter().print(val);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>