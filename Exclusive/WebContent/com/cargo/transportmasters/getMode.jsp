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
		
		String strSql = "select modename ,doc_no from cr_mode where  status=3";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String mode="",sr="";
		while(rs.next()) {
					mode+=rs.getString("modename")+",";
					sr+=rs.getString("doc_no")+",";
				} 
		
		String modes[]=mode.split(",");
		String modeId[]=sr.split(",");
		
		mode=mode.substring(0, mode.length()-1);
		sr=sr.substring(0, sr.length()-1);
		
		response.getWriter().write(sr+"####"+mode);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  