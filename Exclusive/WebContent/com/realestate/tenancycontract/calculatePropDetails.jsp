<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String propdocno=request.getParameter("propdocno")==null?"":request.getParameter("propdocno");
Connection conn=null;
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select coalesce(if(m.terms_rentcommisiomperc='',0,round(m.terms_rentcommisiomperc,2)),0) mgmtfeevalue,coalesce(if(m.terms_mangfeeperc='',"+
	" 0,round(m.terms_mangfeeperc,2)),0) mgmtfeepercent,m.tenancy_cheque_owner_name chktenancychequeowner,m.prid propertyid,m.unitno,m.optid,"+
	" m.doc_no, m.voc_no,  m.date, accname as name,  o.primary_owner  owner,desc1,if(m.cnt_no>0,'RENTED','AVAILABLE') type, "+
	" convert(if(m.cnt_no>0,DATE_ADD(cnt_date, INTERVAL 1 DAY),''),char(100)) adate, m.terms_mangfeeperc as mngperc  from rl_propertymaster m "+
	" left join rl_propertryowner o on o.doc_no=m.owid where m.status=3 and m.doc_no="+propdocno+" group by m.doc_no ";
	System.out.println(strsql);
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		objdata.put("mgmtfeevalue", rs.getString("mgmtfeevalue"));
		objdata.put("mgmtfeepercent", rs.getString("mgmtfeepercent"));
		objdata.put("chktenancychequeowner", rs.getString("chktenancychequeowner"));
		objdata.put("propertyid", rs.getString("propertyid"));
		objdata.put("unitno", rs.getString("unitno"));
		objdata.put("optid", rs.getString("optid"));
		objdata.put("doc_no", rs.getString("doc_no"));
		objdata.put("voc_no", rs.getString("voc_no"));
		objdata.put("date", rs.getString("date"));
		objdata.put("name", rs.getString("name"));
		objdata.put("owner", rs.getString("owner"));
		objdata.put("desc1", rs.getString("desc1"));
		objdata.put("type", rs.getString("type"));
		objdata.put("adate", rs.getString("adate"));
		objdata.put("mngperc", rs.getString("mngperc"));
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>