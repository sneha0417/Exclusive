<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>
<%@page import="com.common.*"%>

<%
Connection conn=null;
ClsConnection objconn=new ClsConnection();
try{
String doc=request.getParameter("doc");
String fleet=request.getParameter("fleet");
String regno=request.getParameter("regno");
String status=request.getParameter("status");
System.out.println("FLEET"+fleet);
 	conn = objconn.getMyConnection();
	Statement stmt = conn.createStatement ();
	String tempSql="";
	JSONArray jsonArray = new JSONArray();
	if(!((doc.equalsIgnoreCase(""))||doc==null)){
		tempSql=tempSql+" and doc_no="+doc+"";
	}
	if(!((fleet.equalsIgnoreCase(""))||(fleet==null))){
		tempSql=tempSql+" and fleet_no="+fleet+"";
	}
	String strSql = "select doc_no,fleet_no,date from gl_vmove where 1=1 "+tempSql;
	 System.out.println(strSql);
		ResultSet resultSet = stmt.executeQuery(strSql);
		while (resultSet.next()) {
			int total_rows = resultSet.getMetaData().getColumnCount();
			JSONObject obj = new JSONObject();
			for (int i = 0; i < total_rows; i++) {
				obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), ((resultSet.getObject(i + 1)==null) ? "NA" : resultSet.getObject(i + 1).toString()));
			}
	jsonArray.add(obj);
	 
	}
		stmt.close();
		conn.close();
		System.out.println(jsonArray);
		response.getWriter().write(jsonArray.toString());
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
		%>