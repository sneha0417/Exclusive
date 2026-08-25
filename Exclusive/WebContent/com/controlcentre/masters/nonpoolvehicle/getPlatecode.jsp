<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
ClsConnection ClsConnection=new ClsConnection();



Connection conn = null;

try{
conn=ClsConnection.getMyConnection();
	String temp=request.getParameter("id");
 	
	Statement stmt = conn.createStatement ();
	String strSql = "select code_name, doc_no from gl_vehplate where status <> 7 and authid="+temp;
	ResultSet rs = stmt.executeQuery(strSql);
	String platename="";
	String id="";
	while(rs.next()) {
		platename+=rs.getString("code_name")+",";		
		id+=rs.getString("doc_no")+",";
  		} 
	
	platename=platename.substring(0, platename.length()>0?platename.length()-1:0);
	stmt.close();
	conn.close();
	response.getWriter().write(platename+"***"+id);
	
	 
	}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
finally{
	conn.close();
}
		%>
		
  