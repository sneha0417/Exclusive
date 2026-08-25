<%@page import="java.util.ArrayList"%>
<%@page import="com.dashboard.realestate.tenancycontractposting.ClsTenancyContractPostingDAO"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String rentalamt=request.getParameter("rentalamt")==null?"":request.getParameter("rentalamt");
String mgmtamt=request.getParameter("mgmtamt")==null?"":request.getParameter("mgmtamt");
String paymentdesc=request.getParameter("paymentdesc")==null?"":request.getParameter("paymentdesc");
String detaildocno=request.getParameter("detaildocno")==null?"":request.getParameter("detaildocno");
String fromchkdate=request.getParameter("from")==null?"":request.getParameter("from");
String tochkdate=request.getParameter("to")==null?"":request.getParameter("to");
Connection conn=null;
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
ClsTenancyContractPostingDAO invdao=new ClsTenancyContractPostingDAO();
int errorstatus=0;
String errormsg="";
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	String invtype="";
	
	java.sql.Date sqlcontractfromchkdate=null,sqlcontracttochkdate=null;
	if(!fromchkdate.equalsIgnoreCase("") && fromchkdate!=null && !fromchkdate.equalsIgnoreCase("undefined")){
		sqlcontractfromchkdate=objcommon.changeStringtoSqlDate(fromchkdate);
	}
	
	if(!tochkdate.equalsIgnoreCase("") && tochkdate!=null && !tochkdate.equalsIgnoreCase("undefined")){
		sqlcontracttochkdate=objcommon.changeStringtoSqlDate(tochkdate);
	}
	
	
	System.out.println("=====fromdate==="+sqlcontractfromchkdate+"=====todate===="+sqlcontracttochkdate);
	
	if(Double.parseDouble(rentalamt)>0.0){
		invtype="RENT";
	}
	if(Double.parseDouble(mgmtamt)>0.0){
		invtype="MGMT";
	}
	String strmisc="select curdate() basedate";
	java.sql.Date sqlbasedate=null;
	ResultSet rsmisc=stmt.executeQuery(strmisc);
	while(rsmisc.next()){
		sqlbasedate=rsmisc.getDate("basedate");
	}
	String strrentalvalueacno="select acno from rl_terms_contract where description='rental value'";
	int rentalvalueacno=0;
	ResultSet rsrentalvalue=stmt.executeQuery(strrentalvalueacno);
	while(rsrentalvalue.next()){
		rentalvalueacno=rsrentalvalue.getInt("acno");
	}
   String strgetmasterdata="select chkvatdistributed from rl_tncm where doc_no="+docno;
   int chkvatdistributed=0;
   ResultSet rsgetmasterdata=stmt.executeQuery(strgetmasterdata);
   while(rsgetmasterdata.next()){
	   chkvatdistributed=rsgetmasterdata.getInt("chkvatdistributed");
   }
	int brhid=0,curId=1;
    int cldocno=0,acno=0;
    String atype="AR",desc1="",invdate="";
    double taxper=0,rate=1;
    int voc_no=0;
	String remarks="";
	int clacno=0;
	int clcurId=1;
	int clienttax=0;
	double clrate=1;
	java.sql.Date cdate=null;
	java.sql.Date dates=null;
	java.sql.Date podates=null;
	String clientname="",clienttrn="";
	String mastersql="  select a.trnnumber,a.tax clienttax,curdate() cudate,  m.brhid,date_format(m.date,'%d.%m.%Y') invdate,coalesce(t.per,0) per,m.voc_no,h.curid,h.rate, h.atype, "
	+ "   m.date,m.ttype,m.acno ,  m.cldocno,a.refname,concat(pm.name,'-',m.voc_no) description, m.prtype, m.Period, "
	+ "  m.Period_no, m.Period_from, m.Period_to, m.not_Period  "
	+ " from rl_tncm  m  left join rl_propertymaster pm on pm.doc_no=m.prtype "
	+ " left join my_acbook a on a.acno=m.acno left join my_head h on h.doc_no=m.acno  "
	+" left join gl_taxmaster t on t.type=2 and per>0 and m.date between t.fromdate "
	+ "   and t.todate and a.tax=1 and m.ttype=2  where m.status=3 and m.doc_no='"+docno+"'";
	
	System.out.println("==mastersql="+mastersql);
				
	ResultSet rsmatersel=stmt.executeQuery(mastersql);
	if(rsmatersel.next())
	{				
		brhid=rsmatersel.getInt("brhid");
		cldocno=rsmatersel.getInt("cldocno");
		voc_no=rsmatersel.getInt("voc_no");
		/* dates=rsmatersel.getDate("date");
		cdate=rsmatersel.getDate("cudate"); */
		taxper=rsmatersel.getDouble("per");				
		desc1=rsmatersel.getString("description");				 
		atype=rsmatersel.getString("atype");				
		rate=rsmatersel.getDouble("rate");				 
		curId=rsmatersel.getInt("curid");	
		acno=rsmatersel.getInt("acno");	
		invdate=rsmatersel.getString("invdate");				
		clacno=rsmatersel.getInt("acno");	
		clcurId=rsmatersel.getInt("curid");	
		clrate=rsmatersel.getDouble("rate");					 
		remarks=desc1;			
		clienttax=rsmatersel.getInt("clienttax");
		clientname=rsmatersel.getString("refname");
		clienttrn=rsmatersel.getString("trnnumber");
	}
	if(clcurId==0){clcurId=1;	}
	if(clrate==0){clrate=1;	}
	ArrayList<String> masterarray=new ArrayList();
	ArrayList<String> agentarray=new ArrayList();
	String paymentcode="";
	if(paymentdesc.equalsIgnoreCase("Rental Value") || paymentdesc.equalsIgnoreCase("Rent Value") || paymentdesc.equalsIgnoreCase("Rent"))
	{
		paymentcode="RV";
	}
	else if(paymentdesc.equalsIgnoreCase("Security deposit"))
	{
		paymentcode="SD";
	}
	else if(paymentdesc.equalsIgnoreCase("Electricity"))
	{
		paymentcode="ELEC";
	}
	else if(paymentdesc.equalsIgnoreCase("GAS"))
	{
		paymentcode="GAS";
	}
	else if(paymentdesc.equalsIgnoreCase("Chiller"))
	{
		paymentcode="CHL";
	}
	else if(paymentdesc.equalsIgnoreCase("Admin Fee"))
	{
		paymentcode="AF";
	}
	else if(paymentdesc.equalsIgnoreCase("Ejari"))
	{
		paymentcode="EJR";
	}
	else if(paymentdesc.equalsIgnoreCase("Others"))
	{
		paymentcode="OTH";
	}
	else
	{
		if(invtype.equalsIgnoreCase("MGMT")){
			paymentcode=invtype;
		}
	}
	
	String strloginsert="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+brhid+"','BMFI',now(),'"+session.getAttribute("USERID").toString()+"','A')";
    System.out.println("Log Insert: "+strloginsert);
	int loginsert= stmt.executeUpdate(strloginsert);	
	if(loginsert<=0){
		errorstatus=1;
	}
	int owacno=0;
    int owcurId=1;
    double owrate=1;
				
	String sqlval1="select  h.curid,h.rate, h.atype ,o.acno from rl_tncm  m   "
			+ "  left join rl_propertymaster pm on pm.doc_no=m.prtype left join rl_propertryowner o on o.doc_no=pm.owid "
			+ "  left join my_head h on h.doc_no=o.acno  "
			+ " where m.status=3  and m.doc_no='"+docno+"'  group by m.doc_no ";	
	System.out.println("==sqlval1="+sqlval1);
	ResultSet  rsmatersel11=stmt.executeQuery(sqlval1);
	if(rsmatersel11.first())
	{
		owrate=rsmatersel11.getInt("rate");	
			owcurId=rsmatersel11.getInt("curid");	
	    owacno=rsmatersel11.getInt("acno");	
	}
	int clstat=0;
	int ttypechk=0;
	String owneractype="";
	String ownername="";
	String ownertrn="";
	String propname="";
	String contractfromdate="",contracttodate="";
	int ownertax=0;
	String griddescription="";
	String tenantname="";
	String strgetowneracno="select m.clstatus,m.ttype,coalesce(tn.refname,'') tenantname,coalesce(date_format(m.period_from,'%d.%m.%Y'),'') contractfromdate,coalesce(date_format(m.period_to,'%d.%m.%Y'),'') contracttodate,coalesce(pm.accname,'') propname,ac.refname,coalesce(ac.trnnumber,'') ownertrn,ac.tax ownertax,pm.acno,"+
	" ownerhead.atype,ownerhead.description from rl_tncm m left join rl_propertymaster pm on pm.doc_no=m.prtype left join my_head ownerhead on "+
	" pm.acno=ownerhead.doc_no left join my_acbook ac on (ownerhead.doc_no=ac.acno) left join my_acbook tn on (m.cldocno=tn.cldocno and tn.dtype='CRM') where m.status=3 and m.doc_no="+docno;
	ResultSet rsgetowneracno=stmt.executeQuery(strgetowneracno);
	while(rsgetowneracno.next()){
		clstat=rsgetowneracno.getInt("clstatus");
		ttypechk=rsgetowneracno.getInt("ttype");
		owacno=rsgetowneracno.getInt("acno");
		owneractype=rsgetowneracno.getString("atype");
		ownername=rsgetowneracno.getString("refname");
		ownertrn=rsgetowneracno.getString("ownertrn");
		ownertax=rsgetowneracno.getInt("ownertax");
		propname=rsgetowneracno.getString("propname");
		contractfromdate=rsgetowneracno.getString("contractfromdate");
		contracttodate=rsgetowneracno.getString("contracttodate");
		tenantname=rsgetowneracno.getString("tenantname");
	}
	java.sql.Date sqlcontractfromdate=null,sqlcontracttodate=null;
	if(!contractfromdate.equalsIgnoreCase("") && contractfromdate!=null && !contractfromdate.equalsIgnoreCase("undefined")){
		sqlcontractfromdate=objcommon.changeStringtoSqlDate(contractfromdate);
	}
	if(!contracttodate.equalsIgnoreCase("") && contracttodate!=null && !contracttodate.equalsIgnoreCase("undefined")){
		sqlcontracttodate=objcommon.changeStringtoSqlDate(contracttodate);
	}
	
	
	
	
	
	griddescription="TA - "+docno+" - "+tenantname+" - "+propname+" - "+contractfromdate+" to "+contracttodate;
	String propertydesc="";
	double propertyinvoicetotal=0.0;
	int value=0;
	if(invtype.equalsIgnoreCase("RENT")){
		propertydesc=propname+" - "+paymentcode+" :"+rentalamt;
		propertyinvoicetotal=Double.parseDouble(rentalamt);
		String strgetfirstinstallment="select (select taxtype from rl_tncterms where rdocno="+docno+" and slno=1) taxtype,(select pamount from rl_tncpayment where  rdocno="+docno+" and slno=1 and desc1='Rental Value') installment,(select paidto from rl_tncpayment where  rdocno="+docno+" and slno=1 and desc1='Rental Value') firstpaidto";
		ResultSet rsgetfirstinstallment=stmt.executeQuery(strgetfirstinstallment);
		String rentaltaxtype="";
		double firstinstallment=0.0;
		String firstpaidto="";
		while(rsgetfirstinstallment.next()){
			rentaltaxtype=rsgetfirstinstallment.getString("taxtype");
			firstinstallment=rsgetfirstinstallment.getDouble("installment");
			firstpaidto=rsgetfirstinstallment.getString("firstpaidto");
		}
		if(ttypechk==3)
		{
			double nrmltaxamt=0.0;
			double nrmlamt=0.0;
			if(clienttax>0){
				nrmltaxamt=Double.parseDouble(rentalamt);
				nrmltaxamt=(nrmltaxamt/100)*5;
				nrmlamt=Double.parseDouble(rentalamt);
				nrmlamt=nrmlamt-nrmltaxamt;
				nrmltaxamt=objcommon.Round(nrmltaxamt, 2);
				nrmlamt=objcommon.Round(nrmlamt,2);
			}
			else{
				nrmlamt=objcommon.Round(Double.parseDouble(rentalamt),2);
			}
			System.out.println("Normal==nrmltaxamt="+nrmltaxamt+"==nrmlamt=="+nrmlamt+"==clienttax=="+clienttax);
	 		if(chkvatdistributed==0){
				masterarray.add(1+"::"+1+" :: "+paymentdesc+" :: "
					+nrmlamt+" :: "+nrmlamt+" :: "+0+" :: "+nrmlamt+" :: "
					+(nrmltaxamt>0.0?5.0:0.0)+" :: "+objcommon.Round(nrmltaxamt,2)+" :: "+objcommon.Round(Double.parseDouble(rentalamt),2)+" :: "+nrmlamt+" :: "
					+0+" :: "+0+" :: "+griddescription+" :: "+(rentalvalueacno)+" :: "+0+" :: ");							
			}
			else{
				if(rentaltaxtype.equalsIgnoreCase("Inclusive")){
					double inclusiveamt=(Double.parseDouble(rentalamt)/105)*100;
					double installmenttaxamt=Double.parseDouble(rentalamt)-inclusiveamt;
					inclusiveamt=objcommon.Round(inclusiveamt,2);
					installmenttaxamt=objcommon.Round(installmenttaxamt, 2);
					System.out.println("Inclusive==installmenttaxamt="+installmenttaxamt+"==inclusiveamt=="+inclusiveamt);
					masterarray.add(1+"::"+1+" :: "+paymentdesc+" :: "
							+objcommon.Round(inclusiveamt,2)+" :: "+objcommon.Round(inclusiveamt,2)+" :: "+0+" :: "+objcommon.Round(inclusiveamt,2)+" :: "
							+(installmenttaxamt>0.0?5.0:0.0)+" :: "+objcommon.Round(installmenttaxamt,2)+" :: "+objcommon.Round(Double.parseDouble(rentalamt),2)+" :: "+objcommon.Round(inclusiveamt,2)+" :: "
							+0+" :: "+0+" :: "+griddescription+" :: "+(rentalvalueacno)+" :: "+0+" :: ");		
				}
				else if(rentaltaxtype.equalsIgnoreCase("Exclusive")){
					double installmenttaxamt=(Double.parseDouble(rentalamt)/100)*5;
					double exclusiveamt=Double.parseDouble(rentalamt)-installmenttaxamt;
					installmenttaxamt=objcommon.Round(installmenttaxamt, 2);
					exclusiveamt=objcommon.Round(exclusiveamt,2);
					System.out.println("Exclusive==installmenttaxamt="+installmenttaxamt+"==exclusiveamt=="+exclusiveamt);
					masterarray.add(1+"::"+1+" :: "+paymentdesc+" :: "
							+objcommon.Round(exclusiveamt,2)+" :: "+objcommon.Round(exclusiveamt,2)+" :: "+0+" :: "+objcommon.Round(exclusiveamt,2)+" :: "
							+(installmenttaxamt>0.0?5.0:0.0)+" :: "+objcommon.Round(installmenttaxamt,2)+" :: "+objcommon.Round(Double.parseDouble(rentalamt),2)+" :: "+objcommon.Round(exclusiveamt,2)+" :: "
							+0+" :: "+0+" :: "+griddescription+" :: "+(rentalvalueacno)+" :: "+0+" :: ");		
	
				}
				else{
					masterarray.add(1+"::"+1+" :: "+paymentdesc+" :: "
							+nrmlamt+" :: "+nrmlamt+" :: "+0+" :: "+nrmlamt+" :: "
							+(nrmltaxamt>0.0?5.0:0.0)+" :: "+objcommon.Round(nrmltaxamt,2)+" :: "+objcommon.Round(Double.parseDouble(rentalamt),2)+" :: "+nrmlamt+" :: "
							+0+" :: "+0+" :: "+griddescription+" :: "+(rentalvalueacno)+" :: "+0+" :: ");		
	
				}
			}
			
			String sqlchknw="select * from rl_tncm where doc_no="+docno+" and invdate is not null";
			ResultSet rstnwchk=stmt.executeQuery(sqlchknw);
			if(rstnwchk.next())
			{
				String dtmdfy="select date_add(last_day('"+sqlcontractfromchkdate+"'),interval 1 day)modifyddate ";
				ResultSet rstdtmdfy=stmt.executeQuery(dtmdfy);
				if(rstdtmdfy.next())
				{
					sqlcontractfromchkdate=rstdtmdfy.getDate("modifyddate");
				}
			}
			
			value=invdao.insertPropertyInvoice(sqlcontracttochkdate,sqlbasedate, "TNC", docno, atype, clacno+"", clientname, curId+"", rate+"", "", "", propertydesc, 
					session, "A", objcommon.Round(propertyinvoicetotal,2) , masterarray, "PRIV", request, null, "", "", 0, clienttax>0?5.0:0.0, clientname, clienttrn, agentarray, 3,conn,propname,ownername,sqlcontractfromchkdate,sqlcontracttochkdate,objcommon.Round(propertyinvoicetotal,2)+"");
		if(value>0){
			String sqlupdt="update rl_tncm set invdate='"+sqlcontracttochkdate+"',invtodate=last_day(date_add('"+sqlcontracttochkdate+"',interval 1 day)) where doc_no="+docno+"";
			System.out.println("=====update rl_tncm==="+sqlupdt);
			int updval=stmt.executeUpdate(sqlupdt);
			System.out.println("=====updval rl_tncm==="+updval);
			
			String sqlchk="select * from rl_tncclose where contractno="+docno+" and prinv=0";
			ResultSet rstnw=stmt.executeQuery(sqlchk);
			if(rstnw.next())
			{
				String sqlupdt2="update rl_tncclose set prinv="+value+" where contractno="+docno+"";
				System.out.println("=====update rl_tncclose==="+sqlupdt2);
				int updval2=stmt.executeUpdate(sqlupdt2);
				System.out.println("=====updval rl_tncclose==="+updval2);
			}
		} 
		}
		else{
			if(chkvatdistributed==0){
				masterarray.add(1+"::"+1+" :: "+paymentdesc+" :: "
					+objcommon.Round(Double.parseDouble(rentalamt),2)+" :: "+objcommon.Round(Double.parseDouble(rentalamt),2)+" :: "+0+" :: "+objcommon.Round(Double.parseDouble(rentalamt),2)+" :: "
					+(0.0)+" :: "+objcommon.Round(0.0,2)+" :: "+objcommon.Round(Double.parseDouble(rentalamt),2)+" :: "+objcommon.Round(Double.parseDouble(rentalamt),2)+" :: "
					+0+" :: "+0+" :: "+griddescription+" :: "+(owacno)+" :: "+0+" :: ");							
			}
			else{
				if(rentaltaxtype.equalsIgnoreCase("Inclusive")){
					double inclusiveamt=(Double.parseDouble(rentalamt)/105)*100;
					double installmenttaxamt=Double.parseDouble(rentalamt)-inclusiveamt;
					inclusiveamt=objcommon.Round(inclusiveamt,2);
					installmenttaxamt=objcommon.Round(installmenttaxamt, 2);
					masterarray.add(1+"::"+1+" :: "+paymentdesc+" :: "
							+objcommon.Round(inclusiveamt,2)+" :: "+objcommon.Round(inclusiveamt,2)+" :: "+0+" :: "+objcommon.Round(inclusiveamt,2)+" :: "
							+(installmenttaxamt>0.0?5.0:0.0)+" :: "+objcommon.Round(installmenttaxamt,2)+" :: "+objcommon.Round(Double.parseDouble(rentalamt),2)+" :: "+objcommon.Round(inclusiveamt,2)+" :: "
							+0+" :: "+0+" :: "+griddescription+" :: "+(owacno)+" :: "+0+" :: ");		
				}
				else if(rentaltaxtype.equalsIgnoreCase("Exclusive")){
					double installmenttaxamt=Double.parseDouble(rentalamt)*(5/100);
					double exclusiveamt=Double.parseDouble(rentalamt)-installmenttaxamt;
					installmenttaxamt=objcommon.Round(installmenttaxamt, 2);
					exclusiveamt=objcommon.Round(exclusiveamt,2);
					masterarray.add(1+"::"+1+" :: "+paymentdesc+" :: "
							+objcommon.Round(exclusiveamt,2)+" :: "+objcommon.Round(exclusiveamt,2)+" :: "+0+" :: "+objcommon.Round(exclusiveamt,2)+" :: "
							+(installmenttaxamt>0.0?5.0:0.0)+" :: "+objcommon.Round(installmenttaxamt,2)+" :: "+objcommon.Round(Double.parseDouble(rentalamt),2)+" :: "+objcommon.Round(exclusiveamt,2)+" :: "
							+0+" :: "+0+" :: "+griddescription+" :: "+(owacno)+" :: "+0+" :: ");		
	
				}
				else{
					masterarray.add(1+"::"+1+" :: "+paymentdesc+" :: "
							+objcommon.Round(Double.parseDouble(rentalamt),2)+" :: "+objcommon.Round(Double.parseDouble(rentalamt),2)+" :: "+0+" :: "+objcommon.Round(Double.parseDouble(rentalamt),2)+" :: "
							+(0.0)+" :: "+objcommon.Round(0.0,2)+" :: "+objcommon.Round(Double.parseDouble(rentalamt),2)+" :: "+objcommon.Round(Double.parseDouble(rentalamt),2)+" :: "
							+0+" :: "+0+" :: "+griddescription+" :: "+(owacno)+" :: "+0+" :: ");		
	
				}
			}
			
			
			
			value=invdao.insertPropertyInvoice(sqlbasedate,sqlbasedate, "TNC", docno, atype, clacno+"", clientname, curId+"", rate+"", "", "", propertydesc, 
					session, "A", objcommon.Round(propertyinvoicetotal,2) , masterarray, "PRIV", request, null, "", "", 0, clienttax>0?5.0:0.0, clientname, clienttrn, agentarray, 3,conn,propname,ownername,sqlcontractfromdate,sqlcontracttodate,objcommon.Round(propertyinvoicetotal,2)+"");
		
			
		}
		

	}
	if(invtype.equalsIgnoreCase("MGMT")){
		propertydesc=propname+" - "+paymentcode+" :"+mgmtamt;
		propertyinvoicetotal=Double.parseDouble(mgmtamt);
		double adminfee=0.00;
		double mgmtvatvalue=0.0;
		String mgmtvattype="";
		Double mgmtnettotal=0.0;
		String qry1="select mgmttaxtotal,managementamt,owneradminfee,mgmtvattype from rl_tncm where doc_no='"+docno+"' ";
		System.out.println("=====qry1==="+qry1);			
		ResultSet rst=stmt.executeQuery(qry1);
		if(rst.first())
		{
			mgmtnettotal=rst.getDouble("mgmttaxtotal");
			//mgmtvatvalue=rst.getDouble("mgmtvatvalue");
			mgmtvattype=rst.getString("mgmtvattype");
			adminfee=rst.getDouble("owneradminfee");
		}
		int mgmtfeedocno=Integer.parseInt(detaildocno);
		int adfeeacno=0;
		int mgmtfeeacno=0;
		String strmgmtfeeacno="select acno from my_account where codeno='PROPERTYMGMTFEE' ";
		System.out.println(strmgmtfeeacno);
		ResultSet rsmgmtfeeacno=stmt.executeQuery(strmgmtfeeacno);						 
		if(rsmgmtfeeacno.first()){
			mgmtfeeacno=rsmgmtfeeacno.getInt("acno");
		}
		double mgmttaxamount=0.0;
		double mgmtamount=0.0;
		mgmtnettotal=0.0;
		if(mgmtvattype.equalsIgnoreCase("Inclusive")){
			double inclusiveamtmgmt=(Double.parseDouble(mgmtamt)/105)*100;
			mgmttaxamount=Double.parseDouble(mgmtamt)-inclusiveamtmgmt;
			mgmttaxamount=objcommon.Round(mgmttaxamount, 2);
			mgmtamount=Double.parseDouble(mgmtamt)-mgmttaxamount;
			mgmtamount=objcommon.Round(mgmtamount, 2);
			
			masterarray.add((1)+"::"+1+" :: "+paymentdesc+" :: "+mgmtamount+" :: "+mgmtamount+" :: "+0+" :: "+mgmtamount+" :: "+5+" :: "+mgmttaxamount+" :: "+mgmtamt+" :: "+mgmtamount+" :: "+0+" :: "+0+"  :: "+griddescription+" :: "+mgmtfeeacno+" :: "+0+" :: ");	
		}
		else if(mgmtvattype.equalsIgnoreCase("Exclusive")){
			System.out.println("Mgmt Amt:"+mgmtamt);
			mgmttaxamount=Double.parseDouble(mgmtamt)*0.05;
			System.out.println("Mgmt Tax Amount:"+mgmttaxamount);
			mgmttaxamount=objcommon.Round(mgmttaxamount, 2);
			System.out.println("Mgmt Tax Amount After Round:"+mgmttaxamount);
			mgmtamount=Double.parseDouble(mgmtamt)+mgmttaxamount;
			mgmtamount=objcommon.Round(mgmtamount, 2);
			System.out.println(mgmtamt+"::"+mgmttaxamount+"::"+mgmtamount);
			masterarray.add(1+"::"+1+" :: "+paymentdesc+" :: "+mgmtamt+" :: "+mgmtamt+" :: "+0+" :: "+mgmtamt+" :: "+5+" :: "+mgmttaxamount+" :: "+mgmtamount+" :: "+mgmtamt+" :: "+0+" :: "+0+"  :: "+griddescription+" :: "+mgmtfeeacno+" :: "+0+" :: ");	
		}
		value=invdao.insertPropertyInvoice(sqlbasedate, sqlbasedate, "TNC", docno, owneractype, owacno+"", ownername, curId+"", rate+"", "", "", propertydesc, session, "A",objcommon.Round(propertyinvoicetotal,2), masterarray, "PRIV", request, null, "", "", 0, ownertax>0?5.0:0.0, ownername, ownertrn, agentarray, 3,conn,propname,ownername,sqlcontractfromdate,sqlcontracttodate,objcommon.Round(propertyinvoicetotal,2)+"");
		
	}
	System.out.println(masterarray.get(0));
	if(value<=0){
		errorstatus=1;
	}
	else{
		if(invtype.equalsIgnoreCase("RENT")){
			int ttype=0;
			String sqlrent="select ttype from rl_tncm where doc_no="+docno+"";
			System.out.println("rl_tncm ttype ftch=="+sqlrent);
			ResultSet rsrent=stmt.executeQuery(sqlrent);						 
			if(rsrent.next()){
				ttype=rsrent.getInt("ttype");
			}
			if(ttype>0 && ttype<3){
				String strupdatepyt="update rl_tncpayment set privdocno="+value+" where rdocno="+docno+" and doc_no="+detaildocno;
				int updatepyt=stmt.executeUpdate(strupdatepyt);
				if(updatepyt<=0){
					errorstatus=1;
					System.out.println("Update Payment Inv Value Error");
				}
			}
		}
		else if(invtype.equalsIgnoreCase("MGMT")){
			String strupdateadminfee="update rl_tncmanagefee set privdocno="+value+" where id="+detaildocno;
			System.out.println(strupdateadminfee);
			int updateadminfee=stmt.executeUpdate(strupdateadminfee);
			if(updateadminfee<=0){
				errorstatus=1;
			}	
		}
		String strgetvocno2="select voc_no from rl_prinvm where doc_no="+value;
		System.out.println("strgetvocno2  == "+strgetvocno2);
		ResultSet rsgetvocno2=stmt.executeQuery(strgetvocno2);
		String privvocno2="";
		while(rsgetvocno2.next()){
			privvocno2=rsgetvocno2.getString("voc_no");
		}
		if(errormsg.equalsIgnoreCase("")){
			errormsg="PRIV #"+privvocno2;
		}
		else{
			errormsg=errormsg+","+privvocno2;
		}
	}
	if(errorstatus==0){
		errormsg="Successfully Generated "+errormsg;
		conn.commit();
	}
	else{
		errormsg="Not Updated";
	}
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
	response.getWriter().write(errorstatus+"::"+"Not Updated");
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"::"+errormsg);
%>