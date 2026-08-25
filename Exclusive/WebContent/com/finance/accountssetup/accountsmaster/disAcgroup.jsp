<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	

Connection conn = null;
try{
	
	ClsConnection connDAO= new ClsConnection();
String subaccountgroup=request.getParameter("subaccountgroup");
 	 conn = connDAO.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select p.head acgroup ,p.fi_id , h.doc_no, h.den  from  my_agrp as p left join my_head as h on h.den=p.fi_id where h.doc_no= '"+subaccountgroup+"'";
	ResultSet rs = stmt.executeQuery(strSql);
	System.out.println(strSql);
	String acgroup="";
	//String id="";
	while(rs.next()) {
		acgroup=rs.getString("acgroup");
		//acgroup+=rs.getString("acgroup")+",";		
		//id+=rs.getString("doc_no")+",";
		
		
				
  		} 
	response.getWriter().write(acgroup);
	stmt.close();
	conn.close();
}catch(Exception e){

	e.printStackTrace();
	conn.close();

}
  
  %>
  
