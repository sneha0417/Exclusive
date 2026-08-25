<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	ClsConnection ClsConnection=new ClsConnection();

	Connection conn = null;
	
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select costtype, costgroup from my_costunit where status=1";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String group="",code="";
		while(rs.next()) {
					group+=rs.getString("costgroup")+",";
					code+=rs.getString("costtype")+",";
				} 
		
		String procc[]=group.split(",");
		String brnId[]=code.split(",");
		
		group=group.substring(0, group.length()-1);
		code=code.substring(0, code.length()-1);
		
		response.getWriter().write(code+"####"+group);
		
		stmt.close();
		conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	} finally{
		conn.close();
	}
  %>
  