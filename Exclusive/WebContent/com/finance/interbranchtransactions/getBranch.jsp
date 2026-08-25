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

		String strSql = "select branchname,doc_no from my_brch where cmpid='"+session.getAttribute("COMPANYID")+"'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String brnch="",brnchId="";
		while(rs.next()) {
					brnch+=rs.getString("branchname")+",";
					brnchId+=rs.getString("doc_no")+",";
				} 
		
		String brn[]=brnch.split(",");
		String brnId[]=brnchId.split(",");
		
		brnch=brnch.substring(0, brnch.length()>0?brnch.length()-1:0);
		brnchId=brnchId.substring(0, brnchId.length()>0?brnchId.length()-1:0);
		
		response.getWriter().write(brnchId+"####"+brnch);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
	
  %>
  