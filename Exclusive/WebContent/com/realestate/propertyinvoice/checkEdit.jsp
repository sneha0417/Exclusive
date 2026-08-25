<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%
String docno=request.getParameter("docno")==null || request.getParameter("docno").equalsIgnoreCase("")?"":request.getParameter("docno");
Connection conn=null;
int errorstatus=0;
try{
	if(docno.equalsIgnoreCase("")){
		errorstatus=1;
	} else{
		ClsConnection objconn=new ClsConnection();
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		String strgetmanual="select manual from rl_prinvm where doc_no='"+docno+"'";
		ResultSet rsmanual=stmt.executeQuery(strgetmanual);
		int manual=0;
		while(rsmanual.next()){
			manual=rsmanual.getInt("manual");
		}
		String strgetconfig="select method from gl_config where field_nme='propertyInvoiceEdit'";
		ResultSet rsconfig=stmt.executeQuery(strgetconfig);
		int editconfig=0;
		while(rsconfig.next()){
			editconfig=rsconfig.getInt("method");
		}
		
		String strget="select coalesce(jvtrno,0) jvtrno from rl_prinvagent where rdocno='"+docno+"'";  
		ResultSet rs=stmt.executeQuery(strget);
		int jvcreated=0;
		while(rs.next()){
			jvcreated=rs.getInt("jvtrno");
		}
		
		if(manual!=1 && editconfig==0){
			errorstatus=1;
		}
		
		if(jvcreated!=0){
			errorstatus=1;
		}
if(editconfig==1){
			errorstatus=0;
		}
		
	}
	response.getWriter().print(errorstatus+""); 
	if(!docno.equalsIgnoreCase("")){  
 		conn.close();  
	}
}
catch(Exception e){
	e.printStackTrace();
}
%>