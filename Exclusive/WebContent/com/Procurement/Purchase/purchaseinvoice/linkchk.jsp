<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
   
      String masterdoc_no=request.getParameter("masterdoc_no")==null?"0":request.getParameter("masterdoc_no");

String reftype=request.getParameter("reftype")==null?"0":request.getParameter("reftype");
String refmasterdocno=request.getParameter("refmasterdocno")==null?"0":request.getParameter("refmasterdocno");

int tr_no=0;
 	Connection conn = null;
try{	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0;
	
	  System.out.println("---reftype---------------- -----"+reftype);
	if(reftype.equalsIgnoreCase("PO"))
	{
	String strSql2 = "select * from my_ordd where rdocno in("+refmasterdocno+") and clstatus=1 ";
	
	 System.out.println("---1-"+strSql2);
	ResultSet rs1 = stmt.executeQuery(strSql2);

	if(rs1.next()) {
		val=1;
 		} 
	}
	
	
	
	String strSql = "select rrefno from my_srrm where  FIND_IN_SET('"+masterdoc_no+"', rrefno);";
	
	// System.out.println("---strSql--"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);

	if(rs.next()) {
		val=1;
  		} 
	
	
	String strSql2 = "select tr_no from my_srrm where  doc_no='"+masterdoc_no+"'";
	
	  System.out.println("---strSql-2-"+strSql2);
	ResultSet rs2 = stmt.executeQuery(strSql2);

	if(rs2.next()) {
		tr_no=rs2.getInt("tr_no");
  		} 
	
	String strSql3 = "select stockid from my_prddout where (qty>0 or rsv_qty>0 or del_qty>0  or foc>0) and tr_no='"+tr_no+"' ";
	
  System.out.println("---strSql-3-"+strSql3);
	ResultSet rs3 = stmt.executeQuery(strSql3);

	if(rs3.next()) {
		val=1;
		//System.out.println("-----val----"+val);
		
  		} 
	
	
	int tr_nos=0;
	String aa = "select tr_no from my_srvm where  doc_no='"+masterdoc_no+"'";
	
	  System.out.println("---aa-2-"+aa);
	ResultSet bb = stmt.executeQuery(aa);

	if(bb.next()) {
		tr_nos=bb.getInt("tr_no");
		} 
	
	String cc = "select stockid from my_prddout where (qty>0 or rsv_qty>0 or del_qty>0  or foc>0) and tr_no='"+tr_nos+"' ";
	
System.out.println("---strSql-3-"+cc);
	ResultSet cc1 = stmt.executeQuery(cc);

	if(cc1.next()) {
		val=1;
		//System.out.println("-----val----"+val);
		
		} 
	String cc2 = "select stockid from my_prddin where (out_qty>0 or rsv_qty>0 or del_qty>0) and tr_no='"+tr_nos+"' ";
	
	System.out.println("---strSql-3-"+cc2);
		ResultSet cc3 = stmt.executeQuery(cc2);

		if(cc3.next()) {
			val=1;
			//System.out.println("-----val----"+val);
			
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