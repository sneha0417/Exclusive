<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

	
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		
		String strSql = "select doc_no, rdesc1 from re_mroom";
		System.out.println(strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		
		String room="",roomId="";
		while(rs.next()) {
			room+=rs.getString("rdesc1")+",";
			roomId+=rs.getString("doc_no")+",";
				}  		
		room=room.substring(0, room.length()-1);
		roomId=roomId.substring(0, roomId.length()-1);
		
		response.getWriter().write(roomId+"####"+room);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>