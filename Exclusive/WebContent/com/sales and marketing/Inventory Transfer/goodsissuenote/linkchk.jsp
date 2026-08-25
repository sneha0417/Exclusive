<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
   
      String masterdoc_no=request.getParameter("masterdoc_no")==null?"0":request.getParameter("masterdoc_no");
int tr_no=0;
 	Connection conn = null;
try{
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0;
	String strSql = "select rrefno from my_srvm where  FIND_IN_SET('"+masterdoc_no+"', rrefno);";
	
	//System.out.println("---strSql--"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);

	if(rs.next()) {
		val=1;
  		} 
	
	
	String strSql2 = "select tr_no from my_grnm where  doc_no='"+masterdoc_no+"'";
	
	//System.out.println("---strSql-2-"+strSql2);
	ResultSet rs2 = stmt.executeQuery(strSql2);

	if(rs2.next()) {
		tr_no=rs2.getInt("tr_no");
  		} 
	
	String strSql3 = "select stockid from my_prddin where (out_qty>0 or rsv_qty>0 or del_qty>0  or foc_out>0) and tr_no='"+tr_no+"' ";
	
	//System.out.println("---strSql-3-"+strSql3);
	ResultSet rs3 = stmt.executeQuery(strSql3);

	if(rs3.next()) {
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