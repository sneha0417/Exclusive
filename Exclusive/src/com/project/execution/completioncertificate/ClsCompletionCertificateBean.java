package com.project.execution.completioncertificate;

import java.util.ArrayList;

public class ClsCompletionCertificateBean {
	private String date;
	private String refno;
	private String brchName;

	private String clacno;

	private int costid;
	private String pdid;
	private int maintrno;
	private String searchtrno;
	private int docno;


	private String txtlegalamt;
	private String txtseramt;
	private String txtexptotal;
	private String txtnettotal;

	private int invgridlength;
	private String cmbcontracttype;


	private String contrval;
	private String certifyper;
	private String pytval;
	private String totinvoice;
	private String tobeinvoice;
	private String retnamount;
	private String invdate;
	private String invdesc;
	
	
	public String getContrval() {
		return contrval;
	}
	public void setContrval(String contrval) {
		this.contrval = contrval;
	}
	public String getCertifyper() {
		return certifyper;
	}
	public void setCertifyper(String certifyper) {
		this.certifyper = certifyper;
	}
	public String getPytval() {
		return pytval;
	}
	public void setPytval(String pytval) {
		this.pytval = pytval;
	}
	public String getTotinvoice() {
		return totinvoice;
	}
	public void setTotinvoice(String totinvoice) {
		this.totinvoice = totinvoice;
	}
	public String getTobeinvoice() {
		return tobeinvoice;
	}
	public void setTobeinvoice(String tobeinvoice) {
		this.tobeinvoice = tobeinvoice;
	}
	public String getRetnamount() {
		return retnamount;
	}
	public void setRetnamount(String retnamount) {
		this.retnamount = retnamount;
	}
	public String getInvdate() {
		return invdate;
	}
	public void setInvdate(String invdate) {
		this.invdate = invdate;
	}
	public String getInvdesc() {
		return invdesc;
	}
	public void setInvdesc(String invdesc) {
		this.invdesc = invdesc;
	}


	private String desc;
	private String txtnotes;
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


	private int masterdoc_no;

	private int clientid;
	private int cpersonid;

	private String txtclient;
	private String txtclientdet;
	private int txtcontract;
	
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



	private String tinno,invono,site;
	private String  brch_name,brch_address,brch_pbno,brch_tel,brch_email;
private String tel2;
private String txtdtype;


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


}
