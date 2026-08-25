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
		
		String strSql = "select description,doc_no from my_head where m_s='1' and den='255' and atype='AP'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String group="";String groupid="";
		while(rs.next()) {
			group+=rs.getString("description")+",";		
			groupid+=rs.getString("doc_no")+",";
	  		} 
		
		group=group.substring(0, group.length()>0?group.length()-1:0);
		
		response.getWriter().write(group+"####"+groupid);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
