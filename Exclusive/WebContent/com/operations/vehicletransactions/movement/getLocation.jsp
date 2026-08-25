<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>

<%

 	Connection conn = null;
	ClsConnection objconn=new ClsConnection();
try{
	conn=objconn.getMyConnection();
	String branch=(request.getParameter("branch")=="" || request.getParameter("branch")==null)?"0":request.getParameter("branch");
Statement stmt = conn.createStatement ();
//System.out.println("check Session in Ajax:"+session.getAttribute("BRANCHID").toString());
	String strSql = "select loc_name,doc_no from my_locm where status<>7 and brhid="+branch;
	// System.out.println("Location Query:"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);
	String loc="";
	String id="";
	while(rs.next()) {
		loc+=rs.getString("loc_name")+",";		
		id+=rs.getString("doc_no")+",";
  		} 
//	System.out.println("Location:"+loc+"***"+id);
	if(loc.length()>0){
	loc=loc.substring(0, loc.length()-1);
	}
	

	stmt.close();
	conn.close();
	response.getWriter().write(loc+"***"+id);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>