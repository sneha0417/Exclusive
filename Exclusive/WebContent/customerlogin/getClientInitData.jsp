<%@page import="customerlogin.ClsCustomerLoginDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
Connection conn=null;
JSONObject objrenewal=new JSONObject();
JSONObject objinsurtype=new JSONObject();
JSONObject objcontactperson=new JSONObject();
JSONObject objpolicyno=new JSONObject();
JSONObject objchartdata=new JSONObject();
ClsCustomerLoginDAO dao=new ClsCustomerLoginDAO();
String cldocno=session.getAttribute("CLDOCNO")==null?"":session.getAttribute("CLDOCNO").toString();
String refname="",mobile="",email="",acno="",pdcinhand="",subreciept="",advance="",balance="",unapplied="",total="";
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	java.sql.Date sqldate=null;
	
	String strsql="select CURDATE() sqldate,coalesce(po.primary_owner,'') refname,coalesce(po.mobile,'') mobile,coalesce(po.email,'') email,"+
	" pm.acno from rl_propertryowner po left join rl_propertymaster pm on po.doc_no=pm.owid where po.doc_no="+cldocno+" and po.status=3 group by po.doc_no";
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		refname=rs.getString("refname");
		mobile=rs.getString("mobile");
		email=rs.getString("email");
		acno=rs.getString("acno");
		sqldate=rs.getDate("sqldate");
	}
	
	/* String strgetcarddata="select coalesce(aa.pdcamount,0) pdcinhand,coalesce(aa.subrcpt,0) subreciept,coalesce(aa.advance,0) advance,coalesce(aa.balance,0) balance,coalesce(aa.total,0) total,coalesce(aa.unapplied,0) unapplied from (select f.pdcamount,g.subrcpt,a.*,bk.period2 creditperiod,bk.credit creditlimit,bk.mail1 email,if(bk.per_mob is null,bk.com_mob,if(bk.per_mob='NA',bk.com_mob,if(bk.per_mob=' ',bk.com_mob,bk.per_mob))) mobile_no,bk.contactPerson contact_person,s.sal_name from (select name 'account_name',CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),''),CHAR(50)) 'advance',"+
	" CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(50)) 'balance',CONVERT(if(sum(u6<0),round((sum(u6*-1)),2),''),CHAR(50)) 'unapplied',"+
	" CONVERT(if(sum(t7)>0,round((sum(t7)),2),''),CHAR(50)) 'total',CONVERT(if(sum(l1)>0,round((sum(l1)),2),''),CHAR(50)) 'level_1',"+
	" CONVERT(if(sum(l2)>0,round((sum(l2)),2),''),CHAR(50)) 'level_2',CONVERT(if(sum(l3)>0,round((sum(l3)),2),''),CHAR(50)) 'level_3',"+
	" CONVERT(if(sum(l4)>0,round((sum(l4)),2),''),CHAR(50)) 'level_4',CONVERT(if(sum(l5)>0,round((sum(l5)),2),''),CHAR(50)) 'level_5',"+
	" ag.acno 'account',ag.brhid 'branch_id' from (select d.name,d.acno,d.brhid,d.doc_no,"+
	" if(d.duedys between 0 and 30 and d.bal>0,round((d.bal),2),0) l1,if(d.duedys between 31 and 60 and d.bal>0,"+
	" round((d.bal),2),0) l2,if(d.duedys between 61 and 90 and d.bal>0,round((d.bal),2),0) l3,if(d.duedys between 91 and 120 and d.bal>0,"+
	" round((d.bal),2),0) l4,if(d.duedys >=121 and d.bal>0,round((d.bal),2),0) l5,CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(50)) U6,"+
	" if(d.bal>0,d.bal,0) t7 from  (select j.acno,j.brhid,h.description name,sum(dramount) - coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqldate+"' as datetime)) duedys"+
	" from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid where"+
	" j.date<='"+sqldate+"' group by ap_trid ) o on j.tranid=o.ap_trid where j.status=3 and h.atype='AR' and j.date<='"+sqldate+"'  and j.acno="+acno+" and j.id > 0 group by j.tranid having bal<>0"+ 
	" union all select j.acno,j.brhid,h.description name,sum(dramount)- coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqldate+"' as datetime)) duedys"+
	" from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqldate+"'"+
	" group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='AR' and j.date<='"+sqldate+"' and j.acno="+acno+" and j.id < 0 group by j.tranid having bal<>0) d) ag group by acno ) a  left join (select SUM(j.DRAMOUNT)pdcAmount,j.TR_NO,j.acno  from MY_JVTRAN J INNER JOIN my_CHQDET C ON J.TR_NO=C.TR_NO WHERE C.PDC=1  AND C.STATUS='E' AND J.STATUS=3   and j.acno="+acno+" group by j.acno )f on f.acno=a.account  left join (select sum(dramount) subrcpt,j.acno from my_jvtran j where date>'"+sqldate+"' and dramount<0  and j.acno="+acno+" group by j.acno)g on g.acno=a.account  left join my_acbook bk on a.account=bk.acno"+
	" and bk.status=3 left join my_salm s on bk.sal_id=s.doc_no where 1=1) aa ";
	ResultSet rscarddata=stmt.executeQuery(strgetcarddata);
	while(rscarddata.next()){
		pdcinhand=rscarddata.getString("pdcinhand");
		subreciept=rscarddata.getString("subreciept");
		advance=rscarddata.getString("advance");
		balance=rscarddata.getString("balance");
		unapplied=rscarddata.getString("unapplied");
		total=rscarddata.getString("total");
	} */
	//objchartdata=dao.getChartCountData(cldocno,conn);
	
	String strgethelpdesk="select doc_no,coalesce(name,'') name,coalesce(department,'') department,coalesce(email,'') email,coalesce(mobile,'') mobile from gl_helpdesk where status=3";
	ResultSet rsgethelpdesk=stmt.executeQuery(strgethelpdesk);
	ArrayList<String> helpdeskarray=new ArrayList();
	int helpdeskserial=1;
	while(rsgethelpdesk.next()){
		helpdeskarray.add(helpdeskserial+"***"+rsgethelpdesk.getInt("doc_no")+"***"+rsgethelpdesk.getString("name")+"***"+rsgethelpdesk.getString("department")+"***"+rsgethelpdesk.getString("email")+"***"+rsgethelpdesk.getString("mobile"));
		helpdeskserial++;
	}
	objpolicyno.put("helpdeskdata", helpdeskarray);
	//System.out.println(objpolicyno);
	String strprop="select coalesce(unitno,'') unitno,coalesce(accname,'') accname,coalesce(prid,'') prid,coalesce(a.area,'') area,if(mgprpty=1,'Y','N') managed,"+
	" coalesce(date_format(CNT_DATE,'%d.%m.%Y'),'') contractdate from rl_propertymaster p left join "+
	" my_area a on p.area=a.doc_no where owid="+cldocno+" order by a.area";
	System.out.println(strprop);
	JSONArray proparray=new JSONArray();
	ResultSet rsproplist=stmt.executeQuery(strprop);
	while(rsproplist.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("unitno",rsproplist.getString("unitno"));
		objtemp.put("accname",rsproplist.getString("accname"));
		objtemp.put("prid",rsproplist.getString("prid"));
		objtemp.put("area",rsproplist.getString("area"));
		objtemp.put("managed",rsproplist.getString("managed"));
		objtemp.put("contractdate",rsproplist.getString("contractdate"));
		proparray.add(objtemp);
	}
	objpolicyno.put("proplistdata",proparray);
	
	String strgetownerac="SELECT ACNO,DESCRIPTION FROM (select ACNO from rl_propertymaster p where owid="+cldocno+"	UNION ALL"+
	" select MRF_ACNO from rl_propertymaster p where owid="+cldocno+") A LEFT JOIN MY_HEAD H ON A.ACNO=H.DOC_NO";
	ResultSet rsgetowneracno=stmt.executeQuery(strgetownerac);
	JSONArray owneracarray=new JSONArray();
	while(rsgetowneracno.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("acno",rsgetowneracno.getString("acno"));
		objtemp.put("desc",rsgetowneracno.getString("description"));
		owneracarray.add(objtemp);
	}
	objpolicyno.put("owneracdata",owneracarray);
	
	String strgetptype="select t.code,count(*) total,sum(if(cnt_no=0,1,0)) vacant,sum(if(cnt_no!=0,1,0)) onhire from rl_propertymaster p left join rl_propertytype t on p.ptype=t.doc_no where OWID="+cldocno+" group by code";
	ResultSet rsgetptype=stmt.executeQuery(strgetptype);
	JSONArray ptypeacarray=new JSONArray();
	while(rsgetptype.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("code",rsgetptype.getString("code"));
		objtemp.put("total",rsgetptype.getString("total"));
		objtemp.put("vacant",rsgetptype.getString("vacant"));
		objtemp.put("onhire",rsgetptype.getString("onhire"));
		ptypeacarray.add(objtemp);
	}
	objpolicyno.put("ptypedata",ptypeacarray);
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(refname+" :: "+mobile+" :: "+email+" :: "+acno+" :: "+pdcinhand+" :: "+subreciept+" :: "+advance+" :: "+balance+" :: "+unapplied+" :: "+total+" :: "+objrenewal+" :: "+objinsurtype+" :: "+objcontactperson+" :: "+objpolicyno+" :: "+objchartdata+" :: "+cldocno);
%>