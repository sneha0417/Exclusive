package com.project.execution.projectInvoicereturn;

import java.util.ArrayList;

public class ClsProjectInvoiceReturnBean {
	
	private String date;
	private String refno;
	private String brchName;

	private String clacno;

	private int costid;
	private String pdid;
	private int maintrno;
	
	private String nireftype;
	private String hidnireftype;
	private String rrefno;
	private int rreftrno;
	
	private String searchtrno;
	private int docno;

	private String txtlegalamt;
	private String txtseramt;
	private String txtexptotal;
	private String txtnettotal;

	private int invgridlength;
	private String cmbcontracttype;
	private String cmbcontracttypeid;
	private String contypeval;
	private String ptype;
	
	private String desc;
	private String txtnotes;
	private String mode;
	private String msg;
	private String deleted;
	private String formdetailcode;

	private String lblcompname;
	private String lblcompaddress;
	private String lblcompanyaddress;
	private String lblprintname;
	private String lblcomptel;
	private String lblcompfax;
	private String lblprintname1;
	private String lblbranch;
	private String lbllocation;
	private String lblbranchtrno;
	private String lblcomptrno;
	private String lblclientname;
	private String lblclientaddress;
	private String lblclienttrno;
	private String lbldate;
	private String lbldocno;
	private String lblrefno;
	private String lblsite;
	private String lblnotes;
	private String lblgrossamount;
	private String lblvatamount;
	private String lblnettotal;
	private String lblreturndetailsquery;
	private String amountwords;
	private String lblcheckedby;
	private String lblfinaldate;
	private String txtheader;
	private String url;
	private String txttel;
	private String txtmob;
	private String txtemail;
	private String txtjobrefno; 
	private String lblamountinwords;
	private String lblrrefno;
	private String lblemail;
	
	
	
   

	public String getLblemail() {
		return lblemail;
	}
	public void setLblemail(String lblemail) {
		this.lblemail = lblemail;
	}
	public String getLblrrefno() {
		return lblrrefno;
	}
	public void setLblrrefno(String lblrrefno) {
		this.lblrrefno = lblrrefno;
	}
	public String getLblamountinwords() {
		return lblamountinwords;
	}
	public void setLblamountinwords(String lblamountinwords) {
		this.lblamountinwords = lblamountinwords;
	}

	private int masterdoc_no;

	private int clientid;
	private int cpersonid;

	private String txtclient;
	private String txtclientdet;
	private int txtcontract;
	private String lblcltrnno;
	
	private ArrayList list;
	private ArrayList sitelist;
	private ArrayList serlist;
	private ArrayList termlist;
	private ArrayList paylist;
	
	private String telph;
	private String mxrnomin;
	private String mxrnomax;
	private String total1;
	private String invoived;
	private String balance;
	private String cperson;
	private String conttrno;
	private String series;



	public String getSeries() {
		return series;
	}
	public void setSeries(String series) {
		this.series = series;
	}

	private String tinno,invono,site,companytrno;
	private String  brch_name,brch_address,brch_pbno,brch_tel,brch_email;
private String tel2;
private String txtdtype;


private String taxamount,taxpercent,nettotal,cltelno,staramuntword;



public String getStaramuntword() {
	return staramuntword;
}
public void setStaramuntword(String staramuntword) {
	this.staramuntword = staramuntword;
}



public String getCompanytrno() {
	return companytrno;
}
public void setCompanytrno(String companytrno) {
	this.companytrno = companytrno;
}
public String getCltelno() {
	return cltelno;
}
public void setCltelno(String cltelno) {
	this.cltelno = cltelno;
}


public String getTaxpercent() {
	return taxpercent;
}
public void setTaxpercent(String taxpercent) {
	this.taxpercent = taxpercent;
}
public String getTaxamount() {
	return taxamount;
}
public void setTaxamount(String taxamount) {
	this.taxamount = taxamount;
}
public String getNettotal() {
	return nettotal;
}
public void setNettotal(String nettotal) {
	this.nettotal = nettotal;
}


public String getTxtdtype() {
	return txtdtype;
}
public void setTxtdtype(String txtdtype) {
	this.txtdtype = txtdtype;
}
	
	public String getTel2() {
		return tel2;
	}
	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}
	
	
	public String getBrch_name() {
		return brch_name;
	}
	public void setBrch_name(String brch_name) {
		this.brch_name = brch_name;
	}
	public String getBrch_address() {
		return brch_address;
	}
	public void setBrch_address(String brch_address) {
		this.brch_address = brch_address;
	}
	public String getBrch_pbno() {
		return brch_pbno;
	}
	public void setBrch_pbno(String brch_pbno) {
		this.brch_pbno = brch_pbno;
	}
	public String getBrch_tel() {
		return brch_tel;
	}
	public void setBrch_tel(String brch_tel) {
		this.brch_tel = brch_tel;
	}
	public String getBrch_email() {
		return brch_email;
	}
	public void setBrch_email(String brch_email) {
		this.brch_email = brch_email;
	}
	
	
	
	public String getSite() {
		return site;
	}
	public void setSite(String site) {
		this.site = site;
	}
	public String getInvono() {
		return invono;
	}
	public void setInvono(String invono) {
		this.invono = invono;
	}
	public String getTinno() {
		return tinno;
	}
	public void setTinno(String tinno) {
		this.tinno = tinno;
	}
	
	private String txtrefdetails;
	
	public String getTxtrefdetails() {
		return txtrefdetails;
	}
	public void setTxtrefdetails(String txtrefdetails) {
		this.txtrefdetails = txtrefdetails;
	}
	
	public String getCperson() {
		return cperson;
	}
	public void setCperson(String cperson) {
		this.cperson = cperson;
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
	public String getLblcompanyaddress() {
		return lblcompanyaddress;
	}
	public void setLblcompanyaddress(String lblcompanyaddress) {
		this.lblcompanyaddress = lblcompanyaddress;
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
	public String getLblbranchtrno() {
		return lblbranchtrno;
	}
	public void setLblbranchtrno(String lblbranchtrno) {
		this.lblbranchtrno = lblbranchtrno;
	}
	public String getLblcomptrno() {
		return lblcomptrno;
	}
	public void setLblcomptrno(String lblcomptrno) {
		this.lblcomptrno = lblcomptrno;
	}
	public String getLblclientname() {
		return lblclientname;
	}
	public void setLblclientname(String lblclientname) {
		this.lblclientname = lblclientname;
	}
	public String getLblclientaddress() {
		return lblclientaddress;
	}
	public void setLblclientaddress(String lblclientaddress) {
		this.lblclientaddress = lblclientaddress;
	}
	public String getLblclienttrno() {
		return lblclienttrno;
	}
	public void setLblclienttrno(String lblclienttrno) {
		this.lblclienttrno = lblclienttrno;
	}
	public String getLbldate() {
		return lbldate;
	}
	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}
	public String getLbldocno() {
		return lbldocno;
	}
	public void setLbldocno(String lbldocno) {
		this.lbldocno = lbldocno;
	}
	public String getLblrefno() {
		return lblrefno;
	}
	public void setLblrefno(String lblrefno) {
		this.lblrefno = lblrefno;
	}
	public String getLblsite() {
		return lblsite;
	}
	public void setLblsite(String lblsite) {
		this.lblsite = lblsite;
	}
	public String getLblnotes() {
		return lblnotes;
	}
	public void setLblnotes(String lblnotes) {
		this.lblnotes = lblnotes;
	}
	public String getLblgrossamount() {
		return lblgrossamount;
	}
	public void setLblgrossamount(String lblgrossamount) {
		this.lblgrossamount = lblgrossamount;
	}
	public String getLblvatamount() {
		return lblvatamount;
	}
	public void setLblvatamount(String lblvatamount) {
		this.lblvatamount = lblvatamount;
	}
	public String getLblnettotal() {
		return lblnettotal;
	}
	public void setLblnettotal(String lblnettotal) {
		this.lblnettotal = lblnettotal;
	}
	public String getLblreturndetailsquery() {
		return lblreturndetailsquery;
	}
	public void setLblreturndetailsquery(String lblreturndetailsquery) {
		this.lblreturndetailsquery = lblreturndetailsquery;
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
	public String getTxtjobrefno() {
		return txtjobrefno;
	}
	public void setTxtjobrefno(String txtjobrefno) {
		this.txtjobrefno = txtjobrefno;
	}
	public ArrayList getList() {
		return list;
	}
	public void setList(ArrayList list) {
		this.list = list;
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
	public ArrayList getTermlist() {
		return termlist;
	}
	public void setTermlist(ArrayList termlist) {
		this.termlist = termlist;
	}
	public int getCostid() {
		return costid;
	}
	public void setCostid(int costid) {
		this.costid = costid;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public int getTxtcontract() {
		return txtcontract;
	}
	public void setTxtcontract(int txtcontract) {
		this.txtcontract = txtcontract;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
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
	public int getMaintrno() {
		return maintrno;
	}
	public void setMaintrno(int maintrno) {
		this.maintrno = maintrno;
	}
	public String getNireftype() {
		return nireftype;
	}
	public void setNireftype(String nireftype) {
		this.nireftype = nireftype;
	}
	public String getHidnireftype() {
		return hidnireftype;
	}
	public void setHidnireftype(String hidnireftype) {
		this.hidnireftype = hidnireftype;
	}
	public String getRrefno() {
		return rrefno;
	}
	public void setRrefno(String rrefno) {
		this.rrefno = rrefno;
	}
	public int getRreftrno() {
		return rreftrno;
	}
	public void setRreftrno(int rreftrno) {
		this.rreftrno = rreftrno;
	}
	public String getSearchtrno() {
		return searchtrno;
	}
	public void setSearchtrno(String searchtrno) {
		this.searchtrno = searchtrno;
	}

	public int getInvgridlength() {
		return invgridlength;
	}
	public void setInvgridlength(int invgridlength) {
		this.invgridlength = invgridlength;
	}
	public String getCmbcontracttype() {
		return cmbcontracttype;
	}
	public void setCmbcontracttype(String cmbcontracttype) {
		this.cmbcontracttype = cmbcontracttype;
	}
	public String getCmbcontracttypeid() {
		return cmbcontracttypeid;
	}
	public void setCmbcontracttypeid(String cmbcontracttypeid) {
		this.cmbcontracttypeid = cmbcontracttypeid;
	}
	public String getContypeval() {
		return contypeval;
	}
	public void setContypeval(String contypeval) {
		this.contypeval = contypeval;
	}
	public String getPtype() {
		return ptype;
	}
	public void setPtype(String ptype) {
		this.ptype = ptype;
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
	public String getLblcltrnno() {
		return lblcltrnno;
	}
	public void setLblcltrnno(String lblcltrnno) {
		this.lblcltrnno = lblcltrnno;
	}
	public String getPdid() {
		return pdid;
	}
	public void setPdid(String pdid) {
		this.pdid = pdid;
	}
	public String getTxtlegalamt() {
		return txtlegalamt;
	}
	public void setTxtlegalamt(String txtlegalamt) {
		this.txtlegalamt = txtlegalamt;
	}
	public String getTxtseramt() {
		return txtseramt;
	}
	public void setTxtseramt(String txtseramt) {
		this.txtseramt = txtseramt;
	}
	public String getTxtexptotal() {
		return txtexptotal;
	}
	public void setTxtexptotal(String txtexptotal) {
		this.txtexptotal = txtexptotal;
	}
	public String getTxtnettotal() {
		return txtnettotal;
	}
	public void setTxtnettotal(String txtnettotal) {
		this.txtnettotal = txtnettotal;
	}
	public String getTxtnotes() {
		return txtnotes;
	}
	public void setTxtnotes(String txtnotes) {
		this.txtnotes = txtnotes;
	}
	public String getConttrno() {
		return conttrno;
	}
	public void setConttrno(String conttrno) {
		this.conttrno = conttrno;
	}
private String fire7site;
	
	public String getFire7site() {
		return fire7site;
	}
	public void setFire7site(String fire7site) {
		this.fire7site = fire7site;
	}
private String fire7srno,fire7mxrno,fire7total,fire7invamt,fire7balance,inclusivestat;


public String getInclusivestat() {
	return inclusivestat;
}
public void setInclusivestat(String inclusivestat) {
	this.inclusivestat = inclusivestat;
}


public String getFire7srno() {
	return fire7srno;
}
public void setFire7srno(String fire7srno) {
	this.fire7srno = fire7srno;
}
public String getFire7mxrno() {
	return fire7mxrno;
}
public void setFire7mxrno(String fire7mxrno) {
	this.fire7mxrno = fire7mxrno;
}
public String getFire7total() {
	return fire7total;
}
public void setFire7total(String fire7total) {
	this.fire7total = fire7total;
}
public String getFire7invamt() {
	return fire7invamt;
}
public void setFire7invamt(String fire7invamt) {
	this.fire7invamt = fire7invamt;
}
public String getFire7balance() {
	return fire7balance;
}
public void setFire7balance(String fire7balance) {
	this.fire7balance = fire7balance;
}


}
