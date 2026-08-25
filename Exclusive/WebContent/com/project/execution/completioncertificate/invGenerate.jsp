<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.project.execution.projectInvoice.ClsProjectInvoiceDAO"%>
<% 
 String cval =request.getParameter("cval")==null?"0":request.getParameter("cval").toString();
 String ctotinv =request.getParameter("ctotinv")==null?"0":request.getParameter("ctotinv").toString();
 String tobeinvoiced =request.getParameter("tobeinvoiced")==null?"0":request.getParameter("tobeinvoiced").toString();
 String retnamt =request.getParameter("retnamt")==null?"0":request.getParameter("retnamt").toString();
 String invdates =request.getParameter("invdates")==null?"0":request.getParameter("invdates").toString();
 String invdescp =request.getParameter("invdescp")==null?"0":request.getParameter("invdescp").toString();
 String ccdocno =request.getParameter("docno")==null?"0":request.getParameter("docno").toString(); 
 String contrno =request.getParameter("contrno")==null?"0":request.getParameter("contrno").toString(); 

 Connection conn = null;
 ClsConnection ClsConnection=new ClsConnection();
 ClsCommon ClsCommon=new ClsCommon();
 
 String inv="0";
 double taxamt=0.0,taxtot=0.0;
 String inctax="0",nontax="0",client="",contrtype="",clientdet="",branchid="0",clacno="0",exptotal="0.0",pdid="0",ptype="",schid="0";
 int clientid=0,costid=0,contractno=0;	

 try{
		ClsProjectInvoiceDAO DAO= new ClsProjectInvoiceDAO();
		ArrayList taxlist = new ArrayList();
		ArrayList<String> enqarray= new ArrayList();
		ArrayList<String> exparray = new ArrayList();

		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		java.sql.Date invdate=null;
		if(!(invdates.equalsIgnoreCase("0") || invdates.equalsIgnoreCase("undefined") || invdates.equalsIgnoreCase("a") )){
			invdate = ClsCommon.changeStringtoSqlDate(invdates);
		}
		int rs=0;
		
		String str1Sql=("update cm_compcert set pytval="+cval+", totinv="+ctotinv+", inv="+tobeinvoiced+", invdt='"+invdate+"',invdesc='"+invdescp+"', rententionamt="+retnamt+" where doc_no="+ccdocno+" ");
		int val=stmt.executeUpdate(str1Sql);
		
		if(val>0){
			inv="1";
		}

		String csql="select coalesce(cm.inctax,0) inctax,coalesce(ac.nontax,0) nontax,cm.dtype,cm.doc_no,ac.refname,cm.cldocno,ac.acno,cm.brhid from cm_srvcontrm cm left join my_acbook ac on cm.cldocno=ac.cldocno and ac.dtype='CRM' where cm.tr_no="+contrno+"";
		ResultSet rstrno = stmt.executeQuery(csql);
		while(rstrno.next()) {
			inctax=rstrno.getString("inctax");
			nontax=rstrno.getString("nontax");
			contrtype=rstrno.getString("dtype");
			contractno=rstrno.getInt("doc_no");
			client=rstrno.getString("refname");
			clientid=rstrno.getInt("cldocno");
			clacno=rstrno.getString("acno");
			branchid=rstrno.getString("brhid");
	   }

	if(nontax.equalsIgnoreCase("1")){

		if(inctax.equalsIgnoreCase("0")){
			taxlist=DAO.getTax(session,Double.parseDouble(tobeinvoiced),invdate,"0",clientid);
		} else if((inctax.equalsIgnoreCase("1"))){
			taxlist=DAO.getinclusiveTax(session,Double.parseDouble(tobeinvoiced),invdate,"0",clientid);
		}

	for(int t=0;t<taxlist.size();t++){

		String[] tmp=((String) taxlist.get(t)).split("::");

		//System.out.println("==tmp===="+tmp.length);

		taxamt=Double.parseDouble(tmp[3]);
		taxtot=taxtot+taxamt;

	}
}


	int insval=DAO.insert(invdate,"0",contrtype,contractno,client,"",invdescp,branchid,clacno,clientid,
	Integer.parseInt(contrno),enqarray,exparray,session,"A","PJIV",request,"0.0",tobeinvoiced,"0.0",inctax,schid,invdescp,"1",taxtot,taxlist,nontax);
	
	String docno=request.getAttribute("docno").toString();
	String jvtrno=request.getAttribute("jvtrno").toString();
	String refdetails="PJIV"+docno;
	int acnos=0;
	String curris="1";
	int jvinsval=0;
	String description=contrtype+"-"+contractno+","+invdescp;
	double rates=1;
	String sql2="select  acno from my_account where codeno='RETENTION' ";
	ResultSet tass1 = stmt.executeQuery (sql2);

	if (tass1.next()) {
		acnos=tass1.getInt("acno");
	}
	if(insval>0)
	{
	
		String jvupdatesql="update my_jvtran set dramount=dramount-"+tobeinvoiced+" ,ldramount=ldramount-"+tobeinvoiced+" where tr_no="+jvtrno+" and acno="+clacno+"";
		int jvupdval=stmt.executeUpdate(jvupdatesql);
		
		String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
				+ "values('"+invdate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+description+"','"+curris+"','"+rates+"',"+tobeinvoiced+","+tobeinvoiced+",0,1,5,0,0,"+clientid+",'"+rates+"',5,"+contrno+",'PJIV','"+branchid+"',"+jvtrno+",3)";
	
		jvinsval=stmt.executeUpdate(sql11);
	}

	if(jvinsval>0)
	{
		inv="1";
	}
		
	response.getWriter().write(inv+"###"+inv+"###"+docno);
		
	stmt.close();
	conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	} finally{
		conn.close();
	}
  %>
  