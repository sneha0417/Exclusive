package com.finance.nipurchase.nipurchase;

 
public class ClsnipurchaseBean {
	
	
	private String nipurchasedate;
	private String hidnipurchasedate;
	private int  docno,nidescdetailslenght,tarannumber,masterdoc_no,ordermasterdoc_no;
	private String acctype,nipuraccid,puraccname,cmbcurr,currate,deliverydate,hiddeliverydate,delterms,payterms,purdesc,mode,msg, cmbcurrval,acctypeval,accdocno,formdetailcode;
	private String nireftype,deleted,reftypeval,invno,invDate,hidinvDate;
	private int cmbbilltype,hidcmbbilltype;
	private Double nettotal;
	
	



	private String lbldate,lbltype,docvals,lblacno,lblacnoname,lbldeldate,lbldddtm,lblpatms,lbldsc,lblinvno,lblinvdate;
	private String lblnettotal,lbltaxtot,lbltotal,lbldiscount,lbltotinword,lblcomptrn,lbltrno;
	
	private int interstate;
	private int hidinterstate;
	
	
	
 
	
	private int taxaccount,hideproducttype;
	
	private double taxpers ;
	
	private String txtproducttype;
	
	
	
	
	
	
	
	public int getCmbbilltype() {
		return cmbbilltype;
	}

	public void setCmbbilltype(int cmbbilltype) {
		this.cmbbilltype = cmbbilltype;
	}

	public int getHidcmbbilltype() {
		return hidcmbbilltype;
	}

	public void setHidcmbbilltype(int hidcmbbilltype) {
		this.hidcmbbilltype = hidcmbbilltype;
	}

	public String getLbltrno() {
		return lbltrno;
	}

	public void setLbltrno(String lbltrno) {
		this.lbltrno = lbltrno;
	}

	public String getLblcomptrn() {
		return lblcomptrn;
	}

	public void setLblcomptrn(String lblcomptrn) {
		this.lblcomptrn = lblcomptrn;
	}

	public String getLbltotinword() {
		return lbltotinword;
	}

	public void setLbltotinword(String lbltotinword) {
		this.lbltotinword = lbltotinword;
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

	public Double getNettotal() {
		return nettotal;
	}

	public void setNettotal(Double nettotal) {
		this.nettotal = nettotal;
	}



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


	
	
	
	public String getLblnettotal() {
		return lblnettotal;
	}

	public void setLblnettotal(String lblnettotal) {
		this.lblnettotal = lblnettotal;
	}





	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname;

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
