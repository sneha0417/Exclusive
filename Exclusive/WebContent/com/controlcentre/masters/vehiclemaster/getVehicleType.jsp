<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
ClsConnection objconn=new ClsConnection();
JSONObject data=new JSONObject();
Connection conn = null;
try{	
	conn=objconn.getMyConnection();
	JSONArray detailarray=new JSONArray();
	Statement stmt = conn.createStatement ();
	String strSql = "select name,doc_no from gl_vehtype where status<>7";
	ResultSet rs = stmt.executeQuery(strSql);
	while(rs.next()) {
		JSONObject objtemp=new JSONObject();
		objtemp.put("name",rs.getString("name"));
		objtemp.put("docno",rs.getString("doc_no"));
		detailarray.add(objtemp);
	} 
	data.put("vehtypearray",detailarray);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(data+"");
%>
  
