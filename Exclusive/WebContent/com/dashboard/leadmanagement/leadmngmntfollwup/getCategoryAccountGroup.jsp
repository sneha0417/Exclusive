<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
ClsConnection conobj= new ClsConnection();
	Connection conn = null;
	
	try{
	 	conn = conobj.getMyConnection();
		Statement stmt = conn.createStatement();
		String category=request.getParameter("category");
		
		System.out.println("category = "+category);
		
		String strSql = "select acc_group,doc_no from my_clcatm where status=3 and doc_no="+category;
		System.out.println("strSql = "+strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		
		String groupid="",docno="";
		while(rs.next()) {
			groupid=rs.getString("acc_group");
			docno=rs.getString("doc_no");
		} 
		
		System.out.println("groupid = "+groupid);		
		response.getWriter().write(groupid+"###"+docno);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
