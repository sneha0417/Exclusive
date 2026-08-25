<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.dashboard.realestate.tenancycontractposting.ClsTenancyContractPostingDAO"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String strgridarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray");
String jvdesc=request.getParameter("jvdesc")==null?"":request.getParameter("jvdesc");
String jvdate=request.getParameter("jvdate")==null?"":request.getParameter("jvdate");
System.out.println("strgridarray:"+strgridarray);
int errorstatus=0;
String errormsg="";
Connection conn=null;
JSONObject objdata=new JSONObject();
String trandetails="";
try{
	ClsTenancyContractPostingDAO postdao=new ClsTenancyContractPostingDAO();
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	java.sql.Date sqljvdate=null;
	if(!jvdate.equalsIgnoreCase("")){
		sqljvdate=objcommon.changeStringtoSqlDate(jvdate);
	}
	String strgetowneracno="select prop.acno owneracno,head.curid ownercurid,head.rate ownercurrate from rl_tncm m left join rl_propertymaster prop "+
	" on (m.prtype=prop.doc_no) left join my_head head on (prop.acno=head.doc_no) where m.doc_no="+docno;
	System.out.println("Owner Details Query:"+strgetowneracno);
	ResultSet rsgetowneracno=stmt.executeQuery(strgetowneracno);
	int owneracno=0;
	int ownercurid=0;
	double ownercurrate=0.0;
	while(rsgetowneracno.next()){
		owneracno=rsgetowneracno.getInt("owneracno");
		ownercurid=rsgetowneracno.getInt("ownercurid");
		ownercurrate=rsgetowneracno.getDouble("ownercurrate");
	}
	ArrayList<String> gridarray=new ArrayList();
	System.out.println("strgridarray:====="+strgridarray.split(",").length);
	for(int i=0;i<strgridarray.split(",").length;i++){
		gridarray.add(strgridarray.split(",")[i]);
	}
	System.out.println("gridarray:====="+gridarray);
	for(int i=0;i<gridarray.size();i++){
		/* desc+"::"+date+"::"+amount+"::"+notes+"::"+paymentmethod+"::"+paidto+"::"+detaildocno */
		String desc=gridarray.get(i).split("::")[0];
		double amount=objcommon.Round(Double.parseDouble(gridarray.get(i).split("::")[2]),2);
		String userdesc=gridarray.get(i).split("::")[7];
		int detaildocno=Integer.parseInt(gridarray.get(i).split("::")[6]);
		String strgetacno="select ct.acno,m.refno,ac.refname,head.curid paymentcurid,head.rate paymentcurrate from rl_tncm m1 left join rl_tncpayment m on (m1.doc_no=m.rdocno) left join rl_terms_contract ct on (m.desc1=ct.description) left "+
		" join my_acbook ac on (m1.cldocno=ac.cldocno and ac.dtype='CRM') left join my_head head on (ct.acno=head.doc_no) where m.rdocno="+docno+" and m.desc1='"+desc+"'";
		System.out.println("Payment Details Query:"+strgetacno);
		int paymentacno=0;
		int paymentrefno=0;
		int paymentcurid=0;
		double paymentcurrate=0.0;
		String tenantname="";
		ResultSet rsgetacno=stmt.executeQuery(strgetacno);
		while(rsgetacno.next()){
			paymentacno=rsgetacno.getInt("acno");
			paymentrefno=rsgetacno.getInt("refno");
			tenantname=rsgetacno.getString("refname");
			paymentcurid=rsgetacno.getInt("paymentcurid");
			paymentcurrate=rsgetacno.getDouble("paymentcurrate");
		}
		if(desc.equalsIgnoreCase("Commission")){
			strgetacno="select head.doc_no paymentacno,head.curid paymentcurid,head.rate paymentcurrate from my_account ac left join my_head head on (ac.acno=head.doc_no) where ac.codeno='COMMISSION ACCOUNT'";
			ResultSet rsgetcomm=stmt.executeQuery(strgetacno);
			while(rsgetcomm.next()){
				paymentacno=rsgetcomm.getInt("paymentacno");
				paymentcurid=rsgetcomm.getInt("paymentcurid");
				paymentcurrate=rsgetcomm.getDouble("paymentcurrate");
			}
		}
		ArrayList<String> journalvouchersarray=new ArrayList();
		//String voucherdesc=jvdesc+" - "+docno+" - "+paymentrefno+" - "+tenantname;
		String voucherdesc=userdesc;
		journalvouchersarray.add(paymentacno+"::"+voucherdesc+"::"+paymentcurid+"::"+paymentcurrate+"::"+amount+"::"+amount*paymentcurrate+"::"+"1"+"::"+"1"+"::0::0::");	
		journalvouchersarray.add(owneracno+"::"+voucherdesc+"::"+ownercurid+"::"+ownercurrate+"::"+amount*-1+"::"+amount*ownercurrate*-1+"::"+"1"+"::"+"-1"+"::0::0::");
		
		/* rows[i].docno+"::"+rows[i].description+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+amount+"::"+baseamount+"::"+rows[i].sr_no+"::"+id+":: "+rows[i].costtype+":: "+rows[i].costcode */
		System.out.println("=== "+journalvouchersarray);
		int jvidentfyingid=0;
		String strjvidentity="select jvid from my_jvidentifyingid where menu_name='Owner Payment Settlement'";
		ResultSet rsjvidentity=stmt.executeQuery(strjvidentity);
		while(rsjvidentity.next()){
			jvidentfyingid=rsjvidentity.getInt("jvid");
		}
		int jvvalue=postdao.insertjv(conn, sqljvdate, "JVT-"+jvidentfyingid, docno, voucherdesc, amount, amount, journalvouchersarray,session, request);
		if(jvvalue<=0){
			System.out.println("Jv Insert Error");
			errorstatus=1;
			break;
		}
		else{
			errormsg="JVT #"+jvvalue;
			int trno=Integer.parseInt(request.getAttribute("tranno2").toString());
			String strupdatejv="update my_jvtran set rdocno="+docno+",rtype='TNC' where tr_no="+trno;
			System.out.println("Update JV Query:"+strupdatejv);
			int updatejv=stmt.executeUpdate(strupdatejv);
			if(updatejv<=0){
				errorstatus=1;
				System.out.println("Jv Update Error");
				break;
			}
			String strupdatepayment="update rl_tncpayment set ownerpytsettletrno="+trno+" where doc_no="+detaildocno;
			System.out.println("Update Payment Query:"+strupdatepayment);
			int updatepayment=stmt.executeUpdate(strupdatepayment);
			if(updatepayment<=0){
				errorstatus=1;
				break;
			}
		}
	}
	//objdata.put("ownerpyttrno",trandetails);
	if(errorstatus==0){
		conn.commit();
	}
	else{
		errormsg="0";
	}
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"::"+errormsg);
%>