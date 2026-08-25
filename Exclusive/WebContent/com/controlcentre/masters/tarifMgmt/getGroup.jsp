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
	String docno=request.getParameter("id");
	 System.out.println("ID"+docno);
	/* //System.out.println("GID"+gid);  */
	JSONArray jsonArray = new JSONArray();
	 String strSql = "select m5.gid from  gl_vehgroup m5 where m5.gid not in(select distinct if(m2.gid is null,if(m3.gid is null,'1',m3.gid),m2.gid) "+
		 "gid from gl_tarifm m1 left join gl_tarifd m2 on m1.doc_no=m2.doc_no left join gl_tarifcondn m3 on m1.doc_no=m3.doc_no where m1.doc_no='"+docno+"')";
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