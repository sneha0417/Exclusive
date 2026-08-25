<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
   
      String masterdoc_no=request.getParameter("masterdoc_no")==null?"0":request.getParameter("masterdoc_no");
 	Connection conn = null;
try{	 ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0;
	String strSql = "select rrefno from my_invm where  FIND_IN_SET('"+masterdoc_no+"', rrefno);";
	
	System.out.println("---strSql--"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);

	if(rs.next()) {
		val=1;
  		} 
	
	int tr_nos=0;
	String aa = "select tr_no from my_delrm where  doc_no='"+masterdoc_no+"'";
	
	 // System.out.println("---aa-2-"+aa);
	ResultSet bb = stmt.executeQuery(aa);

	if(bb.next()) {
		tr_nos=bb.getInt("tr_no");
		} 
	
	
	String cc2 = "select stockid from my_prddin where (out_qty>0 or rsv_qty>0 or del_qty>0) and tr_no='"+tr_nos+"' ";
	
//	System.out.println("---strSql-3-"+cc2);
		ResultSet cc3 = stmt.executeQuery(cc2);

		if(cc3.next()) {
			val=1;
		 System.out.println("-----val----"+val);
			
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