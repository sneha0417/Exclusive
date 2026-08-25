<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
try{
	//String name=request.getParameter("name");
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select authname,doc_no from gl_vehauth";
	ResultSet rs = stmt.executeQuery(strSql);
	String auth="",authId="";
	while(rs.next()) {
		auth+=rs.getString("authname")+",";
		authId+=rs.getString("doc_no")+",";
  		} 
	if(auth.length()>0){
	auth=auth.substring(0, auth.length()-1);
	}
	//authId=authId.substring(0, authId.length()-1);
	stmt.close();
	conn.close();
	response.getWriter().write(auth+"####"+authId);
	session.setAttribute("authName", auth);

}
catch(Exception e1){
	e1.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
	%>
  
