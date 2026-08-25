<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
Connection conn = null;
try{
	ClsConnection connDAO= new ClsConnection();

String mainacccode=request.getParameter("code");
String masterdoc=request.getParameter("masterdoc");
//System.out.println("maindddddddddddddddddddddddddddddddddddddddddddddacccode"+mainacccode);
 	 conn = connDAO.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select Account from my_head where Account='"+mainacccode+"' and doc_no<>'"+masterdoc+"' ";
	
	ResultSet rs = stmt.executeQuery(strSql);

	String accode="";
	//String id="";
	if(rs.next()) {
		accode=rs.getString("Account");
					
  		} 
	response.getWriter().write(accode);
	//System.out.println("aaaaaa"+accode);
	stmt.close();
	conn.close();
	
	
}
catch(Exception e){

		e.printStackTrace();
		conn.close();
	
	}
	  
  
  %>
  
