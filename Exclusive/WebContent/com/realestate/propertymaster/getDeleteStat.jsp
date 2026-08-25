<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
    String masterdoc=request.getParameter("masterdoc")==null?"0":request.getParameter("masterdoc");
    Connection conn = null;     
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();  
	Statement stmt = conn.createStatement ();  
	int val=0,doc=0;
	String strSql = "select coalesce(m.doc_no,0) docno from rl_propertymaster pr left join rl_tncm m on m.prtype=pr.doc_no where pr.doc_no='"+masterdoc+"'";
	System.out.println("strSql---->>>"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);         
	while(rs.next()) {         
		doc=rs.getInt("docno");
  		}           
	if(doc>0){
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