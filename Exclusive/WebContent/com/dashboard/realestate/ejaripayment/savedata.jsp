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
<%@page import="com.finance.transactions.cashpayment.ClsCashPaymentDAO"%>
<%@page import="com.finance.transactions.bankreceipt.*"%>
<%@page import="com.finance.transactions.journalvouchers.ClsJournalVouchersDAO"%> 
<%@page import="com.dashboard.realestate.tenancycontractposting.ClsTenancyContractPostingDAO"%>

<%	
	String docno=request.getParameter("docno");
	String branchids=request.getParameter("branchids");
	String description=request.getParameter("desc");
	String podate=request.getParameter("podate");
	int errorstatus=0;
	Double tot=request.getParameter("totsum")==null?0.0:Double.parseDouble(request.getParameter("totsum").toString());
	String cash=request.getParameter("cashacno")==null?"0":request.getParameter("cashacno");
	String casharray=request.getParameter("agentarray")==null?"":request.getParameter("agentarray");
	ArrayList<String> stparray=new ArrayList();
	String temparray[]=casharray.split(",");
	int aa =0;
	for(int i=0;i<temparray.length;i++){
		stparray.add(temparray[i]);
	}
	
	ClsCashPaymentDAO cashPayDAO= new ClsCashPaymentDAO();
	ClsJournalVouchersDAO journalVouchersDAO= new ClsJournalVouchersDAO();
	ClsPropertyInvoiceDAO propertyinvdao= new ClsPropertyInvoiceDAO(); 
	ClsBankReceiptDAO bankReceiptDAO=new ClsBankReceiptDAO();
	ClsCommon objcommon=new ClsCommon();
	ClsTenancyContractPostingDAO save = new ClsTenancyContractPostingDAO();
	String refrowno="0";
	String trno="0",doc="0";
	Connection conn=null;
	int val=0;
	 
	try{
		ClsConnection ClsConnection =new ClsConnection();
		ClsCommon ClsCommon=new ClsCommon();
		java.sql.Date sqlprocessdate=null;
		
		conn = ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmt = conn.createStatement ();
		
		ArrayList<String> applyinvoicearray= new ArrayList<String>();
		ArrayList<String> cashpaymentarray= new ArrayList<String>();
				
		String sqlConfig="select method from gl_config where field_nme='EjariMultiplePayment';";
		ResultSet rsConfig = stmt.executeQuery(sqlConfig);
		int cashPayConfig=0;
		while (rsConfig.next()) {
			cashPayConfig=rsConfig.getInt("method");
		}
		cashpaymentarray.add(cash+"::"+"1"+"::"+"1.0"+"::"+"false"+"::"+tot*-1+"::"+description+"::"+tot*-1+"::"+"0"+"::"+"0"+"::"+"0"+"::");
		cashpaymentarray.add("0"+"::"+"1"+"::"+"1.0"+"::"+"true"+"::"+"0.0"+"::"+description+"::"+"0.0"+"::"+"0.0"+"::"+"0"+"::"+"0"+"::");
		
		if(cashPayConfig==0){
			cashpaymentarray.add("17914"+"::"+"1"+"::"+"1"+"::"+"true"+"::"+tot+"::"+description+"::"+tot+"::0:: :: ::");
		}else{				
			for(int i=0;i<stparray.size();i++){
				String[] ar11 = ((String) stparray.get(i)).split("::");
				if (!(ar11[0].trim().equalsIgnoreCase("undefined") || ar11[0].trim().equalsIgnoreCase("0") || ar11[0].trim().equalsIgnoreCase("") || ar11[0].trim().equalsIgnoreCase("NaN") || ar11[0].isEmpty())) {
					String descriptiond="TC : "+ar11[2].trim()+" - "+ar11[3].trim();
					cashpaymentarray.add("17914"+"::"+"1"+"::"+"1"+"::"+"true"+"::"+ar11[1].trim()+"::"+descriptiond+"::"+ar11[1].trim()+"::0:: :: ::");
				}
			}		
		}				
		
		System.out.println("cashpaymentarray====="+cashpaymentarray);
		String upsql=null;
		
		int id1=0;
		int id2=0;
		int id3=0;
		
		double ownertotal=0.0;
		double selftotal=0.0;
		
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
		
	   System.out.println("=====ejaricashinsert====="+ cdate+","+ "CPV"+","+ ""+","+ 1.0+","+ description+","+ tot+","+ 0.0+","+ cashpaymentarray+","+ applyinvoicearray+","+ session+","+ request+","+ "A");
	   val=cashPayDAO.insert(cdate, "CPV", "", 1.0, description, tot, 0.0, cashpaymentarray, applyinvoicearray, session, request, "A")	;		 
	   trno=request.getAttribute("tranno").toString(); 
	   doc=request.getAttribute("cashpaydoc").toString();
	   System.out.println("doccccccc======="+doc);
	   
	   //System.out.println("gridarr======="+stparray.size());
	   
	   if(Integer.parseInt(trno)>0){
	   
	    for(int i=0;i<stparray.size();i++){
			 
			String docno11="0";
			String[] ar11 = ((String) stparray.get(i)).split("::");
			if (!(ar11[0].trim().equalsIgnoreCase("undefined") || ar11[0].trim().equalsIgnoreCase("0") || ar11[0].trim().equalsIgnoreCase("") || ar11[0].trim().equalsIgnoreCase("NaN") || ar11[0].isEmpty())) {
				docno11=(ar11[0].trim().equalsIgnoreCase("undefined") || ar11[0].trim().equalsIgnoreCase("") || ar11[0].trim().equalsIgnoreCase("NaN") || ar11[0].isEmpty() ? 0: ar11[0].trim()).toString();
			    
				String sqltsttt="update rl_tncterms set paytrno="+trno+" where rdocno="+docno11+"";
				System.out.println("sqltst======="+sqltsttt);
				val = stmt.executeUpdate(sqltsttt);
				
				if(val>0){
					String sqlBrhId="select brhid from rl_tncm where doc_no="+docno11;
					ResultSet rsBrhId = stmt.executeQuery(sqlBrhId);
					int brhId=0;
					while (rsBrhId.next()) {
						brhId=rsBrhId.getInt("brhid");
					}
					
					String sql2="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,description) values("+docno11+","+brhId+",'EJPT',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','CPU Created')";   
					int val2 = stmt.executeUpdate(sql2);
				}		
				
			}
					
			} 
	   }
	   
	  // System.out.println("id1===="+id1+"======="+val);
	   if(val>0){
		  // System.out.println("id1==commit=="+id1+"======="+val);
		   conn.commit();
		   errorstatus=1;
	   }
	   

		response.getWriter().print(val+"##"+doc);
	}
	 catch(Exception e)
	 {
		 e.printStackTrace();
		 conn.close();
		 response.getWriter().print(val+"##"+doc);
	 }
	finally{
		conn.close();
	}
	 
	 
	%>
