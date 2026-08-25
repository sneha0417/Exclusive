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

<%@page import="com.finance.transactions.unclearedchequereceipt.*"%>

<%@page import="com.finance.transactions.journalvouchers.ClsJournalVouchersDAO"%> 
<%@page import="com.dashboard.realestate.tenancycontractposting.ClsTenancyContractPostingDAO"%>

<%	
	String docno=request.getParameter("docno");
	String branchids=request.getParameter("branchids");
	String podate=request.getParameter("podate");
	String bankacno=request.getParameter("bankacno")==null?"":request.getParameter("bankacno");
	int errorstatus=0;
	String errormsg="";
	String list=request.getParameter("listss")==null?"0":request.getParameter("listss");
	String list1=request.getParameter("listss1")==null?"0":request.getParameter("listss1");
	String stragentarray=request.getParameter("agentarray")==null?"":request.getParameter("agentarray");
	ArrayList<String> agentarray=new ArrayList();
	int cashacno=0;
	if(!stragentarray.equalsIgnoreCase("")){
		for(int i=0;i<stragentarray.split(",").length;i++){
			agentarray.add(stragentarray.split(",")[i]);
		}
	}
	System.out.println("==list="+list);
	System.out.println("==list1="+list1);
	ClsUnclearedChequeReceiptDAO unclearedreceiptDAO= new ClsUnclearedChequeReceiptDAO();
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

		String upsql=null;
		int redirectbrhid=0;
		int pdcacno=0;
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
	   if(!(podate.equalsIgnoreCase("undefined"))&&!(podate.equalsIgnoreCase(""))&&!(podate.equalsIgnoreCase("0")))
		{
		   cdate=ClsCommon.changeStringtoSqlDate(podate);
		   dates=ClsCommon.changeStringtoSqlDate(podate);
			
		}
		else{

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
	   String strbankdetails="select description,curid,rate from my_head where doc_no="+bankacno;
	   ResultSet rsbankdetails=stmt.executeQuery(strbankdetails);
	   String bankname="";
	   int bankcurid=0;
	   double bankrate=0.0;
	   while(rsbankdetails.next()){
		   bankname=rsbankdetails.getString("description");
		   bankcurid=rsbankdetails.getInt("curid");
		   bankrate=rsbankdetails.getDouble("rate");
	   }
	   String strgetpdcacno="select head.doc_no from my_account ac left join my_head head on ac.acno=head.doc_no where ac.codeno='PDCRV'";
	   ResultSet rspdcacno=stmt.executeQuery(strgetpdcacno);
	   while(rspdcacno.next()){
		   pdcacno=rspdcacno.getInt("doc_no");
	   }
		String mastersql="  select br.redirectbrhid,pm.mgprpty propmanage,a.trnnumber,a.tax clienttax,curdate() cudate,  m.brhid,date_format(m.date,'%d.%m.%Y') invdate,coalesce(t.per,0) per,m.voc_no,h.curid,h.rate, h.atype, "
			+ "   m.date,m.ttype,m.acno ,  m.cldocno,a.refname,concat(pm.name,'-',m.voc_no) description, m.prtype, m.Period, "
			+ "  m.Period_no, m.Period_from, m.Period_to, m.not_Period  "
			+ " from rl_tncm  m  left join rl_propertymaster pm on pm.doc_no=m.prtype "
			+ " left join my_acbook a on a.acno=m.acno left join my_head h on h.doc_no=m.acno  "
			+" left join gl_taxmaster t on t.type=2 and per>0 and m.date between t.fromdate "
			+ "   and t.todate and a.tax=1 and m.ttype=2 left join my_brch br on m.brhid=br.doc_no where m.status=3 and m.doc_no='"+docno+"'";
			
			System.out.println("==mastersql="+mastersql);
						
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
			atype=rsmatersel1.getString("atype");			
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
		String strgetowneracno="select pm.acno from rl_tncm m left join rl_propertymaster pm on pm.doc_no=m.prtype where m.status=3  and m.doc_no="+docno;
		ResultSet rsgetowneracno=stmt.executeQuery(strgetowneracno);
		while(rsgetowneracno.next()){
			owacno=rsgetowneracno.getInt("acno");
		}		
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
		ArrayList<String> tarr= new ArrayList<String>();
		ArrayList<String> cashreceiptarray= new ArrayList<String>();					
		ArrayList<String> bankreceiptarray= new ArrayList<String>();	
		ArrayList<String> adminfeearray= new ArrayList<String>();		
		String strCash="",strBank="",strJV="";
		java.sql.Date mdate=null ;					
		String p0="",p1="",p2="",p4="",p5="",p6="",p7="",p8="",p9="",p10="",p11="";
		int chckpdc=0;
		ArrayList<String> labarray= new ArrayList<String>();
		double garrageval=0.00;
		double totamount=0.00;
		
		String desc="TA-"+voc_no;
		
		for(int k1=0;k1<proday1.size();k1++)
		{
			String[] prod1=((String) proday1.get(k1)).split("::"); 
			
			//System.out.println("prod1 array=="+proday1);
			
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
			{} */ 
			
			//System.out.println("==prod1[1]="+prod1[1]);							
			mdate=ClsCommon.changeStringtoSqlDate(prod1[1]);
		 
			if(p10.equalsIgnoreCase("111"))
			{	  
				//if((propmanage==1 && (p0.equalsIgnoreCase("Rental Value") || p0.equalsIgnoreCase("Security deposit")))||(!p0.equalsIgnoreCase("Rental Value") && !p0.equalsIgnoreCase("Security deposit"))){
				if((propmanage==1 && (p0.equalsIgnoreCase("Rental Value") || p0.equalsIgnoreCase("Security deposit") || p0.equalsIgnoreCase("Electricity") || p0.equalsIgnoreCase("Gas") || p0.equalsIgnoreCase("Chiller") || p0.equalsIgnoreCase("Others")))||(!p0.equalsIgnoreCase("Rental Value") && !p0.equalsIgnoreCase("Security deposit")  && !p0.equalsIgnoreCase("Electricity") && !p0.equalsIgnoreCase("Gas") && !p0.equalsIgnoreCase("Chiller") && !p0.equalsIgnoreCase("Others"))){
					totamount+=Double.parseDouble(p2);			 
					strCash +=  p11+","; 
					desc+=','+p0+'-'+p2;
					cashacno=Integer.parseInt(p7);
				}
				
			}		 
						 
		}// Closing for loop
		
	 			
		//insert CRV
		
		if(totamount>0)
		{
			//System.out.println("CRV Total Amount:"+totamount);	
			totamount=objcommon.Round(totamount,2);
			cashreceiptarray.add(cashacno+"::"+p8+"::"+p9+"::false::"+totamount+"::"+desc+"::"+totamount+"::0::0::0");
			cashreceiptarray.add(clacno+"::"+clcurId+"::"+clrate+"::true::"+totamount*-1+"::"+desc+"::"+totamount*-1+"::0::0::0");
			for(int index=0;index<cashreceiptarray.size();index++){
				System.out.println("CRV Array:"+cashreceiptarray.get(index));
			}
			String oldbrhid=session.getAttribute("BRANCHID").toString();
			if(redirectbrhid>0 && ((p0.trim().equalsIgnoreCase("Commision") && propmanage==1) || (propmanage==0 && (p0.trim().equalsIgnoreCase("Commision") || p0.trim().equalsIgnoreCase("Ejari") || p0.trim().equalsIgnoreCase("Admin Fee"))))){
				session.setAttribute("BRANCHID",redirectbrhid);
			}
			else{
				session.setAttribute("BRANCHID",oldbrhid);
			}
			int docnos=save.insert(conn,cdate,"CRV","",1.0,desc,objcommon.Round(Double.parseDouble(p2), 2) ,0.0,cashreceiptarray,tarr,session,request,"A");
			cashreceiptarray.clear();
			session.setAttribute("BRANCHID",oldbrhid);		
			//System.out.println("cash rec docno="+docnos);
			
			if(docnos<=0)
			{
				id1=1;
				errorstatus=1;
			}
			
			if(docnos>0)
			{
				if(errormsg.equalsIgnoreCase("")){
					errormsg="CRV #"+docnos;
				}
				else{
					errormsg=errormsg+","+"CRV #"+docnos;
				}
				int crvtrno=Integer.parseInt(request.getAttribute("tranno1")==null?"0":request.getAttribute("tranno1").toString());
				if(crvtrno>0){
					String strupdatecrvjv="update my_jvtran set rdocno="+docno+",rtype='TNC' where tr_no="+crvtrno;
					int updatecrvjv=stmt.executeUpdate(strupdatecrvjv);
					if(updatecrvjv<=0){
						errorstatus=1;
					}
				}
				String ssq11="update rl_tncpayment set refno="+request.getAttribute("tranno1").toString()+"  where doc_no in ("+strCash.substring(0, strCash.length()-1)+") ";				
				//System.out.println("=main 1="+ssq11);
				stmt.executeUpdate(ssq11);
			}
		}
		 
		String chqno="", chq="" ;
		double brvamount=0.00;
		
		String pp0="",pp1="",pp2="",pp3="",pp4="",pp5="",pp6="",pp7="",pp8="",pp9="",pp10="",pp11="",pp12="";
		int no=0;
		ArrayList<String> brvarray=new ArrayList();
		ArrayList<String> unclearedchequereceiptarray=new ArrayList();
		String strgetbrv="select concat('TA -',rdocno,'',desc1,'-',round(sum(pamount),2)) clientbrvdesc,rdocno,desc1,notes,sum(pamount) amount,replace(if(coalesce(chqno,0)='',0,chqno),',',' ') chqno,date_format(date,'%d.%m.%Y') date from rl_tncpayment where rdocno="+docno+" and payment='Bank' and paidto='Self' group by chqno,date";
		System.out.println("==brvarray=="+strgetbrv);
		//System.out.println("==propmanage=="+propmanage);
		ResultSet rsgetbrv=stmt.executeQuery(strgetbrv);
		while(rsgetbrv.next()){
			//if((propmanage==1 && (rsgetbrv.getString("desc1").equalsIgnoreCase("Rental Value") || rsgetbrv.getString("desc1").equalsIgnoreCase("Security deposit")))||(!rsgetbrv.getString("desc1").equalsIgnoreCase("Rental Value") && !rsgetbrv.getString("desc1").equalsIgnoreCase("Security deposit"))){
			if((propmanage==1 && (rsgetbrv.getString("desc1").equalsIgnoreCase("Rental Value") || rsgetbrv.getString("desc1").equalsIgnoreCase("Security deposit") || rsgetbrv.getString("desc1").equalsIgnoreCase("Electricity") || rsgetbrv.getString("desc1").equalsIgnoreCase("Gas") || rsgetbrv.getString("desc1").equalsIgnoreCase("Chiller") || rsgetbrv.getString("desc1").equalsIgnoreCase("Others")))||(!rsgetbrv.getString("desc1").equalsIgnoreCase("Rental Value") && !rsgetbrv.getString("desc1").equalsIgnoreCase("Security deposit") && !rsgetbrv.getString("desc1").equalsIgnoreCase("Electricity") && !rsgetbrv.getString("desc1").equalsIgnoreCase("Gas") && !rsgetbrv.getString("desc1").equalsIgnoreCase("Chiller") && !rsgetbrv.getString("desc1").equalsIgnoreCase("Others"))){
				brvarray.add(rsgetbrv.getString("desc1")+" :: "+rsgetbrv.getDouble("amount")+" :: "+rsgetbrv.getString("date")+" :: "+rsgetbrv.getString("chqno")+" :: "+rsgetbrv.getString("clientbrvdesc"));	
			}
			
		}
		for(int i=0;i<brvarray.size();i++){
			System.out.println("BRV ARRAY:"+brvarray.get(i));
			String brvdesc=brvarray.get(i).split("::")[0].trim();
			double brvamt=Double.parseDouble(brvarray.get(i).split("::")[1].trim());
			String strbrvdate=brvarray.get(i).split("::")[2].trim();
			String brvchequeno=brvarray.get(i).split("::")[3].trim();
			mdate=ClsCommon.changeStringtoSqlDate(brvarray.get(i).split("::")[2]);
			String strbrvdescription=brvarray.get(i).split("::")[4].trim();
			bankreceiptarray.add(bankacno+"::"+bankcurid+"::"+bankrate+"::false::"+objcommon.Round(brvamt,2)+"::"+strbrvdescription+"::"+objcommon.Round(brvamt,2)+"::0::0::0::"+1+"::"+pdcacno);			 
			bankreceiptarray.add(clacno+"::"+clcurId+"::"+clrate+"::true::"+objcommon.Round(brvamt,2)*-1+"::"+strbrvdescription+"::"+objcommon.Round(brvamt,2)*-1+"::"+0+"::0::0::"+1+"::"+pdcacno);
			
			unclearedchequereceiptarray.add(bankacno+"::"+bankcurid+"::"+bankrate+"::false::"+objcommon.Round(brvamt,2)+"::"+strbrvdescription+"::"+objcommon.Round(brvamt,2)+"::0::0::0 ");			 
			unclearedchequereceiptarray.add(clacno+"::"+clcurId+"::"+clrate+"::true::"+objcommon.Round(brvamt,2)*-1+"::"+strbrvdescription+"::"+objcommon.Round(brvamt,2)*-1+"::0::0::0");
			//newTextBox.val(rows[i].docno+":: "+rows[i].currencyid+":: "+rows[i].rate+":: "+rows[i].dr+":: "+amount+":: "+rows[i].description+":: "+baseamount+":: "+rows[i].costtype+":: "+rows[i].costcode);
			no=0;
			String sqlss=" select DATEDIFF( '"+cdate+"','"+mdate+"') val     "  ;
			//System.out.println("==sqlss=="+sqlss);
			ResultSet rs111 = stmt.executeQuery(sqlss);
			
			if(rs111.next()) 
			{					 
				no=rs111.getInt("val"); 
			} 
			 if(no<0)
			 {
				 chckpdc=1;
			 }			 
			 //Update on 01-04-2020 -Skype
			 chckpdc=1;
			 
			 int doc=0,mthd=0,ucrdoc=0;
			 
			 String sqltst="select method from gl_config where field_nme='tenancycontractpostinginsert'";
			 //System.out.println("==in sqltst=="+sqltst);
			 ResultSet rs222 = stmt.executeQuery(sqltst);
			 if(rs222.next()) 
				{
				 mthd=rs222.getInt("method");
				}
			 
			 //System.out.println("==in sqltst==value=="+mthd);
			if(mthd==1){
				String oldbrhid=session.getAttribute("BRANCHID").toString();
				//System.out.println(redirectbrhid+"::"+p0+"::"+propmanage);
				if(redirectbrhid>0 && ((p0.trim().equalsIgnoreCase("Commision") && propmanage==1) || (propmanage==0 && (p0.trim().equalsIgnoreCase("Commision") || p0.trim().equalsIgnoreCase("Ejari") || p0.trim().equalsIgnoreCase("Admin Fee"))))){
					session.setAttribute("BRANCHID",redirectbrhid);
				}
				else{
					session.setAttribute("BRANCHID",oldbrhid);
				}
				ucrdoc=unclearedreceiptDAO.insert(cdate, "UCR", "", 1.0, mdate, brvchequeno, "", chckpdc, strbrvdescription, objcommon.Round(brvamt,2), clacno, unclearedchequereceiptarray, session, request, "A");
				//System.out.println("==in unclearedreceiptDAOinsert==");
				session.setAttribute("BRANCHID",oldbrhid);
			}else{
				String oldbrhid=session.getAttribute("BRANCHID").toString();
				System.out.println("BRANCH check:"+oldbrhid+"::"+redirectbrhid);
				System.out.println("Checking:"+redirectbrhid+"::"+brvdesc+"::"+propmanage);
				
				if(redirectbrhid>0 && brvdesc.trim().equalsIgnoreCase("Commision") && propmanage==1){
					session.setAttribute("BRANCHID",redirectbrhid);
				}
				else if(redirectbrhid>0 && propmanage==0 && (brvdesc.trim().equalsIgnoreCase("Commision") || brvdesc.trim().equalsIgnoreCase("Ejari")  || brvdesc.trim().equalsIgnoreCase("Admin Fee"))){
					session.setAttribute("BRANCHID",redirectbrhid);
				}
				else{
					session.setAttribute("BRANCHID",oldbrhid);
				}
				//if(redirectbrhid>0 && ((brvdesc.trim().equalsIgnoreCase("Commision") && propmanage==1) || (propmanage==0 && (brvdesc.trim().equalsIgnoreCase("Commision") || brvdesc.trim().equalsIgnoreCase("Ejari") || brvdesc.trim().equalsIgnoreCase("Admin Fee"))))){
					
				//}
				
				System.out.println("Selected Branch"+session.getAttribute("BRANCHID").toString());
				doc=bankReceiptDAO.insert(conn,cdate,"BRV","",1.0,mdate,brvchequeno,"",chckpdc,strbrvdescription,objcommon.Round(brvamt,2),clacno,0,bankreceiptarray,tarr,session,request,"A");
				//System.out.println("==in bankReceiptinsert==");
				session.setAttribute("BRANCHID",oldbrhid);
			}
			 
			
			/* insert(Date unclearedChequeReceiptDate, String formdetailcode,String txtrefno, double txtfromrate, Date chequeDate, String txtchequeno, String txtchequename, int chckpdc, 
					  String txtdescription, double txtdrtotal, int txttodocno, ArrayList<String> unclearedchequereceiptarray, HttpSession session, HttpServletRequest request, String mode) 
			 */		
			bankreceiptarray.clear();
			unclearedchequereceiptarray.clear();
			if(ucrdoc<0)
			{
				System.out.println("Tenancy Contract UCR Insert Error ");
				errorstatus=1;
				id2=1;
			}
			if(doc<0)
			{
				System.out.println("Tenancy Contract BRV Insert Error ");
				errorstatus=1;
				id2=1;
			}		 
			if(doc>0)
			{
				if(errormsg.equalsIgnoreCase("")){
					errormsg="BRV #"+doc;
				}
				else{
					errormsg=errormsg+","+"BRV #"+doc;
				}
				int brvtrno=Integer.parseInt(request.getAttribute("tranno")==null?"0":request.getAttribute("tranno").toString());
				if(brvtrno>0){
					String strupdatebrvjv="update my_jvtran set rdocno="+docno+",rtype='TNC' where tr_no="+brvtrno;
					int updatebrvjv=stmt.executeUpdate(strupdatebrvjv);
					if(updatebrvjv<=0){
						errorstatus=1;
					}
				}
				
				String ssq111="update rl_tncpayment set refno="+request.getAttribute("tranno").toString()+"  where payment='Bank' and paidto='Self' and date='"+mdate+"' and chqno='"+brvchequeno+"'";
				System.out.println("=main 2="+ssq111);
				stmt.executeUpdate(ssq111);
			}
			
			if(ucrdoc>0)
			{
				
				if(errormsg.equalsIgnoreCase("")){
					errormsg="UCR #"+ucrdoc;
				}
				else{
					errormsg=errormsg+","+"UCR #"+ucrdoc;
				}
			
			}
		}
		/* for(int k1=0;k1<proday1.size();k1++)
		{
			 String[] prod1=((String) proday1.get(k1)).split("::"); 
			 
			 System.out.println("prod1 brv array=="+proday1);
			 
			 mdate=ClsCommon.changeStringtoSqlDate(prod1[1]); 
			  
			 if(prod1[10].equalsIgnoreCase("222"))// Bank reciept
			 { 		
				bankreceiptarray.add(prod1[7]+"::"+prod1[8]+"::"+prod1[9]+"::false::"+objcommon.Round(Double.parseDouble(prod1[2]),2)+":: TA-"+docno+","+prod1[0]+"::"+objcommon.Round(Double.parseDouble(prod1[2]),2)+"::0::0::0::"+0+"::"+0);			 
				bankreceiptarray.add(clacno+"::"+clcurId+"::"+clrate+"::true::"+objcommon.Round(Double.parseDouble(prod1[2]),2)*-1+":: TA-"+docno+","+prod1[0]+"::"+objcommon.Round(Double.parseDouble(prod1[2]),2)*-1+"::"+0+"::0::0::"+0+"::"+0);
				 
				no=0;
				String sqlss=" select DATEDIFF( '"+cdate+"','"+mdate+"') val     "  ;
				System.out.println("==sqlss=="+sqlss);
				ResultSet rs111 = stmt.executeQuery(sqlss);
				
				if(rs111.next()) 
				{					 
					no=rs111.getInt("val"); 
				} 
				 if(no<0)
				 {
					 chckpdc=1;
				 }			 
				 //Update on 01-04-2020 -Skype
				 chckpdc=1;
				int doc=bankReceiptDAO.insert(conn,cdate,"BRV","",1.0,mdate,prod1[4],"",chckpdc,("TA-"+docno+","+prod1[0]),objcommon.Round(Double.parseDouble(prod1[2]),2),clacno,0,bankreceiptarray,tarr,session,request,"A");
				bankreceiptarray.clear();
				
				if(doc<=0)
				{
					System.out.println("Tenancy Contract BRV Insert Error ");
					errorstatus=1;
					id2=1;
				}		 
				if(doc>0)
				{
					if(errormsg.equalsIgnoreCase("")){
						errormsg="BRV #"+doc;
					}
					else{
						errormsg=errormsg+","+"BRV #"+doc;
					}
					int brvtrno=Integer.parseInt(request.getAttribute("tranno")==null?"0":request.getAttribute("tranno").toString());
					if(brvtrno>0){
						String strupdatebrvjv="update my_jvtran set rdocno="+docno+",rtype='TNC' where tr_no="+brvtrno;
						int updatebrvjv=stmt.executeUpdate(strupdatebrvjv);
						if(updatebrvjv<=0){
							errorstatus=1;
						}
					}
					
					String ssq111="update rl_tncpayment set refno="+request.getAttribute("tranno").toString()+"  where doc_no="+prod1[11]+" ";
					System.out.println("=main 2="+ssq111);
					stmt.executeUpdate(ssq111);
				}
							 
				} 
			    
		 } */
			 
		 
			for(int k1=0;k1<proday1.size();k1++)
			{
				String[] prod1=((String) proday1.get(k1)).split("::"); 
		 
				 if(prod1[10].equalsIgnoreCase("333"))
					{
				  
				//System.out.println("------lbrtotalcost--"+lbrtotalcost);
			 	//if((propmanage==1 && (prod1[0].equalsIgnoreCase("Rental Value") || prod1[0].equalsIgnoreCase("Security deposit")))||(!prod1[0].equalsIgnoreCase("Rental Value") && !prod1[0].equalsIgnoreCase("Security deposit"))){
			 	if((propmanage==1 && (prod1[0].equalsIgnoreCase("Rental Value") || prod1[0].equalsIgnoreCase("Security deposit") || prod1[0].equalsIgnoreCase("Electricity") || prod1[0].equalsIgnoreCase("Gas") || prod1[0].equalsIgnoreCase("Chiller") || prod1[0].equalsIgnoreCase("Others")))||(!prod1[0].equalsIgnoreCase("Rental Value") && !prod1[0].equalsIgnoreCase("Security deposit") && !prod1[0].equalsIgnoreCase("Electricity") && !prod1[0].equalsIgnoreCase("Gas") && !prod1[0].equalsIgnoreCase("Chiller") && !prod1[0].equalsIgnoreCase("Others"))){	
			 		labarray.add(owacno+":: TA-"+docno+","+prod1[0]+","+prod1[4]+","+prod1[1]+","+prod1[13]+"::"+session.getAttribute("CURRENCYID").toString()+"::"+owrate+"::"+objcommon.Round(Double.parseDouble(prod1[2]),2)
						+"::"+objcommon.Round(Double.parseDouble(prod1[2]),2)*owrate+"::"+"1"+"::"+"1"+"::0::0::");	
			 	
					labarray.add(clacno+":: TA-"+docno+","+prod1[0]+","+prod1[4]+","+prod1[1]+","+prod1[13]+"::"+session.getAttribute("CURRENCYID").toString()+"::"+clrate+"::"+objcommon.Round(Double.parseDouble(prod1[2]),2)*-1
						+"::"+objcommon.Round(Double.parseDouble(prod1[2]),2)*clrate*-1+"::"+"1"+"::"+"-1"+"::0::0::");
				 
				System.out.println("------------"+labarray);
		
			 	garrageval=Double.parseDouble(prod1[2])*-1;
			
			 	String oldbrhid=session.getAttribute("BRANCHID").toString();
				if(redirectbrhid>0 && ((prod1[0].trim().equalsIgnoreCase("Commision") && propmanage==1) || (propmanage==0 && (prod1[0].trim().equalsIgnoreCase("Commision") || prod1[0].trim().equalsIgnoreCase("Ejari") || prod1[0].trim().equalsIgnoreCase("Admin Fee"))))){
					session.setAttribute("BRANCHID",redirectbrhid);
				}
				else{
					session.setAttribute("BRANCHID",oldbrhid);
				}
				int jvmdoc=save.insertjv(conn,cdate,"JVT",""+docno,"TA-"+voc_no+","+prod1[0]+","+prod1[4]+","+prod1[1]+","+prod1[13],garrageval,garrageval,labarray,session,request);
				labarray.clear();
				session.setAttribute("BRANCHID",oldbrhid);
				if(jvmdoc<=0)
				{
					System.out.println("Tenancy Contract JVT Insert Error ");
					errorstatus=1;
					id3=1;
				}
				if(jvmdoc>0)
				{
					if(errormsg.equalsIgnoreCase("")){
						errormsg="JVT #"+jvmdoc;
					}
					else{
						errormsg=errormsg+","+"JVT #"+jvmdoc;
					}
					String strupdatejv="update my_jvtran set duedate=date,rdocno="+docno+",rtype='TNC' where tr_no="+request.getAttribute("tranno2").toString();
					System.out.println("=main 3="+strupdatejv);
					int updatejv=stmt.executeUpdate(strupdatejv);
					if(updatejv<=0){
						errorstatus=1;
					}
					String ssq1111="update rl_tncpayment set refno="+request.getAttribute("tranno2").toString()+"  where doc_no="+prod1[11]+" ";
					System.out.println("=main 3="+ssq1111);
					int updatepayment=stmt.executeUpdate(ssq1111);					 
					if(updatepayment<=0){
						errorstatus=1;
					}
					
				} 				
			} 
					}
					}
		if(errorstatus==0){
			String strupdatereciept="update rl_tncm set recieptstatus=1 where doc_no="+docno;
			int updatereciept=stmt.executeUpdate(strupdatereciept);
			if(updatereciept<=0){
				errorstatus=1;
			}
		}
		JSONObject objmsg=new JSONObject();
		JSONArray msgarray=new JSONArray();
		String strgetvocno="SELECT br.BRANCHNAME,COALESCE(REPLACE(GROUP_CONCAT(CONCAT(jv.dtype,' ',jv.doc_no)),',','#'),'') vocno FROM my_brch br INNER JOIN (SELECT jv.doc_no,jv.dTYPE,jv.brhid,jv.tr_no FROM rl_tncpayment pyt LEFT JOIN my_jvtran jv ON pyt.refno=jv.tr_no WHERE pyt.rdocno="+docno+" GROUP BY jv.tr_no) jv ON br.DOC_NO=jv.brhid GROUP BY jv.brhid order by jv.brhid,jv.tr_no";
		System.out.println(strgetvocno);
		ResultSet rsgetvocno=conn.createStatement().executeQuery(strgetvocno);
		while(rsgetvocno.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("branchname", rsgetvocno.getString("branchname"));
			objtemp.put("vocno", rsgetvocno.getString("vocno"));
			msgarray.add(objtemp);
		}	
		objmsg.put("msgdata", msgarray);
		if(errorstatus==0){
			errormsg="Successfully Generated "+errormsg;
			conn.commit();
		}
		else{
			errormsg="Not Updated";
		}
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
