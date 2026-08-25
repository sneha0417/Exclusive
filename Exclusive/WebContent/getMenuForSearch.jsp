
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%
System.out.println("Inside AJAX");	
ClsConnection ClsConnection = new ClsConnection();

	String term = request.getParameter("searchterm");
	Connection conn = null;

	try {
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();

		ArrayList<String> list = new ArrayList<String>();

		String strSql = "select menu_name from my_menu where menu_name like '% '"
				+ term + "'%'";
		
		System.out.println("sqllllll==="+strSql);
		
		ResultSet rs = stmt.executeQuery(strSql);
		ClsCommon com = new ClsCommon();
		System.out.println("menu====" + com.convertToJSON(rs));
		response.getWriter().println(com.convertToJSON(rs));
		stmt.close();
		conn.close();
	} catch (Exception e) {
		e.printStackTrace();
		conn.close();
	} finally {
		conn.close();
	}
%>








