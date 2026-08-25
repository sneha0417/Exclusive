package com.dashboard.projectexecution.servicereassign;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

public class ServiceReAssignAction {


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






	public String getTxtsalman() {
		return txtsalman;
	}






	public void setTxtsalman(String txtsalman) {
		this.txtsalman = txtsalman;
	}






	public String getUrl() {
		return url;
	}






	public void setUrl(String url) {
		this.url = url;
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






	public int getIsproformainv() {
		return isproformainv;
	}






	public void setIsproformainv(int isproformainv) {
		this.isproformainv = isproformainv;
	}






	public int getSalid() {
		return salid;
	}






	public void setSalid(int salid) {
		this.salid = salid;
	}






	public int getEditval() {
		return editval;
	}






	public void setEditval(int editval) {
		this.editval = editval;
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






	public String printAction() throws ParseException, SQLException{

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		String allbranch=request.getParameter("allbranch")==null?"0":request.getParameter("allbranch");
		String hidheader=request.getParameter("hidheader")==null?"0":request.getParameter("hidheader");
		String docno=request.getParameter("docno").toString();
		String brhid=request.getParameter("brhid").toString();
		String trno=request.getParameter("trno").toString();



		return trno;
	}


}
