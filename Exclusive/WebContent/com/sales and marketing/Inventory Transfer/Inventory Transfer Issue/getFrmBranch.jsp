<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
String brchid=request.getParameter("brchid")==null?"0":request.getParameter("brchid").trim();
String type=request.getParameter("type")==null?"0":request.getParameter("type").trim();

System.out.println("==type===="+type);

	String brch=session.getAttribute("BRANCHID").toString();
	String strSql ="";
	ClsConnection ClsConnection=new ClsConnection();
 	Connection conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	    if(type.equals("1")){
	    	strSql="select branchname,branch,doc_no from my_brch where doc_no="+brchid+"";
	    }
	    else if(type.equals("2")){
	    	strSql="select branchname,branch,doc_no from my_brch where doc_no="+brch+"";
	    }
		
		
		System.out.println("==strSql===="+strSql);
		
		
	ResultSet rs = stmt.executeQuery(strSql);
	String brid="";
	String brcode="";
	String brname="";
	while(rs.next()) {
		brid+=rs.getInt("doc_no")+",";
		brcode+=rs.getString("branch")+",";
		brname+=rs.getString("branchname")+",";
  		} 
	brid=brid.substring(0, brid.length()-1);
	brcode=brcode.substring(0, brcode.length()-1);
	brname=brname.substring(0, brname.length()-1);
	System.out.println(brid+"####"+brcode+"####"+brname);
	response.getWriter().write(brid+"####"+brcode+"####"+brname);
	
	stmt.close();
	conn.close();
  %>
  
