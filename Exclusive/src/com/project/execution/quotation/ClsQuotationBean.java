package com.project.execution.quotation;

import java.util.ArrayList;

public class ClsQuotationBean {
	
	private String hidradio;
	private String date;
	private String hiddate;
	private String mode;
	private String msg;
	private String deleted;
	private String docno;
	private int masterdoc_no;
	private String txtrefno;
	private String formdetailcode;

	private String txtclient;
	private String txtclientdet;
	private String txttel;
	private String txtmob;
	private String txtemail;
	private int clientid;

	private String txtcontact;
	private String txtcontactdetails;
	private int cpersonid;

	private String ramc;
	private String rsjob;
	private String rdo;
	private String txtdcdamount;
	private String cmbreftype;
	private String hidcmbreftype;

	private String txtenquiry;
	private int enquiryid;

	private String txtsubject;
	private String txtclientref;

	private String txtdesc1;

	private String txtgrtotal;
	private String txtdisper;
	private String txtdisamt;
	private String txttotalamt;
	private String txttaxper;
	private String txttaxamt;
	private String txtnettotal;
	
	private ArrayList list;
	private ArrayList termlist;
	private ArrayList amclist;
	
	private String contrtype;
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
    private String txtsalman;
    private int salid;
    private String txtsalmob;
    
    private String sitequery;
    
    private int cmbprocess;
    
    private int hidcmbprocess;
    private String txtrevise;
    private String printname;
    
    
 //fire7 print
	private String fire7amountword;
    private String fire7total;
    private String fire7sitedetail;
    private String f7telno,f7mobno;
    
    public String getFire7total() {
		return fire7total;
	}
	public void setFire7total(String fire7total) {
		this.fire7total = fire7total;
	}
   	public String getF7telno() {
		return f7telno;
	}
	public void setF7telno(String f7telno) {
		this.f7telno = f7telno;
	}
	public String getF7mobno() {
		return f7mobno;
	}
	public void setF7mobno(String f7mobno) {
		this.f7mobno = f7mobno;
	}
	public String getFire7sitedetail() {
		return fire7sitedetail;
	}
	public void setFire7sitedetail(String fire7sitedetail) {
		this.fire7sitedetail = fire7sitedetail;
	}
	public String getFire7amountword() {
		return fire7amountword;
	}
	public void setFire7amountword(String fire7amountword) {
		this.fire7amountword = fire7amountword;
	}
	



   	public String getPrintname() {
		return printname;
	}
	public void setPrintname(String printname) {
		this.printname = printname;
	}
	public String getTxtrevise() {
		return txtrevise;
	}
	public void setTxtrevise(String txtrevise) {
		this.txtrevise = txtrevise;
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
    
	public String getSitequery() {
		return sitequery;
	}
	public void setSitequery(String sitequery) {
		this.sitequery = sitequery;
	}
    
	public String getTxtsalmob() {
		return txtsalmob;
	}
	public void setTxtsalmob(String txtsalmob) {
		this.txtsalmob = txtsalmob;
	}
	public ArrayList getAmclist() {
		return amclist;
	}
	public void setAmclist(ArrayList amclist) {
		this.amclist = amclist;
	}
	public String getHidradio() {
		return hidradio;
	}
	public void setHidradio(String hidradio) {
		this.hidradio = hidradio;
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
	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public String getTxtrefno() {
		return txtrefno;
	}
	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
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
	public int getClientid() {
		return clientid;
	}
	public void setClientid(int clientid) {
		this.clientid = clientid;
	}
	public String getTxtcontact() {
		return txtcontact;
	}
	public void setTxtcontact(String txtcontact) {
		this.txtcontact = txtcontact;
	}
	public String getTxtcontactdetails() {
		return txtcontactdetails;
	}
	public void setTxtcontactdetails(String txtcontactdetails) {
		this.txtcontactdetails = txtcontactdetails;
	}
	public int getCpersonid() {
		return cpersonid;
	}
	public void setCpersonid(int cpersonid) {
		this.cpersonid = cpersonid;
	}
	public String getRamc() {
		return ramc;
	}
	public void setRamc(String ramc) {
		this.ramc = ramc;
	}
	public String getRsjob() {
		return rsjob;
	}
	public void setRsjob(String rsjob) {
		this.rsjob = rsjob;
	}
	public String getRdo() {
		return rdo;
	}
	public void setRdo(String rdo) {
		this.rdo = rdo;
	}
	public String getTxtdcdamount() {
		return txtdcdamount;
	}
	public void setTxtdcdamount(String txtdcdamount) {
		this.txtdcdamount = txtdcdamount;
	}
	public String getCmbreftype() {
		return cmbreftype;
	}
	public void setCmbreftype(String cmbreftype) {
		this.cmbreftype = cmbreftype;
	}
	public String getHidcmbreftype() {
		return hidcmbreftype;
	}
	public void setHidcmbreftype(String hidcmbreftype) {
		this.hidcmbreftype = hidcmbreftype;
	}
	public String getTxtenquiry() {
		return txtenquiry;
	}
	public void setTxtenquiry(String txtenquiry) {
		this.txtenquiry = txtenquiry;
	}
	public int getEnquiryid() {
		return enquiryid;
	}
	public void setEnquiryid(int enquiryid) {
		this.enquiryid = enquiryid;
	}
	public String getTxtsubject() {
		return txtsubject;
	}
	public void setTxtsubject(String txtsubject) {
		this.txtsubject = txtsubject;
	}
	public String getTxtclientref() {
		return txtclientref;
	}
	public void setTxtclientref(String txtclientref) {
		this.txtclientref = txtclientref;
	}
	public String getTxtdesc1() {
		return txtdesc1;
	}
	public void setTxtdesc1(String txtdesc1) {
		this.txtdesc1 = txtdesc1;
	}
	public String getTxtgrtotal() {
		return txtgrtotal;
	}
	public void setTxtgrtotal(String txtgrtotal) {
		this.txtgrtotal = txtgrtotal;
	}
	public String getTxtdisper() {
		return txtdisper;
	}
	public void setTxtdisper(String txtdisper) {
		this.txtdisper = txtdisper;
	}
	public String getTxtdisamt() {
		return txtdisamt;
	}
	public void setTxtdisamt(String txtdisamt) {
		this.txtdisamt = txtdisamt;
	}
	public String getTxttotalamt() {
		return txttotalamt;
	}
	public void setTxttotalamt(String txttotalamt) {
		this.txttotalamt = txttotalamt;
	}
	public String getTxttaxper() {
		return txttaxper;
	}
	public void setTxttaxper(String txttaxper) {
		this.txttaxper = txttaxper;
	}
	public String getTxttaxamt() {
		return txttaxamt;
	}
	public void setTxttaxamt(String txttaxamt) {
		this.txttaxamt = txttaxamt;
	}
	public String getTxtnettotal() {
		return txtnettotal;
	}
	public void setTxtnettotal(String txtnettotal) {
		this.txtnettotal = txtnettotal;
	}
	public ArrayList getList() {
		return list;
	}
	public void setList(ArrayList list) {
		this.list = list;
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
	public ArrayList getTermlist() {
		return termlist;
	}
	public void setTermlist(ArrayList termlist) {
		this.termlist = termlist;
	}
	public String getContrtype() {
		return contrtype;
	}
	public void setContrtype(String contrtype) {
		this.contrtype = contrtype;
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
	
	
	

}
