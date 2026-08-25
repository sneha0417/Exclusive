package com.project.execution.projectproInvoice;

import java.util.ArrayList;

public class ClsProjectProInvoiceBean {
	
	
	private String date;
	private String hiddate;
	private String refno;
	private String brchName;
	private String clacno;
	private String searchtrno;
	private String txtclient;
	private String txtclientdet,txtcompany;
	private String cmbcontracttype;
	private String desc;
	private String mode;
	private String msg;
	private String deleted;
	private String formdetailcode;
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
	private String url;
	private String txttel;
	private String txtmob;
	private String txtemail;
	private String txtjobrefno; 
	
	private int invgridlength;
	private int masterdoc_no;
	private int clientid;
	private int cpersonid;
	private int txtcontract;
	private int costid;
	private int maintrno;
	private int docno;
	private ArrayList list;
	private ArrayList sitelist;
	private ArrayList serlist;
	private ArrayList termlist;
	private ArrayList paylist;
	private ArrayList seremirateslist;
	private ArrayList paygrid;
	
	private String telph;
	private String cperson;
	private String proinvqry;
	
	private String mxrnomin;
	 private String mxrnomax;
	 private String total1;
	 private String invoived;
	 private String balance;
	 private String sitedetail;
	 private String amountinword;
	 private String lblcltrnno;
	 private String lblbranchtrno;
	 private String cltelno,sjobrefno;
	 
	 
	 
	 public ArrayList getPaygrid() {
		return paygrid;
	}
	public void setPaygrid(ArrayList paygrid) {
		this.paygrid = paygrid;
	}
	public ArrayList getSeremirateslist() {
		return seremirateslist;
	}
	public void setSeremirateslist(ArrayList seremirateslist) {
		this.seremirateslist = seremirateslist;
	}
	public String getTxtcompany() {
		return txtcompany;
	}
	public void setTxtcompany(String txtcompany) {
		this.txtcompany = txtcompany;
	}
	public String getCltelno() {
		return cltelno;
	}
	public void setCltelno(String cltelno) {
		this.cltelno = cltelno;
	}
	 	 
	 public String getLblbranchtrno() {
		return lblbranchtrno;
	}
	public void setLblbranchtrno(String lblbranchtrno) {
		this.lblbranchtrno = lblbranchtrno;
	}
	public String getLblcltrnno() {
		return lblcltrnno;
	}
	public void setLblcltrnno(String lblcltrnno) {
		this.lblcltrnno = lblcltrnno;
	}
	public String getAmountinword() {
	  return amountinword;
	 }
	 public void setAmountinword(String amountinword) {
	  this.amountinword = amountinword;
	 }
	 public String getSitedetail() {
	  return sitedetail;
	 }
	 public void setSitedetail(String sitedetail) {
	  this.sitedetail = sitedetail;
	 }
	 public String getMxrnomin() {
	  return mxrnomin;
	 }
	 public void setMxrnomin(String mxrnomin) {
	  this.mxrnomin = mxrnomin;
	 }
	 public String getMxrnomax() {
	  return mxrnomax;
	 }
	 public void setMxrnomax(String mxrnomax) {
	  this.mxrnomax = mxrnomax;
	 }
	 public String getTotal1() {
	  return total1;
	 }
	 public void setTotal1(String total1) {
	  this.total1 = total1;
	 }
	 public String getInvoived() {
	  return invoived;
	 }
	 public void setInvoived(String invoived) {
	  this.invoived = invoived;
	 }
	 public String getBalance() {
	  return balance;
	 }
	 public void setBalance(String balance) {
	  this.balance = balance;
	 }
	
	
	public String getProinvqry() {
		return proinvqry;
	}
	public void setProinvqry(String proinvqry) {
		this.proinvqry = proinvqry;
	}
	public String getCperson() {
		return cperson;
	}
	public void setCperson(String cperson) {
		this.cperson = cperson;
	}
	public String getTelph() {
		return telph;
	}
	public void setTelph(String telph) {
		this.telph = telph;
	}

	public ArrayList getPaylist() {
		return paylist;
	}
	public void setPaylist(ArrayList paylist) {
		this.paylist = paylist;
	}
	public ArrayList getTermlist() {
		return termlist;
	}
	public void setTermlist(ArrayList termlist) {
		this.termlist = termlist;
	}
	public ArrayList getSerlist() {
		return serlist;
	}
	public void setSerlist(ArrayList serlist) {
		this.serlist = serlist;
	}
	public ArrayList getSitelist() {
		return sitelist;
	}
	public void setSitelist(ArrayList sitelist) {
		this.sitelist = sitelist;
	}
	public String getTxtjobrefno() {
		return txtjobrefno;
	}
	public void setTxtjobrefno(String txtjobrefno) {
		this.txtjobrefno = txtjobrefno;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getHiddate() {
		return hiddate;
	}
	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}
	public String getRefno() {
		return refno;
	}
	public void setRefno(String refno) {
		this.refno = refno;
	}
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
	public String getClacno() {
		return clacno;
	}
	public void setClacno(String clacno) {
		this.clacno = clacno;
	}
	public String getSearchtrno() {
		return searchtrno;
	}
	public void setSearchtrno(String searchtrno) {
		this.searchtrno = searchtrno;
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
	public String getCmbcontracttype() {
		return cmbcontracttype;
	}
	public void setCmbcontracttype(String cmbcontracttype) {
		this.cmbcontracttype = cmbcontracttype;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
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
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getTxttel() {
		return txttel;
	}
	public void setTxttel(String txttel) {
		this.txttel = txttel;
	}
	public String getTxtmob() {
		return txtmob;
	}
	public void setTxtmob(String txtmob) {
		this.txtmob = txtmob;
	}
	public String getTxtemail() {
		return txtemail;
	}
	public void setTxtemail(String txtemail) {
		this.txtemail = txtemail;
	}
	public int getInvgridlength() {
		return invgridlength;
	}
	public void setInvgridlength(int invgridlength) {
		this.invgridlength = invgridlength;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
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
	public int getTxtcontract() {
		return txtcontract;
	}
	public void setTxtcontract(int txtcontract) {
		this.txtcontract = txtcontract;
	}
	public int getCostid() {
		return costid;
	}
	public void setCostid(int costid) {
		this.costid = costid;
	}
	public int getMaintrno() {
		return maintrno;
	}
	public void setMaintrno(int maintrno) {
		this.maintrno = maintrno;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public ArrayList getList() {
		return list;
	}
	public void setList(ArrayList list) {
		this.list = list;
	}
	private String inclusivestat,tinno,amountwithtaxword;
	private String taxamount,taxpercent,nettotal;

	public String getTaxamount() {
		return taxamount;
	}
	public void setTaxamount(String taxamount) {
		this.taxamount = taxamount;
	}
	public String getTaxpercent() {
		return taxpercent;
	}
	public void setTaxpercent(String taxpercent) {
		this.taxpercent = taxpercent;
	}
	public String getNettotal() {
		return nettotal;
	}
	public void setNettotal(String nettotal) {
		this.nettotal = nettotal;
	}
	public String getAmountwithtaxword() {
		return amountwithtaxword;
	}
	public void setAmountwithtaxword(String amountwithtaxword) {
		this.amountwithtaxword = amountwithtaxword;
	}
	public String getTinno() {
		return tinno;
	}
	public void setTinno(String tinno) {
		this.tinno = tinno;
	}
	public String getInclusivestat() {
		return inclusivestat;
	}
	public void setInclusivestat(String inclusivestat) {
		this.inclusivestat = inclusivestat;
	}
	public String getSjobrefno() {
		return sjobrefno;
	}
	public void setSjobrefno(String sjobrefno) {
		this.sjobrefno = sjobrefno;
	}
		
		
}
