<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
   
      String masterdoc_no=request.getParameter("masterdoc_no")==null?"0":request.getParameter("masterdoc_no");

String reftype=request.getParameter("reftype")==null?"0":request.getParameter("reftype");
String refmasterdocno=request.getParameter("refmasterdocno")==null?"0":request.getParameter("refmasterdocno");
 	Connection conn = null;
try{	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0;
	   
 
	 
	String strSql21 = "select rrefno from my_srvm where  FIND_IN_SET('"+masterdoc_no+"', rrefno) and rdtype='PO'; ";
	
	 
	ResultSet rs11 = stmt.executeQuery(strSql21);

	if(rs11.next()) {
		val=1;
		} 
	 
	
	

	if(reftype.equalsIgnoreCase("RFQ"))
	{
	String strSql2 = "select * from my_prfqd where rdocno in("+refmasterdocno+") and clstatus=1";
	
	 
	ResultSet rs1 = stmt.executeQuery(strSql2);

	if(rs1.next()) {
		val=1;
 		} 
	}
	else if(reftype.equalsIgnoreCase("SOR"))
	{
		String strSql2 = "select * from my_sorderd where rdocno in("+refmasterdocno+")  and clstatus=1 ";
		
		  
		ResultSet rs1 = stmt.executeQuery(strSql2);

		if(rs1.next()) {
			val=1;
	  		}
	}
	String strSql = "select rrefno from my_grnm where  FIND_IN_SET('"+masterdoc_no+"', rrefno);";
	
	  
	
	ResultSet rs = stmt.executeQuery(strSql);

	if(rs.next()) {
		val=1;
  		} 

	
	int appr=0;
	
	String strSql1 = "select  * from  my_apprmaster where dtype='PO' and status=3; ";
	
	 
	ResultSet rs1 = stmt.executeQuery(strSql1);

	if(rs1.next()) {
		appr=1;
 		} 
 
	if(appr==1)
	{
		String strSql11 = "select  * from my_ordm where status=3 and doc_no='"+masterdoc_no+"' ";
		 
		 
		ResultSet rs111 = stmt.executeQuery(strSql11);

		if(rs111.next()) {
			val=1;
	 		} 
		
		
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