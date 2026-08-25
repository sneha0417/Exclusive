  <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsEncrypt" %>

<%        
 
	 String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
 
 

 	Connection conn = null;
try{	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0;
	int catid=0;
	String pricegroup="";
 
	
 
		Statement stmt1 = conn.createStatement ();
	String clsql= ("select a.catid,cl.cat_name,cl.pricegroup  "
			+ "  from my_acbook a left join my_clcatm cl on cl.doc_no=a.catid where  a.dtype='CRM'  and a.cldocno='"+cldocno+"' ");
	
	System.out.println("===clsql====="+clsql);
	
	ResultSet rs1 = stmt1.executeQuery(clsql);
	
	if(rs1.next())
	{
		pricegroup=rs1.getString("pricegroup");
		catid=rs1.getInt("catid");
	}
	
 
	
	stmt.close();
	conn.close();

	response.getWriter().print(catid+"##"+pricegroup+"##");
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>