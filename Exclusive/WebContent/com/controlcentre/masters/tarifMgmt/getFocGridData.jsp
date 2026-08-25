<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>


<%	
System.out.println("Here");
ClsConnection ClsConnection=new ClsConnection();
 	Connection conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();

/* String sess1=request.getParameter("sess");
System.out.println("Session"+sess1); */
	String docno=request.getParameter("id");
	String gid=request.getParameter("gid");
	System.out.println("ID"+docno);
	System.out.println("GID"+gid);
	JSONArray jsonArray = new JSONArray();
	 String strSql = "select branch,cdw,pai,kmrest,exkmrte,rate,minday,foc from gl_tarifcondn where ctype='cfoc' and doc_no='"+docno+"' and gid='"+gid+"' and branch=1";
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
	%>