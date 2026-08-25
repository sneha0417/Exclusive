<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
Connection conn = null;
try{
	
	ClsConnection connDAO= new ClsConnection();
String tran=request.getParameter("tran");

 	 conn = connDAO.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select den from my_head where doc_no='"+tran+"'  ";
	//System.out.println("------strSql-------"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);

	String accode="";
	//String id="";
	if(rs.next()) {
		accode=rs.getString("den");
					
  		} 
	response.getWriter().print(accode);
	//System.out.println("aaaaaa"+accode);
	stmt.close();
	conn.close();
	
	
}
catch(Exception e){

		e.printStackTrace();
		conn.close();
	
	}
	  
  
  %>