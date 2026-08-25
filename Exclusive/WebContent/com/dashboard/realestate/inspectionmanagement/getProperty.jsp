<%@page import="java.util.ArrayList"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
JSONObject objinsurtype=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	String strgetinsurtype="select doc_no,accname name from rl_propertymaster where status=3 and mgprpty=1";
	ResultSet rsgetinsurtype=stmt.executeQuery(strgetinsurtype);
	ArrayList<String> insurtypearray=new ArrayList();
	while(rsgetinsurtype.next()){
		insurtypearray.add(rsgetinsurtype.getString("doc_no")+"***"+rsgetinsurtype.getString("name"));
	}
	objinsurtype.put("insurtypearray", insurtypearray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(objinsurtype);            
%>