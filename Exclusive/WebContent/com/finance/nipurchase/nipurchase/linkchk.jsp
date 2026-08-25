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
	   
 String dtype="";
	 
 int tr_no=0;
 
	String strSql21 = "select reftype,tr_no from my_srvpurm where doc_no='"+masterdoc_no+"' ";
	
	 
	ResultSet rs11 = stmt.executeQuery(strSql21);

	if(rs11.next()) {
		dtype=rs11.getString("reftype");
		tr_no=rs11.getInt("tr_no");
 		} 
	 
	
 if(dtype.equalsIgnoreCase("NPO"))
 {
	 
	 String strSql11 = "select  * from my_srvpurd where rdocno='"+masterdoc_no+"' and refrow=0 ";
		
	 
		ResultSet rs111 = stmt.executeQuery(strSql11);

		if(rs111.next()) {
			val=1;
	 		}  
	 
 }
 
	 
	String sqlsss="select tr_no from my_jvtran where tr_no="+tr_no+" and prep=1 ";
  	ResultSet rs1111 = stmt.executeQuery(sqlsss);
	if(rs1111.next()) {
		val=1;
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