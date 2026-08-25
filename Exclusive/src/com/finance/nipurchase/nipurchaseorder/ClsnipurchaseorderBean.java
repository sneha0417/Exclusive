package com.finance.nipurchase.nipurchaseorder;

import java.io.IOException;


public class ClsnipurchaseorderBean {
	private String nipurchaseorderdate;
	private String hidnipurchaseorderdate;
	private int  docno,descgridlenght;
	private String acctype,puraccid,puraccname,cmbcurr,currate,deliverydate,hiddeliverydate,delterms,payterms,purdesc,mode,msg, cmbcurrval,acctypeval,accdocno,formdetailcode;
	private String deleted;
	private Double nettotal;
	private int masterdoc_no;
	private String venland,venphon,lblrefno,lblpreparedby,lblpreparedon,lblpreparedat,lblverifiedby,lblapprovedby,lblverifiedon,lblapprovedon,lblapprovedat,lblverifiedat;
	
	private int taxaccount,hideproducttype;
	
	private double taxpers ;
	
	private String txtproducttype;
	private String uname,udate,utime;
	
	private String lbltaxtot,lbltotal,lbldiscount,lbltotinword;
	
	private String lblcomptrn,lblclienttrn;
		
	
		
		public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getUdate() {
		return udate;
	}
	public void setUdate(String udate) {
		this.udate = udate;
	}
	public String getUtime() {
		return utime;
	}
	public void setUtime(String utime) {
		this.utime = utime;
	}
		public String getLblcomptrn() {
			return lblcomptrn;
		}
		public void setLblcomptrn(String lblcomptrn) {
			this.lblcomptrn = lblcomptrn;
		}
		public String getLblclienttrn() {
			return lblclienttrn;
		}
		public void setLblclienttrn(String lblclienttrn) {
			this.lblclienttrn = lblclienttrn;
		}
	
	public String getLbltaxtot() {
		return lbltaxtot;
	}

	public void setLbltaxtot(String lbltaxtot) {
		this.lbltaxtot = lbltaxtot;
	}

	public String getLbltotal() {
		return lbltotal;
	}

	public void setLbltotal(String lbltotal) {
		this.lbltotal = lbltotal;
	}

	public String getLbldiscount() {
		return lbldiscount;
	}

	public void setLbldiscount(String lbldiscount) {
		this.lbldiscount = lbldiscount;
	}

	public String getLbltotinword() {
		return lbltotinword;
	}

	public void setLbltotinword(String lbltotinword) {
		this.lbltotinword = lbltotinword;
	}

	public int getTaxaccount() {
		return taxaccount;
	}

	public void setTaxaccount(int taxaccount) {
		this.taxaccount = taxaccount;
	}

	public int getHideproducttype() {
		return hideproducttype;
	}

	public void setHideproducttype(int hideproducttype) {
		this.hideproducttype = hideproducttype;
	}

	public double getTaxpers() {
		return taxpers;
	}

	public void setTaxpers(double taxpers) {
		this.taxpers = taxpers;
	}

	public String getTxtproducttype() {
		return txtproducttype;
	}

	public void setTxtproducttype(String txtproducttype) {
		this.txtproducttype = txtproducttype;
	}

	public String getNipurchaseorderdate() {
		return nipurchaseorderdate;
	}

	public void setNipurchaseorderdate(String nipurchaseorderdate) {
		this.nipurchaseorderdate = nipurchaseorderdate;
	}

	public String getHidnipurchaseorderdate() {
		return hidnipurchaseorderdate;
	}

	public void setHidnipurchaseorderdate(String hidnipurchaseorderdate) {
		this.hidnipurchaseorderdate = hidnipurchaseorderdate;
	}

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public int getDescgridlenght() {
		return descgridlenght;
	}

	public void setDescgridlenght(int descgridlenght) {
		this.descgridlenght = descgridlenght;
	}

	public String getAcctype() {
		return acctype;
	}

	public void setAcctype(String acctype) {
		this.acctype = acctype;
	}

	public String getPuraccid() {
		return puraccid;
	}

	public void setPuraccid(String puraccid) {
		this.puraccid = puraccid;
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

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public Double getNettotal() {
		return nettotal;
	}

	public void setNettotal(Double nettotal) {
		this.nettotal = nettotal;
	}

	public int getMasterdoc_no() {
		return masterdoc_no;
	}

	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}

	public String getVenland() {
		return venland;
	}

	public void setVenland(String venland) {
		this.venland = venland;
	}

	public String getVenphon() {
		return venphon;
	}

	public void setVenphon(String venphon) {
		this.venphon = venphon;
	}

	public String getLblrefno() {
		return lblrefno;
	}

	public void setLblrefno(String lblrefno) {
		this.lblrefno = lblrefno;
	}

	public String getLblpreparedby() {
		return lblpreparedby;
	}

	public void setLblpreparedby(String lblpreparedby) {
		this.lblpreparedby = lblpreparedby;
	}

	public String getLblpreparedon() {
		return lblpreparedon;
	}

	public void setLblpreparedon(String lblpreparedon) {
		this.lblpreparedon = lblpreparedon;
	}

	public String getLblpreparedat() {
		return lblpreparedat;
	}

	public void setLblpreparedat(String lblpreparedat) {
		this.lblpreparedat = lblpreparedat;
	}

	public String getLblverifiedby() {
		return lblverifiedby;
	}

	public void setLblverifiedby(String lblverifiedby) {
		this.lblverifiedby = lblverifiedby;
	}

	public String getLblapprovedby() {
		return lblapprovedby;
	}

	public void setLblapprovedby(String lblapprovedby) {
		this.lblapprovedby = lblapprovedby;
	}

	public String getLblverifiedon() {
		return lblverifiedon;
	}

	public void setLblverifiedon(String lblverifiedon) {
		this.lblverifiedon = lblverifiedon;
	}

	public String getLblapprovedon() {
		return lblapprovedon;
	}

	public void setLblapprovedon(String lblapprovedon) {
		this.lblapprovedon = lblapprovedon;
	}

	public String getLblapprovedat() {
		return lblapprovedat;
	}

	public void setLblapprovedat(String lblapprovedat) {
		this.lblapprovedat = lblapprovedat;
	}

	public String getLblverifiedat() {
		return lblverifiedat;
	}

	public void setLblverifiedat(String lblverifiedat) {
		this.lblverifiedat = lblverifiedat;
	}


	// for print 
	private String lbldate,docvals,lblacno,lblacnoname,lbldeldate,lbldddtm,lblpatms,lbldsc,venaddress,contactperson,amountinwords;
	
	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname;	
	
	private String lblnettotal;

	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}



	public String getVenaddress() {
		return venaddress;
	}

	public void setVenaddress(String venaddress) {
		this.venaddress = venaddress;
	}

	public String getContactperson() {
		return contactperson;
	}

	public void setContactperson(String contactperson) {
		this.contactperson = contactperson;
	}

	public String getAmountinwords() {
		return amountinwords;
	}

	public void setAmountinwords(String amountinwords) {
		this.amountinwords = amountinwords;
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

	public String getLblnettotal() {
		return lblnettotal;
	}

	public void setLblnettotal(String lblnettotal) {
		this.lblnettotal = lblnettotal;
	}
	
	
private String attn,tel,fax,email,wordnetamount,refno;

private String descQry,termQry;





public String getDescQry() {
return descQry;
}

public void setDescQry(String descQry) {
this.descQry = descQry;
}

public String getTermQry() {
return termQry;
}

public void setTermQry(String termQry) {
this.termQry = termQry;
}






public String getRefno() {
return refno;
}

public void setRefno(String refno) {
this.refno = refno;
}

public String getWordnetamount() {
	return wordnetamount;
}

public void setWordnetamount(String wordnetamount) {
	this.wordnetamount = wordnetamount;
}

public String getAttn() {
	return attn;
}

public void setAttn(String attn) {
	this.attn = attn;
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


	

	
}
