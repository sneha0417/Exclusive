package com.project.execution.ServiceSale;

import java.util.Map;

public class ClsServiceSaleBean {
	
	private String nipurchasedate;
	private String hidnipurchasedate;
	private int  docno,nidescdetailslenght,tarannumber,masterdoc_no,ordermasterdoc_no;
	private String refno,acctype,nipuraccid,puraccname,cmbcurr,hidcmbcurr,currate,deliverydate,hiddeliverydate,delterms,payterms,purdesc,mode,msg, cmbcurrval,acctypeval,accdocno,formdetailcode;
	private String nireftype,deleted,reftypeval,invno,invDate,hidinvDate;
	private String lbldocno,lblmawb,lblmbl,lblhawb,lblhbl,lblshipper,lblconsignee,lblcarrier,lblflightno,lblvessel,lbletd,lbleta,lblttime,lblboe,lblcontainerno,lbltruckno,lblshipqty,lblgrosswt;
	private String lblctcperson,lblclientemail,nettaxamount;
	
	
	
	public String getNettaxamount() {
		return nettaxamount;
	}
	public void setNettaxamount(String nettaxamount) {
		this.nettaxamount = nettaxamount;
	}
	public String getLblctcperson() {
		return lblctcperson;
	}
	public void setLblctcperson(String lblctcperson) {
		this.lblctcperson = lblctcperson;
	}
	public String getLblclientemail() {
		return lblclientemail;
	}
	public void setLblclientemail(String lblclientemail) {
		this.lblclientemail = lblclientemail;
	}
	public String getLbldocno() {
		return lbldocno;
	}
	public void setLbldocno(String lbldocno) {
		this.lbldocno = lbldocno;
	}
	
	public String getLblshipqty() {
		return lblshipqty;
	}
	public void setLblshipqty(String lblshipqty) {
		this.lblshipqty = lblshipqty;
	}
	public String getLblgrosswt() {
		return lblgrosswt;
	}
	public void setLblgrosswt(String lblgrosswt) {
		this.lblgrosswt = lblgrosswt;
	}
	private Double nettotal;
	private String username;
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}

	// for print 
	private String lblbranchtrno,lblcltrnno;
	private String lbltaxamount,lblnettaxamount,lblamountinwords;
	private String lbldate,lbltype,docvals,lblacno,lblacnoname,lbldeldate,lbldddtm,lblpatms,lbldsc,telno,companytrno;
	
	private String lblvenaddress,lblvenphon,lblvenland,lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname,lblinvno,lblinvdate,lblnettotal,tel,fax,email,attn,wordnetamount;	
	
	private String lbllogoimgpath,lblcompbranchaddress,lblbankdetails,lblbankbeneficiary,lblbankaccountno,lblbeneficiarybank,lblbankibanno;
	
	private int interstate;
	private int hidinterstate;

	//cargo////
	private String lblbranchaddress,lblbranchtel,lblbranchfax;
	private String lbljobno,lblcustomerref,lblclientname,lblclientaddress,lblclienttel,lblclientfax,lblwordsamount;
	private String lblgrossrate,lblgrossamount,lbldiscount,lbltaxablerate,lbltaxableamount,lblvatamount,lblnetamount;
	
	
	////
        
	public String getLbljobno() {
		return lbljobno;
	}
	public void setLbljobno(String lbljobno) {
		this.lbljobno = lbljobno;
	}
	public String getLblcustomerref() {
		return lblcustomerref;
	}
	public void setLblcustomerref(String lblcustomerref) {
		this.lblcustomerref = lblcustomerref;
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
	public String getLblclienttel() {
		return lblclienttel;
	}
	public void setLblclienttel(String lblclienttel) {
		this.lblclienttel = lblclienttel;
	}
	public String getLblclientfax() {
		return lblclientfax;
	}
	public void setLblclientfax(String lblclientfax) {
		this.lblclientfax = lblclientfax;
	}
	public String getLblwordsamount() {
		return lblwordsamount;
	}
	public void setLblwordsamount(String lblwordsamount) {
		this.lblwordsamount = lblwordsamount;
	}
	
	public String getLblgrossrate() {
		return lblgrossrate;
	}
	public void setLblgrossrate(String lblgrossrate) {
		this.lblgrossrate = lblgrossrate;
	}
	public String getLblgrossamount() {
		return lblgrossamount;
	}
	public void setLblgrossamount(String lblgrossamount) {
		this.lblgrossamount = lblgrossamount;
	}
	public String getLbldiscount() {
		return lbldiscount;
	}
	public void setLbldiscount(String lbldiscount) {
		this.lbldiscount = lbldiscount;
	}
	public String getLbltaxablerate() {
		return lbltaxablerate;
	}
	public void setLbltaxablerate(String lbltaxablerate) {
		this.lbltaxablerate = lbltaxablerate;
	}
	public String getLbltaxableamount() {
		return lbltaxableamount;
	}
	public void setLbltaxableamount(String lbltaxableamount) {
		this.lbltaxableamount = lbltaxableamount;
	}
	public String getLblvatamount() {
		return lblvatamount;
	}
	public void setLblvatamount(String lblvatamount) {
		this.lblvatamount = lblvatamount;
	}
	public String getLblnetamount() {
		return lblnetamount;
	}
	public void setLblnetamount(String lblnetamount) {
		this.lblnetamount = lblnetamount;
	}
	public String getLblbranchaddress() {
		return lblbranchaddress;
	}
	public void setLblbranchaddress(String lblbranchaddress) {
		this.lblbranchaddress = lblbranchaddress;
	}
	public String getLblbranchtel() {
		return lblbranchtel;
	}
	public void setLblbranchtel(String lblbranchtel) {
		this.lblbranchtel = lblbranchtel;
	}
	public String getLblbranchfax() {
		return lblbranchfax;
	}
	public void setLblbranchfax(String lblbranchfax) {
		this.lblbranchfax = lblbranchfax;
	}
        
	public String getTelno() {
		return telno;
	}
	public void setTelno(String telno) {
		this.telno = telno;
	}
	public String getCompanytrno() {
		return companytrno;
	}
	public void setCompanytrno(String companytrno) {
		this.companytrno = companytrno;
	}
	
	
	public String getLblvenaddress() {
		return lblvenaddress;
	}

	public void setLblvenaddress(String lblvenaddress) {
		this.lblvenaddress = lblvenaddress;
	}

	public String getLblvenphon() {
		return lblvenphon;
	}

	public void setLblvenphon(String lblvenphon) {
		this.lblvenphon = lblvenphon;
	}

	public String getLblvenland() {
		return lblvenland;
	}

	public void setLblvenland(String lblvenland) {
		this.lblvenland = lblvenland;
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

	public String getLbltaxamount() {
		return lbltaxamount;
	}

	public void setLbltaxamount(String lbltaxamount) {
		this.lbltaxamount = lbltaxamount;
	}

	public String getLblnettaxamount() {
		return lblnettaxamount;
	}

	public void setLblnettaxamount(String lblnettaxamount) {
		this.lblnettaxamount = lblnettaxamount;
	}

	public String getLblamountinwords() {
		return lblamountinwords;
	}

	public void setLblamountinwords(String lblamountinwords) {
		this.lblamountinwords = lblamountinwords;
	}
	
	public String getLbllogoimgpath() {
		return lbllogoimgpath;
	}
	public void setLbllogoimgpath(String lbllogoimgpath) {
		this.lbllogoimgpath = lbllogoimgpath;
	}
	public String getLblcompbranchaddress() {
		return lblcompbranchaddress;
	}
	public void setLblcompbranchaddress(String lblcompbranchaddress) {
		this.lblcompbranchaddress = lblcompbranchaddress;
	}
	public String getLblbankdetails() {
		return lblbankdetails;
	}
	public void setLblbankdetails(String lblbankdetails) {
		this.lblbankdetails = lblbankdetails;
	}
	public String getLblbankbeneficiary() {
		return lblbankbeneficiary;
	}
	public void setLblbankbeneficiary(String lblbankbeneficiary) {
		this.lblbankbeneficiary = lblbankbeneficiary;
	}
	public String getLblbankaccountno() {
		return lblbankaccountno;
	}
	public void setLblbankaccountno(String lblbankaccountno) {
		this.lblbankaccountno = lblbankaccountno;
	}
	public String getLblbeneficiarybank() {
		return lblbeneficiarybank;
	}
	public void setLblbeneficiarybank(String lblbeneficiarybank) {
		this.lblbeneficiarybank = lblbeneficiarybank;
	}
	public String getLblbankibanno() {
		return lblbankibanno;
	}
	public void setLblbankibanno(String lblbankibanno) {
		this.lblbankibanno = lblbankibanno;
	}
	public int getInterstate() {
		return interstate;
	}

	public void setInterstate(int interstate) {
		this.interstate = interstate;
	}

	public int getHidinterstate() {
		return hidinterstate;
	}

	public void setHidinterstate(int hidinterstate) {
		this.hidinterstate = hidinterstate;
	}

	private Map<String, Object> param=null;

	public String getNipurchasedate() {
		return nipurchasedate;
	}

	public void setNipurchasedate(String nipurchasedate) {
		this.nipurchasedate = nipurchasedate;
	}

	public String getHidnipurchasedate() {
		return hidnipurchasedate;
	}

	public void setHidnipurchasedate(String hidnipurchasedate) {
		this.hidnipurchasedate = hidnipurchasedate;
	}

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public int getNidescdetailslenght() {
		return nidescdetailslenght;
	}

	public void setNidescdetailslenght(int nidescdetailslenght) {
		this.nidescdetailslenght = nidescdetailslenght;
	}

	public int getTarannumber() {
		return tarannumber;
	}

	public void setTarannumber(int tarannumber) {
		this.tarannumber = tarannumber;
	}

	public int getMasterdoc_no() {
		return masterdoc_no;
	}

	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}

	public int getOrdermasterdoc_no() {
		return ordermasterdoc_no;
	}

	public void setOrdermasterdoc_no(int ordermasterdoc_no) {
		this.ordermasterdoc_no = ordermasterdoc_no;
	}

	public String getRefno() {
		return refno;
	}

	public void setRefno(String refno) {
		this.refno = refno;
	}

	public String getAcctype() {
		return acctype;
	}

	public void setAcctype(String acctype) {
		this.acctype = acctype;
	}

	public String getNipuraccid() {
		return nipuraccid;
	}

	public void setNipuraccid(String nipuraccid) {
		this.nipuraccid = nipuraccid;
	}

	public String getPuraccname() {
		return puraccname;
	}

	public void setPuraccname(String puraccname) {
		this.puraccname = puraccname;
	}

	public String getCmbcurr() {
		return cmbcurr;
	}

	public void setCmbcurr(String cmbcurr) {
		this.cmbcurr = cmbcurr;
	}

	public String getHidcmbcurr() {
		return hidcmbcurr;
	}

	public void setHidcmbcurr(String hidcmbcurr) {
		this.hidcmbcurr = hidcmbcurr;
	}

	public String getCurrate() {
		return currate;
	}

	public void setCurrate(String currate) {
		this.currate = currate;
	}

	public String getDeliverydate() {
		return deliverydate;
	}

	public void setDeliverydate(String deliverydate) {
		this.deliverydate = deliverydate;
	}

	public String getHiddeliverydate() {
		return hiddeliverydate;
	}

	public void setHiddeliverydate(String hiddeliverydate) {
		this.hiddeliverydate = hiddeliverydate;
	}

	public String getDelterms() {
		return delterms;
	}

	public void setDelterms(String delterms) {
		this.delterms = delterms;
	}

	public String getPayterms() {
		return payterms;
	}

	public void setPayterms(String payterms) {
		this.payterms = payterms;
	}

	public String getPurdesc() {
		return purdesc;
	}

	public void setPurdesc(String purdesc) {
		this.purdesc = purdesc;
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

	public String getCmbcurrval() {
		return cmbcurrval;
	}

	public void setCmbcurrval(String cmbcurrval) {
		this.cmbcurrval = cmbcurrval;
	}

	public String getAcctypeval() {
		return acctypeval;
	}

	public void setAcctypeval(String acctypeval) {
		this.acctypeval = acctypeval;
	}

	public String getAccdocno() {
		return accdocno;
	}

	public void setAccdocno(String accdocno) {
		this.accdocno = accdocno;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getNireftype() {
		return nireftype;
	}

	public void setNireftype(String nireftype) {
		this.nireftype = nireftype;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public String getReftypeval() {
		return reftypeval;
	}

	public void setReftypeval(String reftypeval) {
		this.reftypeval = reftypeval;
	}

	public String getInvno() {
		return invno;
	}

	public void setInvno(String invno) {
		this.invno = invno;
	}

	public String getInvDate() {
		return invDate;
	}

	public void setInvDate(String invDate) {
		this.invDate = invDate;
	}

	public String getHidinvDate() {
		return hidinvDate;
	}

	public void setHidinvDate(String hidinvDate) {
		this.hidinvDate = hidinvDate;
	}

	public Double getNettotal() {
		return nettotal;
	}

	public void setNettotal(Double nettotal) {
		this.nettotal = nettotal;
	}

	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}

	public String getLbltype() {
		return lbltype;
	}

	public void setLbltype(String lbltype) {
		this.lbltype = lbltype;
	}

	public String getDocvals() {
		return docvals;
	}

	public void setDocvals(String docvals) {
		this.docvals = docvals;
	}

	public String getLblacno() {
		return lblacno;
	}

	public void setLblacno(String lblacno) {
		this.lblacno = lblacno;
	}

	public String getLblacnoname() {
		return lblacnoname;
	}

	public void setLblacnoname(String lblacnoname) {
		this.lblacnoname = lblacnoname;
	}

	public String getLbldeldate() {
		return lbldeldate;
	}

	public void setLbldeldate(String lbldeldate) {
		this.lbldeldate = lbldeldate;
	}

	public String getLbldddtm() {
		return lbldddtm;
	}

	public void setLbldddtm(String lbldddtm) {
		this.lbldddtm = lbldddtm;
	}

	public String getLblpatms() {
		return lblpatms;
	}

	public void setLblpatms(String lblpatms) {
		this.lblpatms = lblpatms;
	}

	public String getLbldsc() {
		return lbldsc;
	}

	public void setLbldsc(String lbldsc) {
		this.lbldsc = lbldsc;
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

	public String getLblprintname() {
		return lblprintname;
	}

	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}

	public String getLblinvno() {
		return lblinvno;
	}

	public void setLblinvno(String lblinvno) {
		this.lblinvno = lblinvno;
	}

	public String getLblinvdate() {
		return lblinvdate;
	}

	public void setLblinvdate(String lblinvdate) {
		this.lblinvdate = lblinvdate;
	}

	public String getLblnettotal() {
		return lblnettotal;
	}

	public void setLblnettotal(String lblnettotal) {
		this.lblnettotal = lblnettotal;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAttn() {
		return attn;
	}

	public void setAttn(String attn) {
		this.attn = attn;
	}

	public String getWordnetamount() {
		return wordnetamount;
	}

	public void setWordnetamount(String wordnetamount) {
		this.wordnetamount = wordnetamount;
	}

	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	public String getLblmawb() {
			return lblmawb;
		}

		public void setLblmawb(String lblmawb) {
			this.lblmawb = lblmawb;
		}

		public String getLblmbl() {
			return lblmbl;
		}

		public void setLblmbl(String lblmbl) {
			this.lblmbl = lblmbl;
		}

		public String getLblhawb() {
			return lblhawb;
		}

		public void setLblhawb(String lblhawb) {
			this.lblhawb = lblhawb;
		}

		public String getLblhbl() {
			return lblhbl;
		}

		public void setLblhbl(String lblhbl) {
			this.lblhbl = lblhbl;
		}

		public String getLblshipper() {
			return lblshipper;
		}

		public void setLblshipper(String lblshipper) {
			this.lblshipper = lblshipper;
		}

		public String getLblconsignee() {
			return lblconsignee;
		}

		public void setLblconsignee(String lblconsignee) {
			this.lblconsignee = lblconsignee;
		}

		public String getLblcarrier() {
			return lblcarrier;
		}

		public void setLblcarrier(String lblcarrier) {
			this.lblcarrier = lblcarrier;
		}

		public String getLblflightno() {
			return lblflightno;
		}

		public void setLblflightno(String lblflightno) {
			this.lblflightno = lblflightno;
		}

		public String getLblvessel() {
			return lblvessel;
		}

		public void setLblvessel(String lblvessel) {
			this.lblvessel = lblvessel;
		}

		public String getLbletd() {
			return lbletd;
		}

		public void setLbletd(String lbletd) {
			this.lbletd = lbletd;
		}

		public String getLbleta() {
			return lbleta;
		}

		public void setLbleta(String lbleta) {
			this.lbleta = lbleta;
		}

		public String getLblttime() {
			return lblttime;
		}

		public void setLblttime(String lblttime) {
			this.lblttime = lblttime;
		}

		public String getLblboe() {
			return lblboe;
		}

		public void setLblboe(String lblboe) {
			this.lblboe = lblboe;
		}

		public String getLblcontainerno() {
			return lblcontainerno;
		}

		public void setLblcontainerno(String lblcontainerno) {
			this.lblcontainerno = lblcontainerno;
		}

		public String getLbltruckno() {
			return lbltruckno;
		}

		public void setLbltruckno(String lbltruckno) {
			this.lbltruckno = lbltruckno;
		}
	
	
}
