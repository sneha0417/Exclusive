<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
    String masterdoc_no=request.getParameter("masterdoc_no")==null?"0":request.getParameter("masterdoc_no");
 	Connection conn = null;  
try{
	ClsConnection ClsConnection=new ClsConnection();  
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0;
	 
	String strSql21 = "select * from rl_tncm where  pstatus>0 and doc_no='"+masterdoc_no+"' ";
	//System.out.println("==strSql21=="+strSql21);
	ResultSet rs11 = stmt.executeQuery(strSql21);
	if(rs11.next()) {
		val=1;
	 } 
		 
	String strSql2111 = "select * from rl_tncm where  clstatus=1 and doc_no='"+masterdoc_no+"' ";
	//System.out.println("==strSql2111=="+strSql2111);
	ResultSet rs11111 = stmt.executeQuery(strSql2111);
	if(rs11111.next()) {
		val=1;
	 } 
	 
	String strSql2 = "select * from rl_tncpayment where refno>0 and rdocno='"+masterdoc_no+"' ";
	//System.out.println("==strSql2111=="+strSql2111);
	ResultSet rs1 = stmt.executeQuery(strSql2);
	if(rs1.next()) {
		val=1;
 	 } 
	
	int i=0;
	String strSql211 = "select * from rl_tncm m inner join rl_propertymaster p on p.cnt_no=m.doc_no where m.doc_no='"+masterdoc_no+"' ";
	ResultSet rs111 = stmt.executeQuery(strSql211);
	if(rs111.next()) {
		 i=1;
 	 } 
	 if(i==0)
	 {
		 val=1;
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
finally{
	conn.close();
}
	%>