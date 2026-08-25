<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
    String brhid=request.getParameter("brhid")==null?"0":request.getParameter("brhid");
    String vocno=request.getParameter("vocno")==null?"0":request.getParameter("vocno");       
    Connection conn = null;     
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();  
	Statement stmt = conn.createStatement ();  
	int val=0;
	String strSql = "select coalesce(confirm,0) confirm from re_mreq where voc_no='"+vocno+"' and branch='"+brhid+"'";   
	ResultSet rs = stmt.executeQuery(strSql);         
	while(rs.next()) {         
		val=rs.getInt("confirm");    
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