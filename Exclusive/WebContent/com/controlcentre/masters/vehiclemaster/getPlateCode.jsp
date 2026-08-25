<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
Connection conn = ClsConnection.getMyConnection();
try{
String temp=request.getParameter("id");
 	
	Statement stmt = conn.createStatement ();
	String strSql = "select code_name, doc_no from gl_vehplate where status <> 7 and authid="+temp;
	ResultSet rs = stmt.executeQuery(strSql);
	String plate="";
	String plateid="";
	while(rs.next()) {
		plate+=rs.getString("code_name")+",";		
		plateid+=rs.getString("doc_no")+",";
  		} 
	//plate=plate.substring(0, plate.length()-1);
	plate=plate.substring(0, plate.length()>0?plate.length()-1:0);
	response.getWriter().write(plate+"####"+plateid);
	stmt.close();
	conn.close();
 
}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	%>
  
