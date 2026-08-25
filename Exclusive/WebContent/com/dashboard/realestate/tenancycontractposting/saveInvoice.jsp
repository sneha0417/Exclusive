<%@page import="com.realestate.propertyinvoice.ClsPropertyInvoiceDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.common.*"%>
<%@page import="com.finance.transactions.cashreceipt.*"%>
<%@page import="com.finance.transactions.bankreceipt.*"%>
<%@page import="com.finance.transactions.journalvouchers.ClsJournalVouchersDAO"%> 
<%@page import="com.dashboard.realestate.tenancycontractposting.ClsTenancyContractPostingDAO"%>

<%	
	String docno=request.getParameter("docno");
	String branchids=request.getParameter("branchids");
	String podate=request.getParameter("podate");
	int errorstatus=0;
	String errormsg="";
	JSONObject objmsg=new JSONObject();
	JSONArray msgarray=new JSONArray();
	ArrayList<String> invdocarray=new ArrayList();
	String ardesc=request.getParameter("ardesc")==null?"":request.getParameter("ardesc");
	String apdesc=request.getParameter("apdesc")==null?"0":request.getParameter("apdesc");
	String list=request.getParameter("listss")==null?"0":request.getParameter("listss");
	String list1=request.getParameter("listss1")==null?"0":request.getParameter("listss1");
	String stragentarray=request.getParameter("agentarray")==null?"":request.getParameter("agentarray");
	ArrayList<String> agentarray=new ArrayList();
	if(!stragentarray.equalsIgnoreCase("")){
		for(int i=0;i<stragentarray.split(",").length;i++){
			agentarray.add(stragentarray.split(",")[i]);
		}
	}
	//System.out.println("==list="+list);
	//System.out.println("==list1="+list1);
	int redirectinvvalue=0;
	String stragentjvdesc="";
	ClsJournalVouchersDAO journalVouchersDAO= new ClsJournalVouchersDAO();
	ClsPropertyInvoiceDAO propertyinvdao= new ClsPropertyInvoiceDAO(); 
	ClsCashReceiptDAO cashReceiptDAO=new ClsCashReceiptDAO();
	ClsBankReceiptDAO bankReceiptDAO=new ClsBankReceiptDAO();
	ClsCommon objcommon=new ClsCommon();
	ClsTenancyContractPostingDAO save = new ClsTenancyContractPostingDAO();
	String refrowno="0";
	Connection conn=null;
	 
	try{
		ClsConnection ClsConnection =new ClsConnection();
		ClsCommon ClsCommon=new ClsCommon();
		java.sql.Date sqlprocessdate=null;

		ArrayList<String> blankarray=new ArrayList();
		String upsql=null;
		int val=0;
		int id1=0;
		int id2=0;
		int id3=0;
		int propmanage=0;
		conn = ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		double ownertotal=0.0;
		double selftotal=0.0;
		Statement stmt = conn.createStatement ();
		int docval=0;
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
		
		int redirectbrhid=0;//For Redirecting invoices to specific branches
		
	   if(!(podate.equalsIgnoreCase("undefined"))&&!(podate.equalsIgnoreCase(""))&&!(podate.equalsIgnoreCase("0")))
		{
		   cdate=ClsCommon.changeStringtoSqlDate(podate);
		   dates=ClsCommon.changeStringtoSqlDate(podate);
		} else{}
	    double gltax=0.00;
		String sqltax = "select per from gl_taxmaster where  status=3 and type=2 and '"+cdate+"' between fromdate and todate and per>0;";
		System.out.println("sqltax7====>"+sqltax);
		ResultSet rstax = stmt.executeQuery(sqltax);
	   	while(rstax.next()){
	   		gltax = rstax.getDouble("per");
	   	}
	   	String strrentalvalueacno="select acno from rl_terms_contract where description='rental value'";
		int rentalvalueacno=0;
		ResultSet rsrentalvalue=stmt.executeQuery(strrentalvalueacno);
		while(rsrentalvalue.next()){
			rentalvalueacno=rsrentalvalue.getInt("acno");
		}
	   String strgetmasterdata="select chkvatdistributed,ttype from rl_tncm where doc_no="+docno;
	   int chkvatdistributed = 0, conttype = 0 ,tnccommericaltax=0;
	   ResultSet rsgetmasterdata=stmt.executeQuery(strgetmasterdata);
	   while(rsgetmasterdata.next()){
		   chkvatdistributed = rsgetmasterdata.getInt("chkvatdistributed");
		   conttype = rsgetmasterdata.getInt("ttype");   
	   }
	   String strsql="select method from gl_config where field_nme='tnccommericaltax'";
		System.out.println("strsql1="+strsql);
		ResultSet rs=stmt.executeQuery(strsql);
		while(rs.next()){
			tnccommericaltax=rs.getInt("method");
		}
	   //System.out.println(gltax+"conttype====>"+conttype);
	   //System.out.println("==tnccommericaltax1="+tnccommericaltax);
	   
	   if(tnccommericaltax != 1){
		  // System.out.println("==tnccommericaltax2="+tnccommericaltax);
		   if(conttype != 2){     
			   gltax = 0;
		   }    
	   }
		String mastersql="  select br.redirectbrhid,pm.mgprpty propmanage,a.trnnumber,a.tax clienttax,curdate() cudate,  m.brhid,date_format(m.date,'%d.%m.%Y') invdate,coalesce(t.per,0) per,m.voc_no,h.curid,h.rate, h.atype, "
			+ "   m.date,m.ttype,m.acno ,  m.cldocno,replace(a.refname, '\\'', '')refname,concat(pm.name,'-',m.voc_no) description, m.prtype, m.Period, "
			+ "  m.Period_no, m.Period_from, m.Period_to, m.not_Period  "
			+ " from rl_tncm  m  left join rl_propertymaster pm on pm.doc_no=m.prtype "
			+ " left join my_acbook a on a.acno=m.acno left join my_head h on h.doc_no=m.acno  "
			+" left join gl_taxmaster t on t.type=2 and per>0 and m.date between t.fromdate "
			+ "   and t.todate and a.tax=1 and m.ttype=2 left join my_brch br on m.brhid=br.doc_no where m.status=3 and m.doc_no='"+docno+"'";
			
			//System.out.println("==mastersql="+mastersql);
			ResultSet rsmatersel=stmt.executeQuery(mastersql);
			if(rsmatersel.next())
			{				
				redirectbrhid=rsmatersel.getInt("redirectbrhid");
				brhid=rsmatersel.getInt("brhid");
				cldocno=rsmatersel.getInt("cldocno");
				voc_no=rsmatersel.getInt("voc_no");
				propmanage=rsmatersel.getInt("propmanage");
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
					 
	    upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+brhid+"','BTNC',now(),'"+session.getAttribute("USERID").toString()+"','A')";
	    //System.out.println("==upsql="+upsql);
		int aaa= stmt.executeUpdate(upsql);	
		  
	    int owacno=0;
	    int owcurId=1;
	    double owrate=1;
					
		String sqlval="select  h.curid,h.rate, h.atype ,o.acno from rl_tncm  m   "
				+ "  left join rl_propertymaster pm on pm.doc_no=m.prtype left join rl_propertryowner o on o.doc_no=pm.owid "
				+ "  left join my_head h on h.doc_no=o.acno  "
				+ " where m.status=3  and m.doc_no='"+docno+"' and pm.mgprpty=1  group by m.doc_no ";	
		//System.out.println("==sqlval="+sqlval);
		ResultSet  rsmatersel1=stmt.executeQuery(sqlval);
		if(rsmatersel1.first())
		{ 
			//atype=rsmatersel1.getString("atype");			
			rate=rsmatersel1.getInt("rate");			 
			curId=rsmatersel1.getInt("curid");	
			acno=rsmatersel1.getInt("acno");				
		}					
		
		if(rate==0){rate=1;	}
		if(curId==0){curId=1;	}					
					
		String sqlval1="select  h.curid,h.rate, h.atype ,o.acno from rl_tncm  m   "
				+ "  left join rl_propertymaster pm on pm.doc_no=m.prtype left join rl_propertryowner o on o.doc_no=pm.owid "
				+ "  left join my_head h on h.doc_no=o.acno  "
				+ " where m.status=3  and m.doc_no='"+docno+"'  group by m.doc_no ";	
		//System.out.println("==sqlval1="+sqlval1);
		ResultSet  rsmatersel11=stmt.executeQuery(sqlval1);
		if(rsmatersel11.first())
		{
			owrate=rsmatersel11.getInt("rate");	
 			owcurId=rsmatersel11.getInt("curid");	
		    owacno=rsmatersel11.getInt("acno");	
		}
		String owneractype="";
		String ownername="";
		String ownertrn="";
		String propname="";
		String contractfromdate="",contracttodate="";
		int ownertax=0;
		String griddescription="";
		String tenantname="";
		String strgetowneracno="select coalesce(own.primary_owner,'') ownername,coalesce(tn.refname,'') tenantname,coalesce(date_format(m.period_from,'%d.%m.%Y'),'') contractfromdate,coalesce(date_format(m.period_to,'%d.%m.%Y'),'') contracttodate,coalesce(pm.accname,'') propname,ac.refname,coalesce(ac.trnnumber,'') ownertrn,ac.tax ownertax,pm.acno,"+
		" ownerhead.atype,ownerhead.description from rl_tncm m left join rl_propertymaster pm on pm.doc_no=m.prtype left join rl_propertryowner own on own.doc_no=pm.owid left join my_head ownerhead on "+
		" pm.acno=ownerhead.doc_no left join my_acbook ac on (ownerhead.doc_no=ac.acno) left join my_acbook tn on (m.cldocno=tn.cldocno and tn.dtype='CRM') where m.status=3 and m.doc_no="+docno;
		ResultSet rsgetowneracno=stmt.executeQuery(strgetowneracno);
		while(rsgetowneracno.next()){
			owacno=rsgetowneracno.getInt("acno");
			owneractype=rsgetowneracno.getString("atype");
			ownername=rsgetowneracno.getString("ownername");
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
		//griddescription="TA - "+docno+" - "+tenantname+" - "+propname+" - "+contractfromdate+" to "+contracttodate;
		griddescription="TA - "+voc_no+" - Period From "+contractfromdate+" to "+contracttodate;
		if(owcurId==0){owcurId=1;	}
		if(owrate==0){owrate=1;	}
						
		 String rem="temp";
		 session.setAttribute("BRANCHID", brhid);
		 
		 ArrayList<String> proday= new ArrayList<String>();
		 String aa[]=list.split(",");
		 for(int i=0;i<aa.length;i++)
		 {
			 String bb[]=aa[i].split("::");
			 String temp="";
			 for(int j=0;j<bb.length;j++){ 
				 temp=temp+bb[j]+"::";
			}
			proday.add(temp);
		 } 
					
					
		ArrayList<String> proday1= new ArrayList<String>();
		String aa1[]=list1.split(",");		
		for(int i1=0;i1<aa1.length;i1++)
		{
			String bb1[]=aa1[i1].split("::");
			String temp1="";
			for(int j1=0;j1<bb1.length;j1++){ 
				 temp1=temp1+bb1[j1]+"::";
			}
			proday1.add(temp1);
		} 
			
		
		ArrayList<String> masterarray= new ArrayList<String>();		
		ArrayList<String> redirectarray= new ArrayList<String>();		
		ArrayList<String> tarr= new ArrayList<String>();
		ArrayList<String> cashreceiptarray= new ArrayList<String>();					
		ArrayList<String> bankreceiptarray= new ArrayList<String>();	
		ArrayList<String> adminfeearray= new ArrayList<String>();		
		String strCash="",strBank="",strJV="";
		java.sql.Date mdate=null ;					
		String p0="",p1="",p2="",p4="",p5="",p6="",p7="",p8="",p9="",p10="",p11="";
		int chckpdc=0;
		ArrayList<String> labarray= new ArrayList<String>();
		Double garrageval=0.00;
		Double totamount=0.00;
		
		String desc="TA-"+voc_no;
		//System.out.println("prod1 array=="+proday1);
		for(int k1=0;k1<proday1.size();k1++)
		{
			//System.out.println("Checking Array");
			//System.out.println(proday1.get(k1));
			String[] prod1=((String) proday1.get(k1)).split("::"); 
			
			p0=prod1[0];
			p2=prod1[2];
			p4=prod1[4]; 
			p5=prod1[5];
			p6=prod1[6];
			p7=prod1[7]; 
			p8=prod1[8];
			p9=prod1[9];
			p10=prod1[10];
			p11=prod1[11];
			
			/* if(p0.equalsIgnoreCase("Rent Value"))
			{
				p0="RV";
			}
			else if(p0.equalsIgnoreCase("Security deposit"))
			{
				p0="SD";
			}
			else if(p0.equalsIgnoreCase("Electricity"))
			{
				p0="ELEC";
			}
			else if(p0.equalsIgnoreCase("GAS"))
			{
				p0="GAS";
			}
			else if(p0.equalsIgnoreCase("Chiller"))
			{
				p0="CHL";
			}
			else if(p0.equalsIgnoreCase("Admin Fee"))
			{
				p0="AF";
			}
			else if(p0.equalsIgnoreCase("Ejari"))
			{
				p0="EJR";
			}
			else if(p0.equalsIgnoreCase("Others"))
			{
				p0="OTH";
			}
			else
			{}  */
			
			//System.out.println("==prod1[1]="+prod1[1]);							
			mdate=ClsCommon.changeStringtoSqlDate(prod1[1]);
		 
			if(p10.equalsIgnoreCase("111"))
			{	  
				if(p5.equalsIgnoreCase("Owner")){
					ownertotal+=Double.parseDouble(p2);
				}
				if(p5.equalsIgnoreCase("Self")){
					selftotal+=Double.parseDouble(p2);
				}
				totamount+=Double.parseDouble(p2);			 
				strCash +=  p11+","; 
				desc+=','+p0+'-'+p2;
			}		 
						 
		}// Closing for loop
		
	 			
		//insert CRV
		
		 
		String chqno="", chq="" ;
		Double brvamount=0.00;
		
		String pp0="",pp1="",pp2="",pp3="",pp4="",pp5="",pp6="",pp7="",pp8="",pp9="",pp10="",pp11="",pp12="";
		int no=0;
		
		//System.out.println("prod1 brv array=="+proday1);
		for(int k1=0;k1<proday1.size();k1++)
		{
			 String[] prod1=((String) proday1.get(k1)).split("::"); 
			 
			 mdate=ClsCommon.changeStringtoSqlDate(prod1[1]); 
			  
			if(prod1[10].equalsIgnoreCase("222"))// Bank reciept
			{		 
			} 
			    
		 }

		for(int k1=0;k1<proday1.size();k1++){
				String[] prod1=((String) proday1.get(k1)).split("::"); 
				if(prod1[10].equalsIgnoreCase("333")){
				} 
			}
					
		Double propertyinvoicetotal=0.0;
		double redirectinvtotal=0.0;
		int k;
		int privrentalrestrict=0;
		ownertotal=0.0;
		selftotal=0.0;
		int gridsrno=0;
		for(int agentindex=0;agentindex<agentarray.size();agentindex++){
			double salamount=Double.parseDouble(agentarray.get(agentindex).split("::")[2]);
			String strgetsla="select sal.sal_name,h.curid,h.rate, h.atype ,sal.acc_no acno from my_salesman  sal left join my_head h on h.doc_no=sal.acc_no where"+
			" sal.status=3  and sal.doc_no="+agentarray.get(agentindex).split("::")[0]+" and sal.sal_type='SLA'" ;
			String salname="",salactype="";
			int salcurid=0,salacno=0;
			double salrate=0.0;
			ResultSet rsgetsla=stmt.executeQuery(strgetsla);
			while(rsgetsla.next()){
				
				salname=rsgetsla.getString("sal_name");
				salcurid=rsgetsla.getInt("curid");
				salrate=rsgetsla.getDouble("rate");
				salacno=rsgetsla.getInt("acno");
				salactype=rsgetsla.getString("atype");
			}
			//Change on 05-04-2020- Changing Account
			strgetsla="select head.doc_no acno,head.curid,head.rate,head.atype from my_account ac left join my_head head on (ac.acno=head.doc_no)where ac.codeno='AGENTCOMMISSIONACNO'";
			ResultSet rsgetagentacno=stmt.executeQuery(strgetsla);
			while(rsgetagentacno.next()){
				salcurid=rsgetagentacno.getInt("curid");
				salrate=rsgetagentacno.getDouble("rate");
				salacno=rsgetagentacno.getInt("acno");
				salactype=rsgetagentacno.getString("atype");
			}
			/* newTextBox.val(rows[i].srno + "::" + rows[i].qty + " :: " + rows[i].description + " :: " + rows[i].unitprice + " :: " + rows[i].total + " :: " + rows[i].discount + " :: " + rows[i].nettotal + " :: " + rows[i].taxper + " :: " + rows[i].taxperamt + " :: " + rows[i].taxamount + " :: " + rows[i].nuprice + " :: " + rows[i].costtype + " :: " + rows[i].costcode + " :: " + rows[i].remarks + " :: " + rows[i].headdoc + " :: " + aa + " :: "); */
			/* listss.push($("#termsOfContractGridId") .jqxGrid('getcellvalue', selectedrows[i], 'description') + "::" + $("#termsOfContractGridId") .jqxGrid('getcellvalue', selectedrows[i], 'qty') + "::" + $("#termsOfContractGridId") .jqxGrid('getcellvalue', selectedrows[i], 'amount') + "::" + $("#termsOfContractGridId") .jqxGrid('getcellvalue', selectedrows[i], 'vatper') + "::" + $("#termsOfContractGridId") .jqxGrid('getcellvalue', selectedrows[i], 'vatvalue') + "::" + $("#termsOfContractGridId") .jqxGrid('getcellvalue', selectedrows[i], 'total') + "::" + $("#termsOfContractGridId") .jqxGrid('getcellvalue', selectedrows[i], 'atype') + "::" + $("#termsOfContractGridId") .jqxGrid('getcellvalue', selectedrows[i], 'acno') + "::" + $("#termsOfContractGridId") .jqxGrid('getcellvalue', selectedrows[i], 'ftype') + "::"); */
			if(objcommon.Round(salamount,2)>0.0){
				masterarray.add((gridsrno+1)+"::"+1+" :: "+salname+" :: "
						 +objcommon.Round(salamount,2)+" :: "+objcommon.Round(salamount,2)+" :: "+0+" :: "+objcommon.Round(salamount,2)+" :: "
						 +0+" :: "+0+" :: "+objcommon.Round(salamount,2)+" :: "+objcommon.Round(salamount,2)+" :: "
						 +0+" :: "+0+"  :: "+rem+" :: "+salacno+" :: "+aa+" :: ");
				//System.out.println("==masterarray =1="+masterarray);
			}
			
			int acnoss=0;
			Statement stm=conn.createStatement();
			String sql="select acno from my_account where codeno='COMEXP' ";
			//System.out.println("==sql="+sql);				
			ResultSet rss12=stm.executeQuery(sql);						 
			if(rss12.first())
			{
				acnoss=rss12.getInt("acno");
			}	 
			if(acnoss>0)
			{
				//propertyinvoicetotal+=Double.parseDouble(prod[5]);
				if(objcommon.Round(salamount,2)>0.0){

					masterarray.add((gridsrno+2)+"::"+1+" :: "+salname+" :: "
							 +objcommon.Round(salamount,2)*-1+" :: "+objcommon.Round(salamount,2)*-1+" :: "+0+" :: "+objcommon.Round(salamount,2)*-1+" :: "
							 +0+" :: "+0+" :: "+objcommon.Round(salamount,2)*-1+" :: "+objcommon.Round(salamount,2)+" :: "
							 +0+" :: "+0+" :: "+rem+" :: "+acnoss+" :: "+aa+" :: ");
					//System.out.println("==masterarray =2="+masterarray);
				}
			}
			gridsrno=2;
		}
		//System.out.println("masterarray=="+masterarray);
		//System.out.println("==proday="+ proday);
		for( k=0;k<proday.size();k++,gridsrno++)
		{
			//System.out.println("Checking Array 2");
			//System.out.println(proday.get(k));
			String[] prod=((String) proday.get(k)).split("::"); 
			
			//System.out.println("prd[2]="+prod[2]);
			if(prod[8].equalsIgnoreCase("102"))
			{ 
				//propertyinvoicetotal+=Double.parseDouble(prod[5]);
								
			}
			else
			{
				griddescription+=","+prod[0]+"-"+prod[2];
				//System.out.println("Check Amount:"+prod[5]);
				//System.out.println("Property Manage: "+propmanage);
				if (prod[0].equalsIgnoreCase("Rental value") && propmanage==1)
				{
					//System.out.println("Owner Acno:"+owacno);
					//System.out.println("Rental Acno:"+rentalvalueacno);
					if(chkvatdistributed==1){
						if(privrentalrestrict==0){
							String strgetfirstinstallment="select (select taxtype from rl_tncterms where rdocno="+docno+" and slno=1) taxtype,(select pamount from rl_tncpayment where  rdocno="+docno+" and slno=1 and desc1='Rental Value') installment,(select paidto from rl_tncpayment where  rdocno="+docno+" and slno=1 and desc1='Rental Value') firstpaidto";
							//System.out.println("strgetfirstinstallment="+strgetfirstinstallment);
							ResultSet rsgetfirstinstallment=stmt.executeQuery(strgetfirstinstallment);
							String rentaltaxtype="";
							double firstinstallment=0.0;
							String firstpaidto="";
							while(rsgetfirstinstallment.next()){
								rentaltaxtype=rsgetfirstinstallment.getString("taxtype");
								firstinstallment=rsgetfirstinstallment.getDouble("installment");
								firstpaidto=rsgetfirstinstallment.getString("firstpaidto");
							}
							
							if(rentaltaxtype.equalsIgnoreCase("Inclusive")){  
								double inclusiveamt = (firstinstallment/(100+gltax))*100;
								double installmenttaxamt = firstinstallment-inclusiveamt;
								inclusiveamt = objcommon.Round(inclusiveamt,2);
								installmenttaxamt = objcommon.Round(installmenttaxamt, 2);
								prod[2] = (inclusiveamt)+"";
								prod[4] = (installmenttaxamt)+"";
								prod[5] = (firstinstallment)+"";
							}
							else if(rentaltaxtype.equalsIgnoreCase("Exclusive")){
								double installmenttaxamt = firstinstallment*(gltax/100);
								double exclusiveamt = firstinstallment-installmenttaxamt;
								installmenttaxamt = objcommon.Round(installmenttaxamt, 2);
								exclusiveamt = objcommon.Round(exclusiveamt,2);
								prod[2] = (exclusiveamt)+"";
								prod[4] = (installmenttaxamt)+"";
								prod[5] = (firstinstallment)+"";
							}
							else{
								prod[2]=(firstinstallment)+"";
								prod[4]=(0.0)+"";
								prod[5]=(firstinstallment)+"";
							}
							propertyinvoicetotal+=objcommon.Round(Double.parseDouble(prod[5]),2);
							if(objcommon.Round(Double.parseDouble(prod[2]),2)>0.0){
								String strgriddesc="TA - "+voc_no+" - Period From "+contractfromdate+" to "+contracttodate+","+prod[0]+"-"+prod[2];
								masterarray.add((gridsrno+1)+"::"+prod[1]+" :: "+prod[0]+" :: "
										 +objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "+0+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "
										 +(Double.parseDouble(prod[4])>0.0?5.0:0.0)+" :: "+objcommon.Round(Double.parseDouble(prod[4]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[5]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "
										 +0+" :: "+0+" :: "+strgriddesc+" :: "+(firstpaidto.equalsIgnoreCase("Self")?rentalvalueacno:owacno)+" :: "+aa+" :: ");							
								//System.out.println("==masterarray =3="+masterarray);
							}
							privrentalrestrict++;
						}
					}
					else{
						propertyinvoicetotal+=objcommon.Round(Double.parseDouble(prod[5]),2);
						String strgetpaidtovalues="select coalesce((select sum(pamount) from rl_tncpayment where rdocno="+docno+" and paidto='Owner' and desc1 like '%Rental Value%'),0) ownertotal,"+
						"coalesce((select sum(pamount)  from rl_tncpayment where rdocno="+docno+" and paidto='Self' and desc1 like '%Rental Value%'),0) selftotal,"+
						/* "coalesce((select sum(pamount)  from rl_tncpayment where rdocno="+docno+" and payment='On Account' and desc1='Rental Value'),0) onaccounttotal,"+ */
						"(select taxtype from rl_tncterms where rdocno="+docno+" and slno=1) taxtype,"+
						"(select nettotal from rl_tncterms where rdocno="+docno+" and slno=1) nettaxtotal";
						//System.out.println(strgetpaidtovalues);
						ResultSet rsgetpaidtovalues=stmt.executeQuery(strgetpaidtovalues);
						String rentaltaxtype="";
						double onaccounttotal=0.0;
						double nettaxtotal=0.0;
						while(rsgetpaidtovalues.next()){
							ownertotal=rsgetpaidtovalues.getDouble("ownertotal");
							selftotal=rsgetpaidtovalues.getDouble("selftotal");
							rentaltaxtype=rsgetpaidtovalues.getString("taxtype");
							nettaxtotal=rsgetpaidtovalues.getDouble("nettaxtotal");
							/* onaccounttotal=rsgetpaidtovalues.getDouble("onaccounttotal"); */
						}
						/* ownertotal+=onaccounttotal; */
						//System.out.println("Owner Total:"+ownertotal);
						//System.out.println(rentaltaxtype+" :Self Total: "+selftotal);  
						if(rentaltaxtype.equalsIgnoreCase("Inclusive")){
							double ownerinclusiveamt = (ownertotal/(100+gltax))*100;
							double ownertaxamt = ownertotal-ownerinclusiveamt;
							double selfinclusiveamt = (selftotal/(100+gltax))*100;
							double selftaxamt = selftotal-selfinclusiveamt;
							ownerinclusiveamt = objcommon.Round(ownerinclusiveamt, 2);
							ownertaxamt = objcommon.Round(ownertaxamt, 2);
							selfinclusiveamt = objcommon.Round(selfinclusiveamt, 2);
							selftaxamt = objcommon.Round(selftaxamt,2);
							
							if(ownertotal>0.0){
								prod[2]=(ownerinclusiveamt)+"";
								prod[4]=(ownertaxamt)+"";
								prod[5]=(ownertotal)+"";
								String strgriddesc="TA - "+voc_no+" - Period From "+contractfromdate+" to "+contracttodate+","+prod[0]+"-"+prod[2];
								masterarray.add((gridsrno+1)+"::"+prod[1]+" :: "+prod[0]+" :: "
										 +objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "+0+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "
										 +(Double.parseDouble(prod[4])>0.0?5.0:0.0)+" :: "+objcommon.Round(Double.parseDouble(prod[4]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[5]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "
										 +0+" :: "+0+" :: "+strgriddesc+" :: "+owacno+" :: "+aa+" :: ");
								//k++;
								//System.out.println("==masterarray =4="+masterarray);
							}
							if(selftotal>0.0){
								prod[2]=(selfinclusiveamt)+"";
								prod[4]=(selftaxamt)+"";
								prod[5]=(selftotal)+"";
								String strgriddesc="TA - "+voc_no+" - Period From "+contractfromdate+" to "+contracttodate+","+prod[0]+"-"+prod[2];
								masterarray.add((gridsrno+2)+"::"+prod[1]+" :: "+prod[0]+" :: "
										 +objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "+0+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "
										 +(Double.parseDouble(prod[4])>0.0?5.0:0.0)+" :: "+objcommon.Round(Double.parseDouble(prod[4]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[5]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "
										 +0+" :: "+0+" :: "+strgriddesc+" :: "+rentalvalueacno+" :: "+aa+" :: ");
								//k++;
								//System.out.println("==masterarray =5="+masterarray);
							}
							
						}
						else if(rentaltaxtype.equalsIgnoreCase("Exclusive")){
							/* double ownertaxamt = ownertotal*(gltax/100);
							double ownerexclusiveamt = ownertotal-ownertaxamt; */
							
							//Above Lines commented because in ABZ amount was coming already calculated with vat-then no need of calculate VAT again - 06-04-2023
							double ownertaxamt=0.0,ownerexclusiveamt=0.0;
							if(ownertotal+selftotal==nettaxtotal){
								ownerexclusiveamt=(ownertotal/(100+gltax))*100;
								ownertaxamt=ownertotal-ownerexclusiveamt;
							}
							else{
								ownertaxamt = ownertotal*(gltax/100);
								ownerexclusiveamt = ownertotal-ownertaxamt;
							}
							
							ownertaxamt = objcommon.Round(ownertaxamt, 2);
							ownerexclusiveamt = objcommon.Round(ownerexclusiveamt,2);
							prod[2] = (ownerexclusiveamt)+"";
							prod[4] = (ownertaxamt)+"";
							prod[5] = (ownertotal)+"";
							if(ownertotal>0.0){
								String strgriddesc="TA - "+voc_no+" - Period From "+contractfromdate+" to "+contracttodate+","+prod[0]+"-"+prod[2];
								masterarray.add((gridsrno+1)+"::"+prod[1]+" :: "+prod[0]+" :: "
										 +objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "+0+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "
										 +(Double.parseDouble(prod[4])>0.0?5.0:0.0)+" :: "+objcommon.Round(Double.parseDouble(prod[4]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[5]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "
										 +0+" :: "+0+" :: "+strgriddesc+" :: "+owacno+" :: "+aa+" :: ");
								//k++;
								//System.out.println("==masterarray =6="+masterarray);
								
							}
							
							/* double selftaxamount = selftotal*(gltax/100);      
							double selfexclusiveamt = selftotal-selftaxamount; */
							double selftaxamount=0.0,selfexclusiveamt=0.0;
							
							//Above Lines commented because in ABZ amount was coming already calculated with vat-then no need of calculate VAT again - 06-04-2023
							//System.out.println("Owner Total:"+ownertotal);
							//System.out.println("Self Total:"+selftotal);
							//System.out.println("Net Total:"+nettaxtotal);
							
							if((ownertotal+selftotal)==nettaxtotal){
								selfexclusiveamt=(selftotal/(100+gltax))*100;
								selftaxamount=selftotal-selfexclusiveamt;
							}
							else{
								selftaxamount = selftotal*(gltax/100);
								selfexclusiveamt = selftotal-selftaxamount;
							}
							selftaxamount = objcommon.Round(selftaxamount, 2);
							selfexclusiveamt = objcommon.Round(selfexclusiveamt,2);
							//System.out.println(selftotal*(gltax/100)+"=="+objcommon.Round(selftaxamount, 2));
							prod[2] = (selfexclusiveamt)+"";
							prod[4] = (selftaxamount)+"";
							prod[5] = (selftotal)+"";
							
							//System.out.println(prod[2]+"="+selfexclusiveamt+"="+prod[4]+"="+selftaxamount+"="+prod[5]+"="+selftotal);
							if(selftotal>0.0){ 
								String strgriddesc="TA - "+voc_no+" - Period From "+contractfromdate+" to "+contracttodate+","+prod[0]+"-"+prod[2];
								masterarray.add((gridsrno+2)+"::"+prod[1]+" :: "+prod[0]+" :: "
										 +objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "+0+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "
										 +(Double.parseDouble(prod[4])>0.0?5.0:0.0)+" :: "+objcommon.Round(Double.parseDouble(prod[4]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[5]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "
										 +0+" :: "+0+" :: "+strgriddesc+" :: "+rentalvalueacno+" :: "+aa+" :: ");
								//System.out.println("==masterarray =7="+masterarray);
							}
							//System.out.println("master array "+masterarray);
						}
						else{
							prod[2]=(ownertotal)+"";
							prod[4]=(0.0)+"";
							prod[5]=(ownertotal)+"";
							//System.out.println("======="+ownertotal+"======"+selftotal);
							if(ownertotal>0.0){
								String strgriddesc="TA - "+voc_no+" - Period From "+contractfromdate+" to "+contracttodate+","+prod[0]+"-"+prod[2];
								masterarray.add((gridsrno+1)+"::"+prod[1]+" :: "+prod[0]+" :: "
										 +objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "+0+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "
										 +(Double.parseDouble(prod[4])>0.0?5.0:0.0)+" :: "+objcommon.Round(Double.parseDouble(prod[4]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[5]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "
										 +0+" :: "+0+" :: "+strgriddesc+" :: "+owacno+" :: "+aa+" :: ");
								//k++;
								//System.out.println("==masterarray =8="+masterarray);
								
							}
							prod[2]=(selftotal)+"";
							prod[4]=(0.0)+"";
							prod[5]=(selftotal)+"";
							if(selftotal>0.0){
								String strgriddesc="TA - "+voc_no+" - Period From "+contractfromdate+" to "+contracttodate+","+prod[0]+"-"+prod[2];
								masterarray.add((gridsrno+2)+"::"+prod[1]+" :: "+prod[0]+" :: "
										 +objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "+0+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "
										 +(Double.parseDouble(prod[4])>0.0?5.0:0.0)+" :: "+objcommon.Round(Double.parseDouble(prod[4]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[5]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "
										 +0+" :: "+0+" :: "+strgriddesc+" :: "+rentalvalueacno+" :: "+aa+" :: ");
								//System.out.println("==masterarray =9="+masterarray);
							}
							//System.out.println("master array "+masterarray);
						}
						

					}
					
				}
				else if(((prod[0].equalsIgnoreCase("Security deposit") || prod[0].equalsIgnoreCase("Electricity") || prod[0].equalsIgnoreCase("Gas") || prod[0].equalsIgnoreCase("Chiller") || prod[0].equalsIgnoreCase("Others")) && propmanage==1) || (!prod[0].equalsIgnoreCase("Rental Value") && !prod[0].equalsIgnoreCase("Security deposit") && !prod[0].equalsIgnoreCase("Electricity") && !prod[0].equalsIgnoreCase("Gas") && !prod[0].equalsIgnoreCase("Chiller") && !prod[0].equalsIgnoreCase("Others")))
				{
					//System.out.println(prod[0]+"::"+propmanage);
					if(Double.parseDouble(prod[5])>0.0){
						propertyinvoicetotal+=Double.parseDouble(prod[5]);
						String strcheckpaidto="select paidto,notes from rl_tncpayment where rdocno="+docno+" and desc1='"+prod[0]+"'";
						ResultSet rscheckpaidto=stmt.executeQuery(strcheckpaidto);
						String paymentnotes="";
						while(rscheckpaidto.next()){
							if(rscheckpaidto.getString("paidto").equalsIgnoreCase("Owner")){
								prod[6]=owneractype;
								prod[7]=owacno+"";
							}
							paymentnotes=rscheckpaidto.getString("notes");
						}
						String propertydesc=propname+" - "+desc+" - "+paymentnotes;
						/* masterarray.add((k+1)+"::"+prod[1]+" ::  "+griddescription+" :: "
								 +objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "+0+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "
								 +prod[3]+" :: "+objcommon.Round(Double.parseDouble(prod[4]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[5]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "
								 +0+" :: "+0+" :: "+remarks+" :: "+prod[7]+" :: "+aa+" :: "); */
						//System.out.println("Redirect array check:"+redirectbrhid+"::"+prod[2]+"::"+prod[0]+"::"+propmanage);
						if(redirectbrhid>0 && objcommon.Round(Double.parseDouble(prod[2]),2)>0.0 && ((prod[0].trim().equalsIgnoreCase("Commission") && propmanage==1) || (propmanage==0 && (prod[0].trim().equalsIgnoreCase("Commission") || prod[0].trim().equalsIgnoreCase("Ejari") || prod[0].trim().equalsIgnoreCase("Admin Fee"))))){
							String strgriddesc="TA - "+voc_no+" - Period From "+contractfromdate+" to "+contracttodate+","+prod[0]+"-"+prod[2];
							 redirectarray.add((gridsrno+1)+"::"+prod[1]+" :: "+prod[0]+" :: "
									 +objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "+0+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "
									 +(Double.parseDouble(prod[4])>0.0?5.0:0.0)+" :: "+objcommon.Round(Double.parseDouble(prod[4]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[5]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "
									 +0+" :: "+0+" :: "+strgriddesc+" :: "+prod[7]+" :: "+aa+" :: ");
						}
						else if(objcommon.Round(Double.parseDouble(prod[2]),2)>0.0){
							String strgriddesc="TA - "+voc_no+" - Period From "+contractfromdate+" to "+contracttodate+","+prod[0]+"-"+prod[2];
							 masterarray.add((gridsrno+1)+"::"+prod[1]+" :: "+prod[0]+" :: "
									 +objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "+0+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "
									 +(Double.parseDouble(prod[4])>0.0?5.0:0.0)+" :: "+objcommon.Round(Double.parseDouble(prod[4]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[5]),2)+" :: "+objcommon.Round(Double.parseDouble(prod[2]),2)+" :: "
									 +0+" :: "+0+" :: "+strgriddesc+" :: "+prod[7]+" :: "+aa+" :: ");
							 //System.out.println("==masterarray =10="+masterarray);
						}
								
					}
				}
			}
			
		}
		propertyinvoicetotal=0.0;
		//System.out.println("Master Array Data");
		for(int index=0;index<masterarray.size();index++){
			//System.out.println(masterarray.get(index));
			//System.out.println("Property Inv Array:"+masterarray.get(index));
			propertyinvoicetotal+=Double.parseDouble(masterarray.get(index).split("::")[9]);
		}
		//System.out.println("Redirect Array Data");
		for(int index=0;index<redirectarray.size();index++){
			System.out.println(redirectarray.get(index));
			//System.out.println("Property Inv Array:"+masterarray.get(index));
			redirectinvtotal+=Double.parseDouble(redirectarray.get(index).split("::")[9]);
		}
		
		//System.out.println("Master Array Size:"+masterarray.size());
		//System.out.println("Property Inv Total:"+propertyinvoicetotal);
		String propertydesc=propname+" - "+desc;
		/*if(masterarray.size()==0){
			errorstatus=1;
			System.out.println("Array size Zero 1 Error");
		}*/
		
		int propertyinvvalue=0;
		if(masterarray.size()>0){
			int restrictAgentArray=0;
			if(redirectbrhid>0 && redirectarray.size()>0){
				//System.out.println("Checking Agent Restrict");
				for(int i=0;i<redirectarray.size();i++){
					if(redirectarray.get(i).contains("Commission")){
						restrictAgentArray=1;
					}
				}
			}
			//System.out.println("masterarray====>"+masterarray);
			propertyinvvalue=save.insertPropertyInvoice(cdate, cdate, "TNC", docno, atype, clacno+"", clientname, curId+"", rate+"", "", "", griddescription,
					session, "A", objcommon.Round(propertyinvoicetotal,2) , masterarray, "PRIV", request, null, "", "", 0, clienttax>0?5.0:0.0, clientname, clienttrn, restrictAgentArray>0?blankarray:agentarray, 2,conn,propname,ownername,sqlcontractfromdate,sqlcontracttodate,objcommon.Round(propertyinvoicetotal,2)+"");
			if(propertyinvvalue<=0){
				errorstatus=1;
				//System.out.println("Property Invoice Insert 1 Error");
			}	
		}
		
		if(redirectarray.size()>0){
			String oldbrhid=session.getAttribute("BRANCHID").toString();
			//System.out.println("redirectarray====>"+redirectarray);
			//Setting Redirect Branch in session
			session.setAttribute("BRANCHID", redirectbrhid);
			redirectinvvalue=save.insertPropertyInvoice(cdate, cdate, "TNC", docno, atype, clacno+"", clientname, curId+"", rate+"", "", "", griddescription, session, "A", objcommon.Round(redirectinvtotal,2) , redirectarray, "PRIV", request, null, "", "", 0, clienttax>0?5.0:0.0, clientname, clienttrn, agentarray, 2,conn,propname,ownername,sqlcontractfromdate,sqlcontracttodate,objcommon.Round(redirectinvtotal,2)+"");
			if(redirectinvvalue<=0){
				errorstatus=1;
				//System.out.println("Redirect Property Invoice Insert 1 Error");
			}
			else{
				//Getting Corresponding TRNO
				String strgetinvtrno="select tr_no from rl_prinvm where doc_no="+redirectinvvalue;
				ResultSet rsinvtrno=stmt.executeQuery(strgetinvtrno);
				int invtrno=0;
				while(rsinvtrno.next()){
					invtrno=rsinvtrno.getInt("tr_no");
				}
				/*
				//Updating brhid
				String strupdatebrhid="update rl_prinvm set brhid="+redirectbrhid+" where doc_no="+redirectinvvalue;
				int updatebrhid=stmt.executeUpdate(strupdatebrhid);
				if(updatebrhid<=0){
					errorstatus=1;
					System.out.println("Redirect Property Invoice Update Branch Error");
				}
				
				String strupdatejv="update my_jvtran set brhid="+redirectbrhid+" where tr_no="+invtrno;
				int updatejv=stmt.executeUpdate(strupdatejv);
				*/
				
				invdocarray.add(redirectinvvalue+"");
				String strgetvocno="select voc_no from rl_prinvm where doc_no="+redirectinvvalue;
				ResultSet rsgetvocno=stmt.executeQuery(strgetvocno);
				String privvocno="";
				while(rsgetvocno.next()){
					privvocno=rsgetvocno.getString("voc_no");
				}
				if(errormsg.equalsIgnoreCase("")){
					errormsg="PRIV #"+privvocno;
				}
				else{
					errormsg=errormsg+","+privvocno;
				}
			}
			
			//Resetting old branchid
			session.setAttribute("BRANCHID", oldbrhid);
		}
		if(propertyinvvalue>0){
			//Updating rl_tncpayment
			if(chkvatdistributed==1 && privrentalrestrict>0){
				String strupdatepyt="update rl_tncpayment set privdocno="+propertyinvvalue+" where rdocno="+docno+" and ((slno=1 and desc1='Rental Value') or (desc1<>'Rental Value'))";
				int updatepyt=stmt.executeUpdate(strupdatepyt);
				if(updatepyt<=0){
					errorstatus=1;
					//System.out.println("Update Payment Inv Value Error");
				}
			}
			else{
				String strupdatepyt="update rl_tncpayment set privdocno="+propertyinvvalue+" where rdocno="+docno+"";
				int updatepyt=stmt.executeUpdate(strupdatepyt);
				if(updatepyt<=0){
					errorstatus=1;
					//System.out.println("Update Payment Inv Value Error");
				}
			}
			invdocarray.add(propertyinvvalue+"");
			String strgetvocno="select voc_no from rl_prinvm where doc_no="+propertyinvvalue;
			ResultSet rsgetvocno=stmt.executeQuery(strgetvocno);
			String privvocno="";
			while(rsgetvocno.next()){
				privvocno=rsgetvocno.getString("voc_no");
			}
			if(errormsg.equalsIgnoreCase("")){
				errormsg="PRIV #"+privvocno;
			}
			else{
				errormsg=errormsg+","+privvocno;
			}
		}
		
		if(redirectinvvalue>0){
			for(int i=0;i<redirectarray.size();i++){
				String strupdatepyt="update rl_tncpayment set privdocno="+redirectinvvalue+" where rdocno="+docno+" and desc1='"+redirectarray.get(i).split("::")[2].trim()+"'";
				System.out.println(strupdatepyt);
				int updatepyt=stmt.executeUpdate(strupdatepyt);
				if(updatepyt<0){
					errorstatus=1;
					//System.out.println("Update Payment Inv Value Error");
				}	
			}
			
		}
		masterarray=new ArrayList();
		// admin owner fee
		double adminfee=0.00;
		double mgmtvatvalue=0.0;
		String mgmtvattype="";
		double mgmtamt=0.0;
		Double mgmtnettotal=0.0;
		String managementpercent="";
		String qry1="select mgmttaxtotal,managementamt,owneradminfee,mgmtvattype,managementper from rl_tncm where doc_no='"+docno+"' ";
		//System.out.println("=====qry1==="+qry1);			
		ResultSet rst=stmt.executeQuery(qry1);
		if(rst.first())
		{
			mgmtnettotal=rst.getDouble("mgmttaxtotal");
			mgmtamt=rst.getDouble("managementamt");
			//mgmtvatvalue=rst.getDouble("mgmtvatvalue");
			mgmtvattype=rst.getString("mgmtvattype");
			adminfee=rst.getDouble("owneradminfee");
			managementpercent=rst.getString("managementper");
		}
		int mgmtfeedocno=0;
		String strgetmgmtfee="select amount,id from rl_tncmanagefee where tdoc_no="+docno+"";
		//System.out.println(strgetmgmtfee);
		ResultSet rsgetmgmtfee=stmt.executeQuery(strgetmgmtfee);
		int mgmtfeecount=0;
		while(rsgetmgmtfee.next()){
			if(mgmtfeecount==0){
				mgmtamt=rsgetmgmtfee.getDouble("amount");
				mgmtfeedocno=rsgetmgmtfee.getInt("id");
			}
			mgmtfeecount++;
		}
		int adfeeacno=0;
		Statement stm=conn.createStatement();
		String sql="select acno from my_account where codeno='ADMIN FEE OWNER'";	
		//System.out.println(sql);
		ResultSet rst1=stm.executeQuery(sql);
		if(rst1.first()){
			adfeeacno=rst1.getInt("acno");
		}	 
		int mgmtfeeacno=0;
		String strmgmtfeeacno="select acno from my_account where codeno='PROPERTYMGMTFEE' ";
		//System.out.println(strmgmtfeeacno);
		ResultSet rsmgmtfeeacno=stm.executeQuery(strmgmtfeeacno);						 
		if(rsmgmtfeeacno.first()){
			mgmtfeeacno=rsmgmtfeeacno.getInt("acno");
		}
		k=0;
		double mgmttaxamount=0.0;
		double mgmtamount=0.0;
		mgmtnettotal=0.0;
		System.out.println("mgmtvattype1===>"+mgmtvattype);
		if(mgmtvattype.equalsIgnoreCase("Inclusive")){
			double inclusiveamtmgmt=(mgmtamt/(100+gltax))*100;
			mgmttaxamount=mgmtamt-inclusiveamtmgmt;
			mgmttaxamount=objcommon.Round(mgmttaxamount, 2);
			mgmtamount=mgmtamt-mgmttaxamount;
			mgmtamount=objcommon.Round(mgmtamount, 2);
			if(mgmtamount>0.0){
				griddescription=propname+" - TA "+docno+" 1/"+mgmtfeecount+" MGMT "+managementpercent+"% "+mgmtamount+"+"+mgmttaxamount;
				masterarray.add((k+1)+"::"+1+" :: Management Fee :: "+mgmtamount+" :: "+mgmtamount+" :: "+0+" :: "+mgmtamount+" :: "+gltax+" :: "+mgmttaxamount+" :: "+mgmtamt+" :: "+mgmtamount+" :: "+0+" :: "+0+"  :: "+griddescription+" :: "+mgmtfeeacno+" :: "+aa+" :: ");	
					
			}
			
			double inclusiveamtadminfee=(adminfee/(100+gltax))*100;
			double adminfeetaxamt=adminfee-inclusiveamtadminfee;
			adminfeetaxamt=objcommon.Round(adminfeetaxamt, 2);
			double adminfeeamount=adminfee-adminfeetaxamt;
			adminfeeamount=objcommon.Round(adminfeeamount, 2);
			if(adminfeeamount>0.0){
				griddescription=propname+" - TA "+docno+" AF "+adminfeeamount+"+"+adminfeetaxamt;
				masterarray.add((k+2)+"::"+1+" :: Admin Fee :: "+adminfeeamount+" :: "+adminfeeamount+" :: "+0+" :: "+adminfeeamount+" :: "+gltax+" :: "+adminfeetaxamt+" :: "+adminfee+" :: "+adminfeeamount+" :: "+0+" :: "+0+"  :: "+griddescription+" :: "+adfeeacno+" :: "+aa+" :: ");
					
			}
			mgmtnettotal=objcommon.Round((mgmtamt+adminfee), 2);
			propertydesc=propname+" - TA "+docno+" 1/"+mgmtfeecount;
			if(mgmtamt>0.0){
				propertydesc+=" MGMT "+managementpercent+"% "+mgmtamount+"+"+mgmttaxamount+",";
			}
			if(adminfee>0.0){
				propertydesc+=" AF "+adminfeeamount+"+"+adminfeetaxamt+",";
			}
		}
		else if(mgmtvattype.equalsIgnoreCase("Exclusive")){
		System.out.println("Mgmt Amt:"+mgmtamt);
			mgmttaxamount=mgmtamt*(gltax/100);
			//System.out.println("Mgmt Tax Amount:"+mgmttaxamount);
			mgmttaxamount=objcommon.Round(mgmttaxamount, 2);
			//System.out.println("Mgmt Tax Amount After Round:"+mgmttaxamount);
			mgmtamount=mgmtamt+mgmttaxamount;
			mgmtamount=objcommon.Round(mgmtamount, 2);
			//System.out.println(mgmtamt+"::"+mgmttaxamount+"::"+mgmtamount);
			if(mgmtamt>0.0){
				griddescription=propname+" - TA "+docno+" 1/"+mgmtfeecount+" MGMT "+managementpercent+"% "+mgmtamt+"+"+mgmttaxamount;
				masterarray.add((k+1)+"::"+1+" :: Management Fee :: "+mgmtamt+" :: "+mgmtamt+" :: "+0+" :: "+mgmtamt+" :: "+gltax+" :: "+mgmttaxamount+" :: "+mgmtamount+" :: "+mgmtamt+" :: "+0+" :: "+0+"  :: "+griddescription+" :: "+mgmtfeeacno+" :: "+aa+" :: ");	
					
			}
			
			double adminfeetaxamt=adminfee*(gltax/100);
			adminfeetaxamt=objcommon.Round(adminfeetaxamt, 2);
			double adminfeeamount=adminfee+adminfeetaxamt;
			adminfeeamount=objcommon.Round(adminfeeamount, 2);
			//System.out.println(adminfee+"::"+adminfeetaxamt+"::"+adminfeeamount);
			if(adminfee>0.0){
				griddescription=propname+" - TA "+docno+" AF "+adminfee+"+"+adminfeetaxamt;
				masterarray.add((k+2)+"::"+1+" :: Admin Fee :: "+adminfee+" :: "+adminfee+" :: "+0+" :: "+adminfee+" :: "+gltax+" :: "+adminfeetaxamt+" :: "+adminfeeamount+" :: "+adminfee+" :: "+0+" :: "+0+"  :: "+griddescription+" :: "+adfeeacno+" :: "+aa+" :: ");
					
			}
			mgmtnettotal=objcommon.Round((mgmtamount+adminfeeamount), 2);
			propertydesc=propname+" - TA "+docno+" 1/"+mgmtfeecount;
			if(mgmtamount>0.0){
				propertydesc+=" MGMT "+managementpercent+"% "+mgmtamt+"+"+mgmttaxamount+",";
			}
			if(adminfeeamount>0.0){
				propertydesc+=" AF "+adminfee+"+"+adminfeetaxamt+",";
			}
		}
		// admin owner fee
		
		//System.out.println("master array="+masterarray);
		double nettotal=0;
		String sqls="select sum(amount) amount from rl_tncterms where rdocno='"+docno+"' ";
			
		//System.out.println("=====sqls==="+sqls);			
		ResultSet ty=stmt.executeQuery(sqls);
		if(ty.first())
		{
			nettotal=ty.getDouble("amount");
		}
		agentarray=new ArrayList();
		for(int index=0;index<masterarray.size();index++){
			//System.out.println("Property Inv Array:"+masterarray.get(index));
		}
		//System.out.println("Master Array Size:"+masterarray.size());
		//System.out.println("Property Inv Total:"+propertyinvoicetotal);
		
		// vendor entry not needed for white star
		// mgmtnettotal=0.0;
		if(mgmtnettotal>0.0){
			propertydesc+=" "+apdesc;
			System.out.println("Master Array:"+masterarray);
			int propertyinvvalue2=save.insertPropertyInvoice(cdate, cdate, "TNC", docno, owneractype, owacno+"", ownername, curId+"", rate+"", "", "", propertydesc, session, "A",objcommon.Round(mgmtnettotal,2), masterarray, "PRIV", request, null, "", "", 0, ownertax>0?5.0:0.0, ownername, ownertrn, agentarray, 2,conn,propname,ownername,sqlcontractfromdate,sqlcontracttodate,objcommon.Round(mgmtnettotal,2)+"");
			if(propertyinvvalue2<=0){
				errorstatus=1;
				//System.out.println("Property Invoice Insert 2 Error");
			}
			if(propertyinvvalue2>0){
				if(propertyinvvalue2>0){
					invdocarray.add(propertyinvvalue2+"");
					String strgetvocno2="select voc_no from rl_prinvm where doc_no="+propertyinvvalue2;
					//System.out.println("strgetvocno2  == "+strgetvocno2);
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
				if(mgmtamt>0.0){
					String strupdateadminfee="update rl_tncmanagefee set privdocno="+propertyinvvalue2+" where id="+mgmtfeedocno;
					//System.out.println(strupdateadminfee);
					int updateadminfee=stmt.executeUpdate(strupdateadminfee);
					if(updateadminfee<0){
						//System.out.println("Update Admin Fee Error");
						errorstatus=1;
					}				
				}
			}	
		}
		
		if(id1==0 && id2==0 && id3==0)
		{			
			String ssq="delete from  rl_prinvd where rdocno="+propertyinvvalue+" and remarks='temp'";
			//System.out.println("==ssq="+ssq);
			stmt.executeUpdate(ssq);
			stragentjvdesc="Agency Commission for "+propname;
			String stragentjvdescupdate="update my_jvtran set description='"+stragentjvdesc+"' where rdocno="+docno+" and rtype='TNC' and description='temp'";
			int agentjvdescupdate=stmt.executeUpdate(stragentjvdescupdate);
			String ssq1="update rl_tncm set pstatus="+propertyinvvalue+"  where doc_no="+docno+" ";
			//System.out.println("==ssq1="+ssq1);
			stmt.executeUpdate(ssq1);
				
		}
		
		
		//Getting Voucher No corresponding to Branch
		String strinvdoc="";
		for(int i=0;i<invdocarray.size();i++){
			if(i==0){
				strinvdoc+=invdocarray.get(i);
			}
			else{
				strinvdoc+=","+invdocarray.get(i);
			}
		}
		
		String strgetvocno="SELECT br.BRANCHNAME,REPLACE(GROUP_CONCAT(m.voc_no),',','#') vocno FROM rl_prinvm m inner JOIN my_brch br ON m.brhid=br.DOC_NO where m.status=3 and m.doc_no in ("+strinvdoc+") group by m.brhid order by m.brhid,m.doc_no";
		ResultSet rsgetvocno=conn.createStatement().executeQuery(strgetvocno);
		while(rsgetvocno.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("branchname", rsgetvocno.getString("branchname"));
			objtemp.put("vocno", rsgetvocno.getString("vocno"));
			msgarray.add(objtemp);
		}
		objmsg.put("msgdata", msgarray);
		System.out.println(objmsg);
		if(errorstatus==0){
			errormsg="Successfully Generated "+errormsg;
			conn.commit();
		}
		else{
			errormsg="Not Updated";
		}
		System.out.println("Error Status:"+errorstatus);
		response.getWriter().write(errorstatus+"::"+errormsg+"::"+objmsg); 
	}
	 catch(Exception e)
	 {
		 e.printStackTrace();
		 conn.close();
		 response.getWriter().write(errorstatus+"::"+"Not Updated");
	 }
	finally{
		conn.close();
	}
	 
	 
	%>
