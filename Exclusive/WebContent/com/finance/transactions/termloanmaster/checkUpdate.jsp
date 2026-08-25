<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();

	String masterdocno=request.getParameter("masterdocno");
 	Connection conn = null;
 	try{
 		conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select psgstatus from gl_termloanm where doc_no='"+masterdocno+"' ";
 System.out.println("----------"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);

	int status=0;
	//String id="";
	if(rs.next()) {
		status=rs.getInt("psgstatus");
					
  		} 
	response.getWriter().print(status);
	//System.out.println("aaaaaa"+accode);
	stmt.close();
	conn.close();
 	}
	catch(Exception e){
		
			conn.close();
			
		} 
  
  %>
  
