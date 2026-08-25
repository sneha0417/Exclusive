<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
Connection conn = null;
try{

String mainacccode=request.getParameter("code");
String masterdoc=request.getParameter("masterdoc");
 	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select costcode  from my_ccentre where costcode='"+mainacccode+"' and doc_no<>'"+masterdoc+"' ";
	ResultSet rs = stmt.executeQuery(strSql);
	//System.out.println(strSql);
	String accode="";
	//String id="";
	if(rs.next()) {
		accode=rs.getString("costcode");
					
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
  
