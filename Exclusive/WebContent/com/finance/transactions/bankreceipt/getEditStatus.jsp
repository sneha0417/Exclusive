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
	 
	String strSql21 = "select * from rl_tncpayment where refno='"+masterdoc_no+"' and payment ='bank'";     
	//System.out.println("==strSql21=="+strSql21);
	ResultSet rs11 = stmt.executeQuery(strSql21);
	if(rs11.next()) {
		val=1;
	 } 
	val=0;
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