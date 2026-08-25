<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
	Connection conn=null;
try{
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select c_name,doc_no from my_curr where status<>7";
	ResultSet rs = stmt.executeQuery(strSql);
	//System.out.println(strSql);
	String curr="";
	String currid="";
	while(rs.next()) {
		curr+=rs.getString("c_name")+",";		
		currid+=rs.getString("doc_no")+",";
		System.out.println(curr);
		
				
  		} 
	curr=curr.substring(0, curr.length()-1);
	stmt.close();
	conn.close();

	response.getWriter().write(curr+"***"+currid);
	System.out.println("brand==="+currid);
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