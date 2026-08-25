<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
Connection conn = null;
try{

String subaccountgroup=request.getParameter("subaccountgroup");
 	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select p.costgroup acgroup ,p.costType , h.doc_no, h.costType  from  my_costunit as p left join my_ccentre as h on h.costType=p.costType where h.doc_no= '"+subaccountgroup+"'";
	ResultSet rs = stmt.executeQuery(strSql);
	//System.out.println(strSql);
	String acgroup="";
	//String id="";
	while(rs.next()) {
		acgroup=rs.getString("acgroup");

		
		
				
  		} 
	response.getWriter().write(acgroup);
	stmt.close();
	conn.close();
	}
	catch(Exception e){

		e.printStackTrace();
		conn.close();

	}
  
  %>
  
