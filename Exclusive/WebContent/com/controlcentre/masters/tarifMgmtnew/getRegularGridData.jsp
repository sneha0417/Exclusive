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
	 String strSql = "select m1.cdw,m1.pai,m1.kmrest,m1.exkmrte,m1.rate,m1.disclevel1,m1.disclevel2,m1.disclevel3,m1.cdw1,"+
			"m1.pai1,m1.oinschg,m1.chaufchg,m1.chaufexchg,m1.exhrchg,m2.rentaltype from gl_tarifd m1 left join gl_tlistm m2 on m1.renttype=m2.rentaltype where "+
			"m1.gid='"+gid+"' and m1.doc_no='"+docno+"' and m1.branch=1 order by m2.doc_no";
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