<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String contractdocno=request.getParameter("contractdocno")==null?"0":request.getParameter("contractdocno");
JSONObject objdata=new JSONObject();
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strgetdetails="select if(coalesce(prop.mgprpty,0)=1,'Managed','Unmanaged') strmanage,coalesce(o.tele_phn,'') ownertel,coalesce(o.mobile,'') ownermobile,coalesce(o.email,'') owneremail,date_format(date_add(m.period_to,interval 1 day),'%d.%m.%Y') contractenddate,m.doc_no,m.voc_no,coalesce(m.ttype,1) contracttype,coalesce(ac.refname,'') tenantname,coalesce(ac.cldocno,0) "+
	" tenantdocno,coalesce(ac.address,'') tenantaddress,coalesce(ac.per_mob,'') tenantmobile,coalesce(ac.per_tel,'') tenanttel,coalesce(ac.mail1,'') tenantemail,"+
	" round(coalesce(amt.amount,0),2) contractamount,coalesce(if(prop.terms_mangfeevalue='',0,round(prop.terms_mangfeevalue,2)),0)"+
	" mgmtfeevalue,coalesce(if(prop.terms_mangfeeperc='',0,round(prop.terms_mangfeeperc,2)),0) mgmtfeepercent,"+
	" coalesce(prop.tenancy_cheque_owner_name,'') chktenancychequeowner,coalesce(prop.prid,'') propid,coalesce(prop.accname,'') propname,"+
	" coalesce(o.primary_owner,'') propowner,prop.doc_no propdocno from"+
	" rl_tncm m left join (select amount,rdocno from rl_tncterms where idno=1 group by rdocno) amt"+
	" on (m.doc_no=amt.rdocno) left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') left join rl_propertymaster prop"+
	" on (m.prtype=prop.doc_no) left join rl_propertryowner o on o.doc_no=prop.owid where m.status=3 and m.doc_no="+contractdocno;
	ResultSet rs=stmt.executeQuery(strgetdetails);
	while(rs.next()){
		objdata.put("contractdocno",rs.getString("doc_no"));
		objdata.put("contractvocno",rs.getString("voc_no"));
		objdata.put("contracttype",rs.getString("contracttype"));
		objdata.put("tenantname",rs.getString("tenantname"));
		objdata.put("tenantdocno",rs.getString("tenantdocno"));
		objdata.put("tenantaddress",rs.getString("tenantaddress"));
		objdata.put("tenantmobile",rs.getString("tenantmobile"));
		objdata.put("tenanttel",rs.getString("tenanttel"));
		objdata.put("tenantemail",rs.getString("tenantemail"));
		objdata.put("contractamount",rs.getString("contractamount"));
		objdata.put("mgmtfeevalue",rs.getString("mgmtfeevalue"));
		objdata.put("mgmtfeepercent",rs.getString("mgmtfeepercent"));
		objdata.put("chktenancychequeowner",rs.getString("chktenancychequeowner"));
		objdata.put("propid",rs.getString("propid"));
		objdata.put("propowner",rs.getString("propowner"));
		objdata.put("propname",rs.getString("propname"));
		objdata.put("propdocno",rs.getString("propdocno"));
		objdata.put("contractenddate",rs.getString("contractenddate"));
		objdata.put("ownertel",rs.getString("ownertel"));
		objdata.put("ownermobile",rs.getString("ownermobile"));
		objdata.put("owneremail",rs.getString("owneremail"));
		objdata.put("strmanage",rs.getString("strmanage"));
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