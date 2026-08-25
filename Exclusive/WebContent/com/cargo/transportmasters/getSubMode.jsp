<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<% String modeid = request.getParameter("modeid")==null?"0":request.getParameter("modeid"); %>
  

<%	

    ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "SELECT submode submode1,doc_no FROM cr_smode where status=3 and modeid='"+modeid+"'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String submode="",sr="";
		while(rs.next()) {
					submode+=rs.getString("submode1")+",";
					sr+=rs.getString("doc_no")+",";
				} 
		
		String submodes[]=submode.split(",");
		String submodeId[]=sr.split(",");
		
		submode=submode.substring(0, submode.length()-1);
		sr=sr.substring(0, sr.length()-1);
		
		response.getWriter().write(sr+"####"+submode);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  