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
	
	if(reftype.equalsIgnoreCase("SOR"))
	{
		String strSql2 = "select * from my_sorderd where rdocno in("+refmasterdocno+")  and clstatus=1 ";
		
		 System.out.println("-asd-asdasd-1-"+strSql2);
		ResultSet rs1 = stmt.executeQuery(strSql2);

		if(rs1.next()) {
			val=1;
	  		}
	}
	
	
	String strSql = "select rrefno from my_invr where  FIND_IN_SET('"+masterdoc_no+"', rrefno);";
	
	System.out.println("---strSql--"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);

	if(rs.next()) {
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