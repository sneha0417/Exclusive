<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%	
	Connection conn = null;

	try{
		ClsConnection connDAO = new ClsConnection();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select name,code,designation,department,email,mobile,availability from gw_empavailability where status=3 and userid='"+session.getAttribute("USERID").toString()+"'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String name="",code="",designation="",department="",email="",mobile="",availability="0";
		while(rs.next()) {
			name=rs.getString("name");
			code=rs.getString("code");
			designation=rs.getString("designation");
			department=rs.getString("department");
			email=rs.getString("email");
			mobile=rs.getString("mobile");
			availability=rs.getString("availability");
		} 
		
		response.getWriter().write(name+"####"+code+"####"+designation+"####"+department+"####"+email+"####"+mobile+"####"+availability);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  