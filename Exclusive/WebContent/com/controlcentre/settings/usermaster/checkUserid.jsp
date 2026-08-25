<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
String userid=request.getParameter("userid");
String masterdoc=request.getParameter("masterdoc");
Connection conn=null ;
try{
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select doc_no from my_user where user_id='"+userid+"' and doc_no<>'"+masterdoc+"'";

	ResultSet rs = stmt.executeQuery(strSql);

	String useridval="";
	//String id="";
	if(rs.next()) {
		useridval=rs.getString("doc_no");
					
  		} 
	response.getWriter().write(useridval);
	//System.out.println("aaaaaa"+accode);
	stmt.close();
	conn.close();
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
  
  %>