<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%
ClsConnection objconn=new ClsConnection();
JSONObject objdata=new JSONObject();
Connection conn=null;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strgetrenewalstatus="select doc_no,statusname from rl_contractrenewalstatus where status=3 order by seqno";
	ResultSet rsgetrenewalstatus=stmt.executeQuery(strgetrenewalstatus);
	JSONArray renewalstatusarray=new JSONArray();
	while(rsgetrenewalstatus.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rsgetrenewalstatus.getString("doc_no"));
		objtemp.put("status",rsgetrenewalstatus.getString("statusname"));
		renewalstatusarray.add(objtemp);
	}
	ResultSet rsprop=stmt.executeQuery("select accname,doc_no from rl_propertymaster where status=3");
	JSONArray proparray=new JSONArray();
	while(rsprop.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rsprop.getString("doc_no"));
		objtemp.put("name",rsprop.getString("accname"));
		proparray.add(objtemp);
	}
	ResultSet rsowner=stmt.executeQuery("select doc_no,primary_owner name from rl_propertryowner where status=3");
	JSONArray ownerarray=new JSONArray();
	while(rsowner.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rsowner.getString("doc_no"));
		objtemp.put("name",rsowner.getString("name"));
		ownerarray.add(objtemp);
	}
	ResultSet rstenant=stmt.executeQuery("select m.refname,m.cldocno from my_acbook m  left join my_clcatm c on c.doc_no=m.catid  where m.dtype='CRM' and c.tenant=1 and m.status<>7");
	JSONArray tenantarray=new JSONArray();
	while(rstenant.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rstenant.getString("cldocno"));
		objtemp.put("name",rstenant.getString("refname"));
		tenantarray.add(objtemp);
	}
	objdata.put("renewalstatusdata",renewalstatusarray);
	objdata.put("tenantdata",tenantarray);
	objdata.put("ownerdata",ownerarray);
	objdata.put("propertydata",proparray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>