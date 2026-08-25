<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
	Connection conn = null;

	try{
		ClsConnection connDAO = new ClsConnection();
	 	conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		int AlreadyExists=0;
		String sql ="";
		
		String empcode=request.getParameter("empcode");
		String docno=request.getParameter("docno");
		String mode=request.getParameter("mode");
	    
		if(!(empcode.trim().equalsIgnoreCase("") || empcode.equalsIgnoreCase("0"))){
			
		if(mode.equalsIgnoreCase("A") && docno.trim().equalsIgnoreCase("")){
			sql = "select codeNo from hr_empm where status<>7 and active=1 and codeNo='"+empcode+"'";
		} else if(mode.equalsIgnoreCase("E") && !(docno.trim().equalsIgnoreCase(""))){
			sql = "select codeNo from hr_empm where status<>7 and active=1 and codeNo='"+empcode+"' and doc_no!="+docno+"";
		 }

		ResultSet rs = stmt.executeQuery(sql);
		
		while(rs.next()) {
			AlreadyExists=1;
		} 
		
		}		

		response.getWriter().print(AlreadyExists);
		
		stmt.close();
		conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	} finally{
		conn.close();
	}
  %>
  