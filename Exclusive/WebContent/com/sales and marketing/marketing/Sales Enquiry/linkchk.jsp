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
	
	
	String strSql1="select refdocno, rdocno  from my_benqps where rdocno='"+masterdoc_no+"' ";
	
	// System.out.println("---strSql--"+strSql1);
	ResultSet rs = stmt.executeQuery(strSql1);

	if(rs.next()) {
		val=1;
 		} 
	
	String strSql = "select rrefno from my_qotm where  FIND_IN_SET('"+masterdoc_no+"', rrefno);";
	
	// System.out.println("---strSql--"+strSql);
	ResultSet rs1= stmt.executeQuery(strSql);

	if(rs1.next()) {
		val=1;
  		} 
	String strSql2 = "select rrefno from my_prfqm where  FIND_IN_SET('"+masterdoc_no+"', rrefno) and rdtype='CEQ' ;";
	
	// System.out.println("---strSql--"+strSql2);
	ResultSet rs2= stmt.executeQuery(strSql2);

	if(rs2.next()) {
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