<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
	String name=request.getParameter("name");
	Connection conn=null ;
	try{
	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select user_role,doc_no from my_urole;";
	ResultSet rs = stmt.executeQuery(strSql);
	String role="",roleId="";
	while(rs.next()) {
		role+=rs.getString("user_role")+",";
		roleId+=rs.getString("doc_no")+",";
  		} 
	role=role.substring(0, role.length()-1);
	roleId=roleId.substring(0, roleId.length()-1);
	response.getWriter().write(role+"####"+roleId);
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
  
