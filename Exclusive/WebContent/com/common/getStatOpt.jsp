  
 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	

ClsConnection ClsConnection=new ClsConnection();
     /* String dtype=request.getParameter("dtype"); */
	Connection conn = null;
	
	try{
		
		
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();

	 String strSql = "select doc_no, opt_name, opt_code from my_exeopt where status=3 order by opt_name" ;
		
		ResultSet rs = stmt.executeQuery(strSql);
		
		String refdocno="",refcode="",refname="";
		while(rs.next()) {
			refdocno+=rs.getString("doc_no")+",";
			refcode+=rs.getString("opt_code")+",";
			refname+=rs.getString("opt_name")+",";
	  		} 
	
		String refdoc[]=refdocno.split(",");
		String refcod[]=refcode.split(",");
		String refnam[]=refname.split(",");
		
		
		refdocno=refdocno.substring(0, refdocno.length()-1);
		refcode=refcode.substring(0, refcode.length()-1);
		refname=refname.substring(0, refname.length()-1);
		
		
		//System.out.println("Status Selection"+refname+"####"+refcode+"####"+refdocno);
		
		response.getWriter().write(refname+"####"+refcode+"####"+refdocno);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
 
 
 
 
 
 
 
 
 