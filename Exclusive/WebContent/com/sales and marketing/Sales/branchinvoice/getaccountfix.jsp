 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsEncrypt" %>

<%        
  

 	Connection conn = null;
try{	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int acno=0;
	
	 
	
	String strSql = "SELECT acno FROM MY_ACCOUNT where codeno='SERVICE INCOME'";
	
	System.out.println("--strSql--"+strSql);
	
	ResultSet rs = stmt.executeQuery(strSql);
	int userid=0;
	if(rs.next ()) {
		acno=rs.getInt("acno");
		 
	}
	
	String strSql1 = "select account,description from my_HEAD where doc_no='"+acno+"'";
	
	System.out.println("--strSql1--"+strSql1);
	
	ResultSet rs1 = stmt.executeQuery(strSql1);
	String  account="0";
	String  description="0";
	
	int catid=0;
	
	if(rs1.next ()) {
		account=rs1.getString("account");
		description=rs1.getString("description");
	}
	
	
	
	stmt.close();
	conn.close();

	response.getWriter().print(acno+"::"+account+"::"+description);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>