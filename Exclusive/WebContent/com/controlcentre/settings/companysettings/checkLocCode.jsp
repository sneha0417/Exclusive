<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>

<%	
ClsConnection ClsConnection=new ClsConnection();
Connection conn=null;
try{
String temp=request.getParameter("code")==null||request.getParameter("code")==""?"0":request.getParameter("code");
String doc=request.getParameter("doc")==null||request.getParameter("doc")==""?"0":request.getParameter("doc");
	System.out.println(temp);
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select loc from my_locm where (loc='"+temp+"' and doc_no<>"+doc+") and status<>7";
	System.out.println(strSql);
	ResultSet rs = stmt.executeQuery(strSql);
	
	String loc="";
	if(rs.next()) {
		loc=rs.getString("loc");
  		} 
	else{
		loc="undefine";
	}
	stmt.close();
	conn.close();


	response.getWriter().write(loc);
	System.out.println("loc:"+loc);
	/* response.getWriter().write(auth.toArray()); */
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
	%>