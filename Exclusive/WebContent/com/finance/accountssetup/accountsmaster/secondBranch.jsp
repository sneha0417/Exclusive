<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	

Connection conn = null;
try{
String second=request.getParameter("second");
ClsConnection connDAO = new ClsConnection();
 	 conn = connDAO.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select doc_no, BRANCHNAME from my_brch where doc_no<>'"+second+"' ";
	ResultSet rs = stmt.executeQuery(strSql);
	//System.out.println(strSql);
	String id="",name="";
	while(rs.next()) {
		id+=rs.getString("doc_no")+",";
		name+=rs.getString("BRANCHNAME")+",";
		
  		} 
	id=id.substring(0, id.length());
	name=name.substring(0, name.length());
		response.getWriter().write(name+"####"+id);
	session.setAttribute("name",name);
	stmt.close();
	conn.close();
	
	
}
catch(Exception e){

	e.printStackTrace();
	conn.close();

}
	
	
  %>
  
