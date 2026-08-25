<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	Connection conn = null;
	
	try{
		ClsConnection connDAO = new ClsConnection();
	 	conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select name,doc_no from cm_bankdetails where status=3";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String bankname="";
		String bankid="";
		while(rs.next()) {
			bankname+=rs.getString("name")+",";	
			bankid+=rs.getString("doc_no")+",";
	  		} 
		
		bankname=bankname.substring(0, bankname.length()>0?bankname.length()-1:0);
		
		response.getWriter().write(bankname+"####"+bankid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
