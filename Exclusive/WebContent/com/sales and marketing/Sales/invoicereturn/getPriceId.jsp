<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%  	Connection conn = null;	try
{
	String dtype=session.getAttribute("Code").toString();
  String clientid=request.getParameter("clientid").trim().toString();
	String brch=session.getAttribute("BRANCHID").toString();
	String strSql ="";	ClsConnection ClsConnection=new ClsConnection();
 	  conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	
	
	if(!(clientid.equals("")||clientid.equals("0"))){
		strSql="select pg.pricegroup,pg.code,pg.doc_no from my_acbook ac inner join my_pricegroup pg on(ac.pricegroup=pg.doc_no and ac.dtype='CRM') where ac.doc_no="+clientid+" and pg.status=3";
	}
	else{
		strSql = "select pg.pricegroup,pg.code,pg.doc_no from my_pricegroup pg where pg.status=3";
	}
	
	System.out.println("===strSql===="+strSql);
	
	ResultSet rs = stmt.executeQuery(strSql);
	String pgid="";
	String pgcode="";
	String pgname="";
	while(rs.next()) {
		pgid+=rs.getInt("pg.doc_no")+",";
		pgcode+=rs.getString("pg.code")+",";
		pgname+=rs.getString("pg.pricegroup")+",";
  		} 
	pgid=pgid.substring(0, pgid.length()-1);
	pgcode=pgcode.substring(0, pgcode.length()-1);
	pgname=pgname.substring(0, pgname.length()-1);
	//System.out.println(curid+"####"+curcode+"####"+currate+"####"+multi);
	response.getWriter().write(pgid+"####"+pgcode+"####"+pgname);
	
	
	stmt.close();
	conn.close();
}
catch(Exception e)
{
	conn.close();
}
  %>
  
