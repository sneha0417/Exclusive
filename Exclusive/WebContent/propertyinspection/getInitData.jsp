<%@page import="propertyinsplogin.ClsPropertyInspLoginDAO"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
String userid=session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString();
String insptype=request.getParameter("insptype")==null?"":request.getParameter("insptype");
String mode=request.getParameter("mode")==null?"":request.getParameter("mode").toString();
String requestdocno=request.getParameter("requestdocno")==null?"0":request.getParameter("requestdocno").toString();
System.out.println("User ID:"+userid);
System.out.println("Insp Type:"+insptype);
System.out.println("Mode:"+mode);
System.out.println("Request Doc No:"+requestdocno);

try{
	ClsConnection objconn=new ClsConnection();
	ClsPropertyInspLoginDAO dao=new ClsPropertyInspLoginDAO();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String sqltest="";
	if(insptype.equalsIgnoreCase("Inspection")){
		if(mode.equalsIgnoreCase("E") && !requestdocno.equalsIgnoreCase("") && Integer.parseInt(requestdocno)>0){
			sqltest=" and insp.doc_no="+requestdocno;			
		}
		else{
			sqltest=" and p.ins_status<4 and p.insassignuser="+userid+"";	
		}
		
	}
	else if(insptype.equalsIgnoreCase("Hand Over")){
		if(mode.equalsIgnoreCase("E") && !requestdocno.equalsIgnoreCase("") && Integer.parseInt(requestdocno)>0){
			sqltest=" and insp.doc_no="+requestdocno;			
		}
		else{
			sqltest=" and t.handoveruser="+userid+"";	
		}
		
	}
	else if(insptype.equalsIgnoreCase("Hand Back")){
		if(mode.equalsIgnoreCase("E") && !requestdocno.equalsIgnoreCase("") && Integer.parseInt(requestdocno)>0){
			sqltest=" and insp.doc_no="+requestdocno;		
		}
		else{
			sqltest=" and t.handbackuser="+userid+"";	
		}
		
	}
	else{
		sqltest=" and p.ins_status<4 and p.insassignuser="+userid+"";
	}
	String strgetdocuments="";
	if(mode.equalsIgnoreCase("E") && !requestdocno.equalsIgnoreCase("") && Integer.parseInt(requestdocno)>0){
		strgetdocuments="select coalesce(insp.doc_no,0) inspdocno,p.prid,p.doc_no,p.date pdate,t.doc_no tdocno,t.Period_from tdate,p.accname property,if(aliasname !='',"+
				" aliasname,primary_owner) owner,m.refname tenant,m.mail1 as tenantemail,case when p.terms_insptype='HY' then 'Half Yearly' when  "+
				" p.terms_insptype='M' then 'Monthly' when p.terms_insptype='Q' then 'Quaterly' end as terms_insptype ,case when p.terms_insasper='P' then "+
				" 'Property' when p.terms_insasper='T' then 'Tenant' end as terms_insasper,date_format(p.ins_date,'%d.%m.%Y') scheduledate from rl_propinspm insp left join rl_propertymaster p on (insp.propdocno=p.doc_no) left join rl_propertryowner o "+
				" on o.doc_no=p.owid left join (select max(doc_no) maxtncdocno,prtype from rl_tncm where status=3 group by prtype) maxtnc on "+
				" p.doc_no=maxtnc.prtype left join rl_tncm t on t.doc_no=maxtnc.maxtncdocno left join my_acbook m on m.cldocno=t.cldocno"+
				" left join my_clcatm c on c.doc_no=m.catid where m.dtype='CRM' and c.tenant=1 and m.status<>7 "+sqltest+" order by p.doc_no";
	}
	else{
		strgetdocuments="select coalesce(p.inspdocno,0) inspdocno,p.prid,p.doc_no,p.date pdate,t.doc_no tdocno,t.Period_from tdate,p.accname property,if(aliasname !='',"+
				" aliasname,primary_owner) owner,m.refname tenant,m.mail1 as tenantemail,case when p.terms_insptype='HY' then 'Half Yearly' when  "+
				" p.terms_insptype='M' then 'Monthly' when p.terms_insptype='Q' then 'Quaterly' end as terms_insptype ,case when p.terms_insasper='P' then "+
				" 'Property' when p.terms_insasper='T' then 'Tenant' end as terms_insasper,date_format(p.ins_date,'%d.%m.%Y') scheduledate from rl_propertymaster p left join rl_propertryowner o "+
				" on o.doc_no=p.owid left join (select max(doc_no) maxtncdocno,prtype from rl_tncm where status=3 group by prtype) maxtnc on "+
				" p.doc_no=maxtnc.prtype left join rl_tncm t on t.doc_no=maxtnc.maxtncdocno left join my_acbook m on m.cldocno=t.cldocno"+
				" left join my_clcatm c on c.doc_no=m.catid where m.dtype='CRM' and c.tenant=1 and m.status<>7 "+sqltest+" order by p.doc_no";
	}
	System.out.println(strgetdocuments);
	ResultSet rsdoc=stmt.executeQuery(strgetdocuments);
	JSONArray docarray=new JSONArray();
	while(rsdoc.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("id",rsdoc.getString("prid"));
		objtemp.put("propdocno",rsdoc.getString("doc_no"));
		objtemp.put("propname",rsdoc.getString("property"));
		objtemp.put("owner",rsdoc.getString("owner"));
		objtemp.put("tenant",rsdoc.getString("tenant"));
		objtemp.put("tncdocno",rsdoc.getString("tdocno"));
		objtemp.put("inspdocno",rsdoc.getString("inspdocno"));
		objtemp.put("scheduledate",rsdoc.getString("scheduledate"));
		docarray.add(objtemp);
	}
	String username=session.getAttribute("USERNAME")==null?"":session.getAttribute("USERNAME").toString();
	
	objdata.put("username",username);
	objdata.put("docdata",docarray);
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>