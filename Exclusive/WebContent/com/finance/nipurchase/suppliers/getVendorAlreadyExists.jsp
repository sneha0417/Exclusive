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
		
		String vendorname=request.getParameter("vendorname");
		String docno=request.getParameter("docno");
		String mode=request.getParameter("mode");
	    
		if(mode.equalsIgnoreCase("A") && docno.equalsIgnoreCase("")){
			sql = "select * from my_acbook where status<>7 and dtype='VND' and refname=trim('"+vendorname+"')";
		}else if(mode.equalsIgnoreCase("E") && !(docno.equalsIgnoreCase(""))){
			sql = "select * from my_acbook where status<>7 and dtype='VND' and refname=trim('"+vendorname+"') and doc_no!="+docno+"";
		}
		
		ResultSet rs = stmt.executeQuery(sql);
		
		while(rs.next()) {
			AlreadyExists=1;
		} 
		
		response.getWriter().print(AlreadyExists);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  