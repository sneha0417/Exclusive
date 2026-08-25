 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	

Connection conn =null;
 try
{
			ClsConnection ClsConnection=new ClsConnection();
 	  conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
 
	String strSql = "select doc_no, code, dtype, status from my_corcode where status=3 and Dtype='BLC' ";
	
	System.out.println("---strSql---"+strSql);
	
	ResultSet rs = stmt.executeQuery(strSql);
	String doc_no="";
	String type="";
 
	while(rs.next()) {
		doc_no+=rs.getInt("doc_no")+",";
		type+=rs.getString("code")+",";
	 
  		} 
System.out.println("=doc_no="+doc_no);
System.out.println("=type="+type);
	response.getWriter().write(doc_no+"####"+type);
	
	
	stmt.close();
	conn.close();
}
catch(Exception e)
{
	e.printStackTrace();
	conn.close();
}
  %>
  
 