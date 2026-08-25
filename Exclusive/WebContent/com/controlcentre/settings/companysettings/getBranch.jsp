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
	String strSql = "select doc_no,branchname from my_brch where status<>7;";
	ResultSet rs = stmt.executeQuery(strSql);
	//System.out.println(strSql);
	String branch="";
	String branchid="";
	while(rs.next()) {
		branch+=rs.getString("branchname")+",";		
		branchid+=rs.getString("doc_no")+",";
		System.out.println(branch);
		
				
  		} 
	branch=branch.substring(0, branch.length()-1);
	stmt.close();
	conn.close();

	response.getWriter().write(branch+"***"+branchid);
	System.out.println("COMPID==="+branchid);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
	/* response.getWriter().write(auth.toArray()); */

  %>