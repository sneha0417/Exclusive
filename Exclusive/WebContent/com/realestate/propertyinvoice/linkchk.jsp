<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
 String masterdoc_no=request.getParameter("masterdoc_no")==null || request.getParameter("masterdoc_no")==""?"0":request.getParameter("masterdoc_no");
 int tr_no=0;
 Connection conn = null;
 try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0;
 
	String strSql1 = "select * from my_srvsaleretm where rrefno='"+masterdoc_no+"' ";
	// System.out.println("---1-"+strSql1);
	ResultSet rs1 = stmt.executeQuery(strSql1);  
	if(rs1.next()) {
		val=1;
 	} 
	
	String strSql2 = "select * from rl_tncm where pstatus='"+masterdoc_no+"' ";
	// System.out.println("---1-"+strSql2);
	ResultSet rs2 = stmt.executeQuery(strSql2);
	if(rs2.next()) {
		val=1;
 	}
	
	String strSql3 = "select * from rl_tncmanagefee where privdocno='"+masterdoc_no+"' ";
	// System.out.println("---1-"+strSql3);
	ResultSet rs3 = stmt.executeQuery(strSql3);
	if(rs3.next()) {
		val=1;
 	}
	
	String strSql4 = "select * from rl_tncpayment  where privdocno='"+masterdoc_no+"' ";
	// System.out.println("---1-"+strSql4);
	ResultSet rs4 = stmt.executeQuery(strSql4);
	if(rs4.next()) {  
		val=1;
 	}
	
	String strSql5 = "select * from re_mreqmgmt where invdoc='"+masterdoc_no+"' ";  
	// System.out.println("---1-"+strSql5);
	ResultSet rs5 = stmt.executeQuery(strSql5);
	if(rs5.next()) {
		val=1;
 	}  
int editconfig=0;
	String strgetconfig="select method from gl_config where field_nme='propertyInvoiceEdit'";
		ResultSet rsconfig=stmt.executeQuery(strgetconfig);
		//int editconfig=0;
		while(rsconfig.next()){
			editconfig=rsconfig.getInt("method");
		}
if(editconfig==1){
			val=0;
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