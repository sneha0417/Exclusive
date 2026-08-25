package com.project.execution.jobContract;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpRequest;
import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.project.execution.serviceContract.ClsServiceContractDAO;

public class ClsJobContractAction {

	ClsCommon com=new ClsCommon();
	ClsJobContractBean bean=new ClsJobContractBean();
	private String txtbudget;
	
	public String getTxtbudget() {
		return txtbudget;
	}
	public void setTxtbudget(String txtbudget) {
		this.txtbudget = txtbudget;
	}
	private String docno;
	private String date;
	private String txtrefno;
	private String txtclient;
	private String txtclientdet;
	private String txtmob1;
	private String txtmob2;
	private String txtemail;
	private String txtcontact;
	private String cmbreftype;
	private String hidcmbreftype;
	private String rrefno;
	private String txtcntrval;
	private String txttaxper;
	private int islegaldoc;
	private String temp1;
	private String temp2;
	private String stdate;
	private String enddate;
	
	private String wstdate;
	private String wenddate;
	
	private String incentive;
	private String salesincentive;
	private String installments;
	private String cmbpaytype;
	private String hidcmbpaytype;
	private String finsdate;
	private String srvcinterval;
	private String cmbsrvctype;
	private String hidcmbsrvctype;
	private String serdate;
	private String mode;
	private String msg;
	private String deleted;
	private String formdetailcode;
	private String serdueafter;
	private String paydueafter;
	private String txtsalman;
	private String url;

	private int masterdoc_no;
	private int refmasterdoc_no;
	private int serviceSchedulelen;
	private int servicelen;
	private int paymentlen;
	private int sitelen;
	private int clientid;
	private int cpersonid;
	private int isproformainv;
	private int salid;
	private int editval;
	private int chkserv;
	private int chkinv;
	

	private String lblcompname;
	private String lblcompaddress;
	private String lblprintname;
	private String lblcomptel;
	private String lblcompfax;
	private String lblprintname1;
	private String lblbranch;
	private String lbllocation;
	private String amountwords;
	private String lblcheckedby;
	private String lblfinaldate;
	private String txtheader;

	private ArrayList list;
	private ArrayList termlist;
	private ArrayList sitelist;
	private ArrayList serlist;
	private ArrayList schlist;
	private ArrayList paylist;
	
	 private int cmbprocess;
	 
	 private int hidcmbprocess;
	 private String hidbrhid;
	 private String txtsplinstruct;
	 private String cmbprog;
		private String txtprogperiod;
		private String txtprogper;
		private String hidcmbprog;
		
		public String getHidcmbprog() {
			return hidcmbprog;
		}
		public void setHidcmbprog(String hidcmbprog) {
			this.hidcmbprog = hidcmbprog;
		}
		public String getCmbprog() {
			return cmbprog;
		}
		public void setCmbprog(String cmbprog) {
			this.cmbprog = cmbprog;
		}
		public String getTxtprogperiod() {
			return txtprogperiod;
		}
		public void setTxtprogperiod(String txtprogperiod) {
			this.txtprogperiod = txtprogperiod;
		}
		public String getTxtprogper() {
			return txtprogper;
		}
		public void setTxtprogper(String txtprogper) {
			this.txtprogper = txtprogper;
		}
		public String getTxtsplinstruct() {
			return txtsplinstruct;
		}
		public void setTxtsplinstruct(String txtsplinstruct) {
			this.txtsplinstruct = txtsplinstruct;
		}
	 public String getHidbrhid() {
		return hidbrhid;
	}
	public void setHidbrhid(String hidbrhid) {
		this.hidbrhid = hidbrhid;
	}
	public int getChkserv() {
			return chkserv;
		}
		public void setChkserv(int chkserv) {
			this.chkserv = chkserv;
		}
		public int getChkinv() {
			return chkinv;
		}
		public void setChkinv(int chkinv) {
			this.chkinv = chkinv;
		}

		public int getHidcmbprocess() {
		return hidcmbprocess;
	}
	public void setHidcmbprocess(int hidcmbprocess) {
		this.hidcmbprocess = hidcmbprocess;
	}
		public int getCmbprocess() {
		return cmbprocess;
	}
	public void setCmbprocess(int cmbprocess) {
		this.cmbprocess = cmbprocess;
	}
	
	public ArrayList getSerlist() {
		return serlist;
	}
	public void setSerlist(ArrayList serlist) {
		this.serlist = serlist;
	}
	public ArrayList getSchlist() {
		return schlist;
	}
	public void setSchlist(ArrayList schlist) {
		this.schlist = schlist;
	}
	public ArrayList getPaylist() {
		return paylist;
	}
	public void setPaylist(ArrayList paylist) {
		this.paylist = paylist;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getLblcompname() {
		return lblcompname;
	}
	public void setLblcompname(String lblcompname) {
		this.lblcompname = lblcompname;
	}
	public String getLblcompaddress() {
		return lblcompaddress;
	}
	public void setLblcompaddress(String lblcompaddress) {
		this.lblcompaddress = lblcompaddress;
	}
	public String getLblprintname() {
		return lblprintname;
	}
	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}
	public String getLblcomptel() {
		return lblcomptel;
	}
	public void setLblcomptel(String lblcomptel) {
		this.lblcomptel = lblcomptel;
	}
	public String getLblcompfax() {
		return lblcompfax;
	}
	public void setLblcompfax(String lblcompfax) {
		this.lblcompfax = lblcompfax;
	}
	public String getLblprintname1() {
		return lblprintname1;
	}
	public void setLblprintname1(String lblprintname1) {
		this.lblprintname1 = lblprintname1;
	}
	public String getLblbranch() {
		return lblbranch;
	}
	public void setLblbranch(String lblbranch) {
		this.lblbranch = lblbranch;
	}
	public String getLbllocation() {
		return lbllocation;
	}
	public void setLbllocation(String lbllocation) {
		this.lbllocation = lbllocation;
	}
	public String getAmountwords() {
		return amountwords;
	}
	public void setAmountwords(String amountwords) {
		this.amountwords = amountwords;
	}
	public String getLblcheckedby() {
		return lblcheckedby;
	}
	public void setLblcheckedby(String lblcheckedby) {
		this.lblcheckedby = lblcheckedby;
	}
	public String getLblfinaldate() {
		return lblfinaldate;
	}
	public void setLblfinaldate(String lblfinaldate) {
		this.lblfinaldate = lblfinaldate;
	}
	public String getTxtheader() {
		return txtheader;
	}
	public void setTxtheader(String txtheader) {
		this.txtheader = txtheader;
	}
	public ArrayList getList() {
		return list;
	}
	public void setList(ArrayList list) {
		this.list = list;
	}
	public ArrayList getTermlist() {
		return termlist;
	}
	public void setTermlist(ArrayList termlist) {
		this.termlist = termlist;
	}
	public ArrayList getSitelist() {
		return sitelist;
	}
	public void setSitelist(ArrayList sitelist) {
		this.sitelist = sitelist;
	}
	public int getEditval() {
		return editval;
	}
	public void setEditval(int editval) {
		this.editval = editval;
	}
	public String getHidcmbpaytype() {
		return hidcmbpaytype;
	}
	public void setHidcmbpaytype(String hidcmbpaytype) {
		this.hidcmbpaytype = hidcmbpaytype;
	}
	public String getHidcmbsrvctype() {
		return hidcmbsrvctype;
	}
	public void setHidcmbsrvctype(String hidcmbsrvctype) {
		this.hidcmbsrvctype = hidcmbsrvctype;
	}
	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getTxtrefno() {
		return txtrefno;
	}
	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
	}
	public String getTxtclient() {
		return txtclient;
	}
	public void setTxtclient(String txtclient) {
		this.txtclient = txtclient;
	}
	public String getTxtclientdet() {
		return txtclientdet;
	}
	public void setTxtclientdet(String txtclientdet) {
		this.txtclientdet = txtclientdet;
	}
	public String getTxtmob1() {
		return txtmob1;
	}
	public void setTxtmob1(String txtmob1) {
		this.txtmob1 = txtmob1;
	}
	public String getTxtmob2() {
		return txtmob2;
	}
	public void setTxtmob2(String txtmob2) {
		this.txtmob2 = txtmob2;
	}
	public String getTxtemail() {
		return txtemail;
	}
	public void setTxtemail(String txtemail) {
		this.txtemail = txtemail;
	}
	public String getTxtcontact() {
		return txtcontact;
	}
	public void setTxtcontact(String txtcontact) {
		this.txtcontact = txtcontact;
	}
	public String getCmbreftype() {
		return cmbreftype;
	}
	public void setCmbreftype(String cmbreftype) {
		this.cmbreftype = cmbreftype;
	}
	public String getRrefno() {
		return rrefno;
	}
	public void setRrefno(String rrefno) {
		this.rrefno = rrefno;
	}
	public String getTxtcntrval() {
		return txtcntrval;
	}
	public void setTxtcntrval(String txtcntrval) {
		this.txtcntrval = txtcntrval;
	}
	public String getTxttaxper() {
		return txttaxper;
	}
	public void setTxttaxper(String txttaxper) {
		this.txttaxper = txttaxper;
	}

	public int getIslegaldoc() {
		return islegaldoc;
	}
	public void setIslegaldoc(int islegaldoc) {
		this.islegaldoc = islegaldoc;
	}
	public String getTemp1() {
		return temp1;
	}
	public void setTemp1(String temp1) {
		this.temp1 = temp1;
	}
	public String getTemp2() {
		return temp2;
	}
	public void setTemp2(String temp2) {
		this.temp2 = temp2;
	}
	public String getStdate() {
		return stdate;
	}
	public void setStdate(String stdate) {
		this.stdate = stdate;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	
	public String getWstdate() {
		return wstdate;
	}
	public void setWstdate(String wstdate) {
		this.wstdate = wstdate;
	}
	public String getWenddate() {
		return wenddate;
	}
	public void setWenddate(String wenddate) {
		this.wenddate = wenddate;
	}
	public String getIncentive() {
		return incentive;
	}
	public void setIncentive(String incentive) {
		this.incentive = incentive;
	}
	public String getSalesincentive() {
		return salesincentive;
	}
	public void setSalesincentive(String salesincentive) {
		this.salesincentive = salesincentive;
	}
	public String getInstallments() {
		return installments;
	}
	public void setInstallments(String installments) {
		this.installments = installments;
	}
	public String getCmbpaytype() {
		return cmbpaytype;
	}
	public void setCmbpaytype(String cmbpaytype) {
		this.cmbpaytype = cmbpaytype;
	}
	public String getFinsdate() {
		return finsdate;
	}
	public void setFinsdate(String finsdate) {
		this.finsdate = finsdate;
	}
	public String getSrvcinterval() {
		return srvcinterval;
	}
	public void setSrvcinterval(String srvcinterval) {
		this.srvcinterval = srvcinterval;
	}
	public String getCmbsrvctype() {
		return cmbsrvctype;
	}
	public void setCmbsrvctype(String cmbsrvctype) {
		this.cmbsrvctype = cmbsrvctype;
	}
	public String getSerdate() {
		return serdate;
	}
	public void setSerdate(String serdate) {
		this.serdate = serdate;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public int getRefmasterdoc_no() {
		return refmasterdoc_no;
	}
	public void setRefmasterdoc_no(int refmasterdoc_no) {
		this.refmasterdoc_no = refmasterdoc_no;
	}

	public int getServiceSchedulelen() {
		return serviceSchedulelen;
	}
	public void setServiceSchedulelen(int serviceSchedulelen) {
		this.serviceSchedulelen = serviceSchedulelen;
	}
	public int getServicelen() {
		return servicelen;
	}
	public void setServicelen(int servicelen) {
		this.servicelen = servicelen;
	}
	public int getPaymentlen() {
		return paymentlen;
	}
	public void setPaymentlen(int paymentlen) {
		this.paymentlen = paymentlen;
	}
	public int getSitelen() {
		return sitelen;
	}
	public void setSitelen(int sitelen) {
		this.sitelen = sitelen;
	}

	public int getClientid() {
		return clientid;
	}
	public void setClientid(int clientid) {
		this.clientid = clientid;
	}
	public int getCpersonid() {
		return cpersonid;
	}
	public void setCpersonid(int cpersonid) {
		this.cpersonid = cpersonid;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getSerdueafter() {
		return serdueafter;
	}
	public void setSerdueafter(String serdueafter) {
		this.serdueafter = serdueafter;
	}
	public String getPaydueafter() {
		return paydueafter;
	}
	public void setPaydueafter(String paydueafter) {
		this.paydueafter = paydueafter;
	}
	public int getIsproformainv() {
		return isproformainv;
	}
	public void setIsproformainv(int isproformainv) {
		this.isproformainv = isproformainv;
	}

	public String getHidcmbreftype() {
		return hidcmbreftype;
	}
	public void setHidcmbreftype(String hidcmbreftype) {
		this.hidcmbreftype = hidcmbreftype;
	}
	public String getTxtsalman() {
		return txtsalman;
	}
	public void setTxtsalman(String txtsalman) {
		this.txtsalman = txtsalman;
	}
	public int getSalid() {
		return salid;
	}
	public void setSalid(int salid) {
		this.salid = salid;
	}



private String legalchrg,sqtno;

public String getSqtno() {
	return sqtno;
}
public void setSqtno(String sqtno) {
	this.sqtno = sqtno;
}
public String getLegalchrg() {
	return legalchrg;
}
public void setLegalchrg(String legalchrg) {
	this.legalchrg = legalchrg;
}

	public String saveAction(){

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		String returns="";
		int val=0;

		System.out.println("inside saveaction");

		try{
			ArrayList paylist=new ArrayList();

			ArrayList servlist=new ArrayList();

			ArrayList sersclist=new ArrayList();

			ArrayList sitelist=new ArrayList();

			for(int i=0;i<getPaymentlen();i++){

				String temp=requestParams.get("pay"+i)[0];		
				paylist.add(temp);
			}

			for(int i=0;i<getServicelen();i++){

				String temp=requestParams.get("service"+i)[0];		
				servlist.add(temp);
			}

			for(int i=0;i<getServiceSchedulelen();i++){

				String temp=requestParams.get("sersc"+i)[0];		
				sersclist.add(temp);
			}

			System.out.println("===getSitelen()====="+getSitelen());

			for(int i=0;i<getSitelen();i++){
				String temp=requestParams.get("site"+i)[0];		
				sitelist.add(temp);
			}


			ClsJobContractDAO DAO=new ClsJobContractDAO();

			if(mode.equalsIgnoreCase("A")){

				java.sql.Date date=com.changeStringtoSqlDate(getDate());
				java.sql.Date stdate=com.changeStringtoSqlDate(getStdate());
				java.sql.Date enddate=com.changeStringtoSqlDate(getEnddate());
				
				java.sql.Date wstdate=com.changeStringtoSqlDate(getWstdate());
				java.sql.Date wenddate=com.changeStringtoSqlDate(getWenddate());
				
				java.sql.Date findate=com.changeStringtoSqlDate(getFinsdate());
				java.sql.Date serdate=com.changeStringtoSqlDate(getSerdate());




				val=DAO.insert(date,stdate,enddate,wstdate,wenddate,findate,serdate,getClientid(),getCpersonid(),
						getIslegaldoc(),getCmbreftype(),getRrefno(),getRefmasterdoc_no(),getTemp1(),
						getTemp2(),getSrvcinterval(),getTxttaxper(),getCmbpaytype(),getPaydueafter(),getInstallments(),
						getSerdueafter(),getCmbsrvctype(),getTxtcntrval(),getTxtbudget(),getIncentive(),getSalesincentive(),
						paylist,sitelist,servlist,sersclist,session,request,mode,getFormdetailcode(),getInstallments(),
						getSrvcinterval(),getIsproformainv(),getSalid(),getEditval(),getTxtrefno(),getCmbprocess(),getChkserv(),
						getChkinv(),getTxtsplinstruct(),getCmbprog(),getTxtprogperiod(),getTxtprogper());
				System.out.println(request.getAttribute("docNo"));
				int docno=0;
				if(request.getAttribute("docNo")!=null){
					docno=Integer.parseInt(request.getAttribute("docNo").toString());
				}

				if(val>0){
					setMasterdoc_no(docno);
					setDocno(val+"");
					setClientid(getClientid());
					setCpersonid(getCpersonid());
					setCmbpaytype(getCmbpaytype());
					setHidcmbpaytype(getCmbpaytype());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getCmbreftype());
					setCmbsrvctype(getCmbsrvctype());
					setHidcmbsrvctype(getCmbsrvctype());
					setDate(date+"");
					setEnddate(enddate+"");
					setFinsdate(findate+"");
					setIncentive(getIncentive());
					setInstallments(getInstallments());
					setIslegaldoc(getIslegaldoc());
					setMasterdoc_no(getMasterdoc_no());
					setPaydueafter(getPaydueafter());
					setRefmasterdoc_no(getRefmasterdoc_no());
					setRrefno(getRrefno());
					setSalesincentive(getSalesincentive());
					setSerdate(serdate+"");
					setSerdueafter(getSerdueafter());
					setSrvcinterval(getSrvcinterval());
					setStdate(stdate+"");
					setWstdate(wstdate+"");
					setWenddate(wenddate+"");
					setTemp1(getTemp1());
					setTemp2(getTemp2());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setTxtcntrval(getTxtcntrval());
					setTxtbudget(getTxtbudget());
					setTxtcontact(getTxtcontact());
					setTxtemail(getTxtemail());
					setTxtmob1(getTxtmob1());
					setTxtmob2(getTxtmob2());
					setTxtrefno(getTxtrefno());
					setTxttaxper(getTxttaxper());
					setRrefno(getRrefno());
					setRefmasterdoc_no(getRefmasterdoc_no());
					setCmbprocess(getCmbprocess());
					setHidcmbprocess(getCmbprocess());
					setChkserv(getChkserv());
					setChkinv(getChkinv());
					setTxtsplinstruct(getTxtsplinstruct());
					setCmbprog(getCmbprog());
					setHidcmbprog(getCmbprog());
					setTxtprogperiod(getTxtprogperiod());
					setTxtprogper(getTxtprogper());
					setMsg("Successfully Saved");
					returns="success";
				}
				else{

					setDocno(val+"");
					setClientid(getClientid());
					setCpersonid(getCpersonid());
					setCmbpaytype(getCmbpaytype());
					setHidcmbpaytype(getCmbpaytype());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getCmbreftype());
					setCmbsrvctype(getCmbsrvctype());
					setHidcmbsrvctype(getCmbsrvctype());
					setDate(date+"");
					setEnddate(enddate+"");
					setFinsdate(findate+"");
					setWstdate(wstdate+"");
					setWenddate(wenddate+"");
					setIncentive(getIncentive());
					setInstallments(getInstallments());
					setIslegaldoc(getIslegaldoc());
					setMasterdoc_no(getMasterdoc_no());
					setPaydueafter(getPaydueafter());
					setRefmasterdoc_no(getRefmasterdoc_no());
					setRrefno(getRrefno());
					setSalesincentive(getSalesincentive());
					setSerdate(serdate+"");
					setSerdueafter(getSerdueafter());
					setSrvcinterval(getSrvcinterval());
					setStdate(stdate+"");
					setTemp1(getTemp1());
					setTemp2(getTemp2());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setTxtcntrval(getTxtcntrval());
					setTxtbudget(getTxtbudget());
					setTxtcontact(getTxtcontact());
					setTxtemail(getTxtemail());
					setTxtmob1(getTxtmob1());
					setTxtmob2(getTxtmob2());
					setTxtrefno(getTxtrefno());
					setTxttaxper(getTxttaxper());
					setRrefno(getRrefno());
					setRefmasterdoc_no(getRefmasterdoc_no());
					setCmbprocess(getCmbprocess());
					setHidcmbprocess(getCmbprocess());
					setChkserv(getChkserv());
					setChkinv(getChkinv());
					setTxtsplinstruct(getTxtsplinstruct());
					setCmbprog(getCmbprog());
					setHidcmbprog(getCmbprog());
					setTxtprogperiod(getTxtprogperiod());
					setTxtprogper(getTxtprogper());
					setMsg("Not Saved");
					returns="fail";


				}

			}

			if(mode.equalsIgnoreCase("E")){

				java.sql.Date date=com.changeStringtoSqlDate(getDate());
				java.sql.Date stdate=com.changeStringtoSqlDate(getStdate());
				java.sql.Date enddate=com.changeStringtoSqlDate(getEnddate());
				
				java.sql.Date wstdate=com.changeStringtoSqlDate(getWstdate());
				java.sql.Date wenddate=com.changeStringtoSqlDate(getWenddate());
				
				java.sql.Date findate=com.changeStringtoSqlDate(getFinsdate());
				java.sql.Date serdate=com.changeStringtoSqlDate(getSerdate());




				val=DAO.edit(getMasterdoc_no(),Integer.parseInt(getDocno()),date,stdate,enddate,wstdate,wenddate,findate,serdate,getClientid(),getCpersonid(),
						getIslegaldoc(),getCmbreftype(),getRrefno(),getRefmasterdoc_no(),getTemp1(),
						getTemp2(),getSrvcinterval(),getTxttaxper(),getCmbpaytype(),getPaydueafter(),getInstallments(),
						getSerdueafter(),getCmbsrvctype(),getTxtcntrval(),getTxtbudget(),getIncentive(),getSalesincentive(),
						paylist,sitelist,servlist,sersclist,session,request,mode,getFormdetailcode(),getInstallments(),
						getSrvcinterval(),getIsproformainv(),getSalid(),getEditval(),getTxtrefno(),getCmbprocess(),getChkserv(),getChkinv(),
						getTxtsplinstruct(),getCmbprog(),getTxtprogperiod(),getTxtprogper());

				int docno=Integer.parseInt(request.getAttribute("docNo").toString());

				if(val>0){
					setMasterdoc_no(docno);
					setDocno(val+"");
					setClientid(getClientid());
					setCpersonid(getCpersonid());
					setCmbpaytype(getCmbpaytype());
					setHidcmbpaytype(getCmbpaytype());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getCmbreftype());
					setCmbsrvctype(getCmbsrvctype());
					setHidcmbsrvctype(getCmbsrvctype());
					setDate(date+"");
					setEnddate(enddate+"");
					setFinsdate(findate+"");
					setIncentive(getIncentive());
					setInstallments(getInstallments());
					setIslegaldoc(getIslegaldoc());
					setMasterdoc_no(getMasterdoc_no());
					setPaydueafter(getPaydueafter());
					setRefmasterdoc_no(getRefmasterdoc_no());
					setRrefno(getRrefno());
					setSalesincentive(getSalesincentive());
					setSerdate(serdate+"");
					setSerdueafter(getSerdueafter());
					setSrvcinterval(getSrvcinterval());
					setStdate(stdate+"");
					setTemp1(getTemp1());
					setTemp2(getTemp2());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setTxtcntrval(getTxtcntrval());
					setTxtbudget(getTxtbudget());
					setTxtcontact(getTxtcontact());
					setTxtemail(getTxtemail());
					setTxtmob1(getTxtmob1());
					setTxtmob2(getTxtmob2());
					setTxtrefno(getTxtrefno());
					setTxttaxper(getTxttaxper());
					setRrefno(getRrefno());
					setRefmasterdoc_no(getRefmasterdoc_no());
					setCmbprocess(getCmbprocess());
					setHidcmbprocess(getCmbprocess());
					setChkserv(getChkserv());
					setChkinv(getChkinv());
					setTxtsplinstruct(getTxtsplinstruct());
					setCmbprog(getCmbprog());
					setHidcmbprog(getCmbprog());
					setTxtprogperiod(getTxtprogperiod());
					setTxtprogper(getTxtprogper());
					setMsg("Updated Successfully");
					returns="success";
				}
				else{

					setDocno(val+"");
					setClientid(getClientid());
					setCpersonid(getCpersonid());
					setCmbpaytype(getCmbpaytype());
					setHidcmbpaytype(getCmbpaytype());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getCmbreftype());
					setCmbsrvctype(getCmbsrvctype());
					setHidcmbsrvctype(getCmbsrvctype());
					setDate(date+"");
					setEnddate(enddate+"");
					setFinsdate(findate+"");
					setIncentive(getIncentive());
					setInstallments(getInstallments());
					setIslegaldoc(getIslegaldoc());
					setMasterdoc_no(getMasterdoc_no());
					setPaydueafter(getPaydueafter());
					setRefmasterdoc_no(getRefmasterdoc_no());
					setRrefno(getRrefno());
					setSalesincentive(getSalesincentive());
					setSerdate(serdate+"");
					setSerdueafter(getSerdueafter());
					setSrvcinterval(getSrvcinterval());
					setStdate(stdate+"");
					setTemp1(getTemp1());
					setTemp2(getTemp2());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setTxtcntrval(getTxtcntrval());
					setTxtbudget(getTxtbudget());
					setTxtcontact(getTxtcontact());
					setTxtemail(getTxtemail());
					setTxtmob1(getTxtmob1());
					setTxtmob2(getTxtmob2());
					setTxtrefno(getTxtrefno());
					setTxttaxper(getTxttaxper());
					setRrefno(getRrefno());
					setRefmasterdoc_no(getRefmasterdoc_no());
					setCmbprocess(getCmbprocess());
					setHidcmbprocess(getCmbprocess());
					setChkserv(getChkserv());
					setChkinv(getChkinv());
					setTxtsplinstruct(getTxtsplinstruct());
					setCmbprog(getCmbprog());
					setHidcmbprog(getCmbprog());
					setTxtprogperiod(getTxtprogperiod());
					setTxtprogper(getTxtprogper());
					setMsg("Not Saved");
					returns="fail";


				}

			}

			if(mode.equalsIgnoreCase("D")){

				java.sql.Date date=com.changeStringtoSqlDate(getDate());
				java.sql.Date stdate=com.changeStringtoSqlDate(getStdate());
				java.sql.Date enddate=com.changeStringtoSqlDate(getEnddate());
				
				java.sql.Date wstdate=com.changeStringtoSqlDate(getWstdate());
				java.sql.Date wenddate=com.changeStringtoSqlDate(getWenddate());
				
				java.sql.Date findate=com.changeStringtoSqlDate(getFinsdate());
				java.sql.Date serdate=com.changeStringtoSqlDate(getSerdate());


				val=DAO.Delete(getMasterdoc_no(),Integer.parseInt(getDocno()),date,stdate,enddate,wstdate,wenddate,findate,serdate,getClientid(),getCpersonid(),
						getIslegaldoc(),getCmbreftype(),getRrefno(),getRefmasterdoc_no(),getTemp1(),
						getTemp2(),getSrvcinterval(),getTxttaxper(),getCmbpaytype(),getPaydueafter(),getInstallments(),
						getSerdueafter(),getCmbsrvctype(),getTxtcntrval(),getTxtbudget(),getIncentive(),getSalesincentive(),
						paylist,sitelist,servlist,sersclist,session,request,mode,getFormdetailcode(),getInstallments(),
						getSrvcinterval(),getIsproformainv(),getSalid(),getEditval(),getTxtrefno(),getCmbprocess(),getChkserv(),
						getChkinv(),getTxtsplinstruct(),getCmbprog(),getTxtprogperiod(),getTxtprogper());

				int docno=Integer.parseInt(request.getAttribute("docNo").toString());

				if(val>0){
					setMasterdoc_no(docno);
					setDocno(val+"");
					setClientid(getClientid());
					setCpersonid(getCpersonid());
					setCmbpaytype(getCmbpaytype());
					setHidcmbpaytype(getCmbpaytype());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getCmbreftype());
					setCmbsrvctype(getCmbsrvctype());
					setHidcmbsrvctype(getCmbsrvctype());
					setDate(date+"");
					setEnddate(enddate+"");
					setFinsdate(findate+"");
					setIncentive(getIncentive());
					setInstallments(getInstallments());
					setIslegaldoc(getIslegaldoc());
					setMasterdoc_no(getMasterdoc_no());
					setPaydueafter(getPaydueafter());
					setRefmasterdoc_no(getRefmasterdoc_no());
					setRrefno(getRrefno());
					setSalesincentive(getSalesincentive());
					setSerdate(serdate+"");
					setSerdueafter(getSerdueafter());
					setSrvcinterval(getSrvcinterval());
					setStdate(stdate+"");
					setTemp1(getTemp1());
					setTemp2(getTemp2());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setTxtcntrval(getTxtcntrval());
					setTxtbudget(getTxtbudget());
					setTxtcontact(getTxtcontact());
					setTxtemail(getTxtemail());
					setTxtmob1(getTxtmob1());
					setTxtmob2(getTxtmob2());
					setTxtrefno(getTxtrefno());
					setTxttaxper(getTxttaxper());
					setRrefno(getRrefno());
					setRefmasterdoc_no(getRefmasterdoc_no());
					setCmbprocess(getCmbprocess());
					setHidcmbprocess(getCmbprocess());
					setChkserv(getChkserv());
					setChkinv(getChkinv());
					setTxtsplinstruct(getTxtsplinstruct());
					setCmbprog(getCmbprog());
					setHidcmbprog(getCmbprog());
					setTxtprogperiod(getTxtprogperiod());
					setTxtprogper(getTxtprogper());
					setMsg("Successfully Deleted");
					setDeleted("DELETED");
					returns="success";
				}
				else{

					setDocno(val+"");
					setClientid(getClientid());
					setCpersonid(getCpersonid());
					setCmbpaytype(getCmbpaytype());
					setHidcmbpaytype(getCmbpaytype());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getCmbreftype());
					setCmbsrvctype(getCmbsrvctype());
					setHidcmbsrvctype(getCmbsrvctype());
					setDate(date+"");
					setEnddate(enddate+"");
					setFinsdate(findate+"");
					setIncentive(getIncentive());
					setInstallments(getInstallments());
					setIslegaldoc(getIslegaldoc());
					setMasterdoc_no(getMasterdoc_no());
					setPaydueafter(getPaydueafter());
					setRefmasterdoc_no(getRefmasterdoc_no());
					setRrefno(getRrefno());
					setSalesincentive(getSalesincentive());
					setSerdate(serdate+"");
					setSerdueafter(getSerdueafter());
					setSrvcinterval(getSrvcinterval());
					setStdate(stdate+"");
					setTemp1(getTemp1());
					setTemp2(getTemp2());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setTxtcntrval(getTxtcntrval());
					setTxtbudget(getTxtbudget());
					setTxtcontact(getTxtcontact());
					setTxtemail(getTxtemail());
					setTxtmob1(getTxtmob1());
					setTxtmob2(getTxtmob2());
					setTxtrefno(getTxtrefno());
					setTxttaxper(getTxttaxper());
					setRrefno(getRrefno());
					setRefmasterdoc_no(getRefmasterdoc_no());
					setCmbprocess(getCmbprocess());
					setHidcmbprocess(getCmbprocess());
					setChkserv(getChkserv());
					setChkinv(getChkinv());
					setTxtsplinstruct(getTxtsplinstruct());
					setCmbprog(getCmbprog());
					setHidcmbprog(getCmbprog());
					setTxtprogperiod(getTxtprogperiod());
					setTxtprogper(getTxtprogper());
					setMsg("Not Deleted");
					returns="fail";


				}

			}



			else if(mode.equalsIgnoreCase("view")){
		//		System.out.println("inside viewwww==="+Integer.parseInt(getDocno()));
//System.out.println("branch id==="+Integer.parseInt(getHidbrhid()));
				bean=DAO.getViewdetails(session,request,getMasterdoc_no(),Integer.parseInt(getDocno()));	

				setTxtrefno(bean.getTxtrefno());
				setClientid(bean.getClientid());
				setDocno(bean.getDocno());
				setMasterdoc_no(bean.getMasterdoc_no());
				setDate(bean.getDate());
				setTxtclient(bean.getTxtclient());
				setTxtcontact(bean.getTxtcontact());
				setCpersonid(bean.getCpersonid());
				setStdate(bean.getStdate());
				setEnddate(bean.getEnddate());
				setCmbreftype(bean.getCmbreftype());
				setHidcmbreftype(bean.getCmbreftype());
				setIslegaldoc(bean.getIslegaldoc());
				setSalesincentive(bean.getSalesincentive());
				setIncentive(bean.getIncentive());
				setTxtcntrval(bean.getTxtcntrval());
				setTxttaxper(bean.getTxttaxper());
				setTemp1(bean.getTemp1());
				/*bean.getTemp2());*/
				setInstallments(bean.getInstallments());
				setPaydueafter(bean.getPaydueafter());
				setCmbpaytype(bean.getCmbpaytype());
				setHidcmbpaytype(bean.getCmbpaytype());
				setFinsdate(bean.getFinsdate());

				setWstdate(bean.getWstdate());
				setWenddate(bean.getWenddate());
				
				setSrvcinterval(bean.getSrvcinterval());
				setSerdueafter(bean.getSerdueafter());
				setCmbsrvctype(bean.getCmbsrvctype());
				setHidcmbsrvctype(bean.getCmbsrvctype());
				setSerdate(bean.getSerdate());

				setRrefno(bean.getRrefno());
				setRefmasterdoc_no(bean.getRefmasterdoc_no());

				setTxtclientdet(bean.getTxtclientdet());
				setTxtmob2(bean.getTxtmob2());
				setTxtemail(bean.getTxtemail());
				
				setTxtsalman(bean.getTxtsalman());
				setSalid(bean.getSalid());
				setCmbprocess(bean.getCmbprocess());
				setHidcmbprocess(bean.getCmbprocess());
				setChkserv(bean.getChkserv());
				setChkinv(bean.getChkinv());
				setTxtsplinstruct(bean.getTxtsplinstruct());
				setCmbpaytype(bean.getCmbprog());
				setHidcmbprog(bean.getCmbprog());
				setTxtprogperiod(bean.getTxtprogperiod());
				setTxtprogper(bean.getTxtprogper());
				returns="success";

			}
		}
		catch(Exception e){
			e.printStackTrace();
		}

		return returns;
	}
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		
		ClsJobContractDAO DAO=new ClsJobContractDAO();
		
		
		String dtype=request.getParameter("dtype").toString();
		setUrl(com.getPrintPath(dtype));
		String allbranch=request.getParameter("allbranch")==null?"0":request.getParameter("allbranch");
		String hidheader=request.getParameter("hidheader")==null?"0":request.getParameter("hidheader");
		String docno=request.getParameter("docno").toString();
		String brhid=request.getParameter("brhid").toString();
		String trno=request.getParameter("trno").toString();
		String header=request.getParameter("header").toString();
		bean=DAO.printMaster(session,docno,brhid,trno,dtype);

		setTxtheader(header);
		
		setClientid(bean.getClientid());
		setDocno(bean.getDocno());
		setMasterdoc_no(bean.getMasterdoc_no());
		setDate(bean.getDate());
		setTxtclient(bean.getTxtclient());
		setTxtclientdet(bean.getTxtclientdet());
		setTxtcontact(bean.getTxtcontact());
		setCpersonid(bean.getCpersonid());
		setStdate(bean.getStdate());
		setEnddate(bean.getEnddate());
		setCmbreftype(bean.getCmbreftype());
		setHidcmbreftype(bean.getCmbreftype());
		setIslegaldoc(bean.getIslegaldoc());
		setSalesincentive(bean.getSalesincentive());
		setIncentive(bean.getIncentive());
		setTxtcntrval(bean.getTxtcntrval());
		setTxttaxper(bean.getTxttaxper());
		setTemp1(bean.getTemp1());
		/*bean.getTemp2());*/
		setInstallments(bean.getInstallments());
		setPaydueafter(bean.getPaydueafter());
		setCmbpaytype(bean.getCmbpaytype());
		setHidcmbpaytype(bean.getCmbpaytype());
		setFinsdate(bean.getFinsdate());

		setSrvcinterval(bean.getSrvcinterval());
		setSerdueafter(bean.getSerdueafter());
		setCmbsrvctype(bean.getCmbsrvctype());
		setHidcmbsrvctype(bean.getCmbsrvctype());
		setSerdate(bean.getSerdate());

		setRrefno(bean.getRrefno());
		setRefmasterdoc_no(bean.getRefmasterdoc_no());

		setTxtclientdet(bean.getTxtclientdet());
		setTxtmob2(bean.getTxtmob2());
		setTxtemail(bean.getTxtemail());

		setTxtsalman(bean.getTxtsalman());
		setSalid(bean.getSalid());

		
		
		setTxtrefno(bean.getTxtrefno());
		setLblbranch(bean.getLblbranch());
		setLblcompaddress(bean.getLblcompaddress());
		setLblcompfax(bean.getLblcompfax());
		setLblcomptel(bean.getLblcomptel());
		setLbllocation(bean.getLbllocation());
		setAmountwords(bean.getAmountwords());
		setLblcompname(bean.getLblcompname());
		setLblcheckedby(session.getAttribute("USERNAME").toString().trim());
		setLblfinaldate(bean.getLblfinaldate());
		setLblbranch(bean.getLblbranch());
		setLblcompaddress(bean.getLblcompaddress());
		setLblcompfax(bean.getLblcompfax());
		setLblcomptel(bean.getLblcomptel());
		setLbllocation(bean.getLbllocation());
		setLblcompname(bean.getLblcompname());
		setLblfinaldate(bean.getLblfinaldate());


		// fire7
		setSqtno(bean.getSqtno());
		setLegalchrg(bean.getLegalchrg());


		setLblprintname("JOB CONTRACT");
		ArrayList list=bean.getList();
		ArrayList termlist=bean.getTermlist();
		ArrayList sitelist=bean.getSitelist();
		ArrayList serlist=bean.getSerlist();
		ArrayList schlist=bean.getSchlist();
		ArrayList paylist=bean.getPaylist();
		
		setTermlist(termlist);
		setSitelist(sitelist);
		setSerlist(serlist);
		setSchlist(schlist);
		setPaylist(paylist);
		
		request.setAttribute("CONTLIST", list);
		request.setAttribute("SITELIST", sitelist);
		request.setAttribute("SERLIST", serlist);
		request.setAttribute("SCHLIST", schlist);
		request.setAttribute("PAYLIST", paylist);
		request.setAttribute("TERMLIST", termlist);
		request.setAttribute("PAYAITSLIST", bean.getPayaitslist());

		return "print";
	}





}
