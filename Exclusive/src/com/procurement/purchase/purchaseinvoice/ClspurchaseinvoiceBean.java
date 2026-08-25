package com.procurement.purchase.purchaseinvoice;
 
 
public class ClspurchaseinvoiceBean

{
 
	
	private String  invdate,hidinvdate,invno,txtlocation,masterdate,hidmasterdate,deliverydate,hiddeliverydate,delterms,payterms,purdesc,msg,mode,deleted,formdetailcode,puraccname,reqmasterdocno,refno,reftype,rrefno,reftypeval;
	
	private double currate,productTotal,descPercentage,descountVal,roundOf,netTotaldown,nettotal,orderValue,cmbcurrval,prddiscount,expencenettotal,descgridhid,descgridtax;
	
	private int docno,cmbcurr,chkdiscount,accdocno,descgridlenght,serviecGridlength,masterdoc_no,chkdiscountval,puraccid,txtlocationid;

	
	
	private String venland,venphon,lblpreparedby,lblpreparedon,lblpreparedat,lblverifiedby,lblapprovedby,lblverifiedon,lblapprovedon,lblapprovedat,lblverifiedat;
	 
 private String watermarks;
	
	private double st,taxontax1,taxontax2,taxontax3,taxtotal;
	
	
	private int cmbbilltype,hidcmbbilltype;
	
	
	 private int  hideitemtype, itemdocno,itemtype,costtr_no;
	 
	


	private String itemname,aitsprdchrg,aitssrcchrg,aitsnetdiscount,aitstax,aitsnettotal,aitsnettotword;
	 private String tinno,companytrno;
	
	

	
	public String getTinno() {
		return tinno;
	}

	public void setTinno(String tinno) {
		this.tinno = tinno;
	}

	public String getCompanytrno() {
		return companytrno;
	}

	public void setCompanytrno(String companytrno) {
		this.companytrno = companytrno;
	}


	

	
	public String getAitsprdchrg() {
		return aitsprdchrg;
	}

	public void setAitsprdchrg(String aitsprdchrg) {
		this.aitsprdchrg = aitsprdchrg;
	}

	public String getAitssrcchrg() {
		return aitssrcchrg;
	}

	public void setAitssrcchrg(String aitssrcchrg) {
		this.aitssrcchrg = aitssrcchrg;
	}

	public String getAitsnetdiscount() {
		return aitsnetdiscount;
	}

	public void setAitsnetdiscount(String aitsnetdiscount) {
		this.aitsnetdiscount = aitsnetdiscount;
	}

	public String getAitstax() {
		return aitstax;
	}

	public void setAitstax(String aitstax) {
		this.aitstax = aitstax;
	}

	public String getAitsnettotal() {
		return aitsnettotal;
	}

	public void setAitsnettotal(String aitsnettotal) {
		this.aitsnettotal = aitsnettotal;
	}

	public String getAitsnettotword() {
		return aitsnettotword;
	}

	public void setAitsnettotword(String aitsnettotword) {
		this.aitsnettotword = aitsnettotword;
	}


	
	

	
	public int getHideitemtype() {
		return hideitemtype;
	}

	public void setHideitemtype(int hideitemtype) {
		this.hideitemtype = hideitemtype;
	}

	public int getItemdocno() {
		return itemdocno;
	}

	public void setItemdocno(int itemdocno) {
		this.itemdocno = itemdocno;
	}

	public int getItemtype() {
		return itemtype;
	}

	public void setItemtype(int itemtype) {
		this.itemtype = itemtype;
	}

	public int getCosttr_no() {
		return costtr_no;
	}

	public void setCosttr_no(int costtr_no) {
		this.costtr_no = costtr_no;
	}

	public String getItemname() {
		return itemname;
	}

	public void setItemname(String itemname) {
		this.itemname = itemname;
	}

	public String getWatermarks() {
		return watermarks;
	}

	public void setWatermarks(String watermarks) {
		this.watermarks = watermarks;
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

	public double getSt() {
		return st;
	}

	public void setSt(double st) {
		this.st = st;
	}

	public double getTaxontax1() {
		return taxontax1;
	}

	public void setTaxontax1(double taxontax1) {
		this.taxontax1 = taxontax1;
	}

	public double getTaxontax2() {
		return taxontax2;
	}

	public void setTaxontax2(double taxontax2) {
		this.taxontax2 = taxontax2;
	}

	public double getTaxontax3() {
		return taxontax3;
	}

	public void setTaxontax3(double taxontax3) {
		this.taxontax3 = taxontax3;
	}

	public double getTaxtotal() {
		return taxtotal;
	}

	public void setTaxtotal(double taxtotal) {
		this.taxtotal = taxtotal;
	}

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

	public String getInvdate() {
		return invdate;
	}

	public void setInvdate(String invdate) {
		this.invdate = invdate;
	}

	public String getHidinvdate() {
		return hidinvdate;
	}

	public void setHidinvdate(String hidinvdate) {
		this.hidinvdate = hidinvdate;
	}

	public String getInvno() {
		return invno;
	}

	public void setInvno(String invno) {
		this.invno = invno;
	}

	public String getTxtlocation() {
		return txtlocation;
	}

	public void setTxtlocation(String txtlocation) {
		this.txtlocation = txtlocation;
	}

	public int getTxtlocationid() {
		return txtlocationid;
	}

	public void setTxtlocationid(int txtlocationid) {
		this.txtlocationid = txtlocationid;
	}

	public double getExpencenettotal() {
		return expencenettotal;
	}

	public void setExpencenettotal(double expencenettotal) {
		this.expencenettotal = expencenettotal;
	}

	public String getMasterdate() {
		return masterdate;
	}

	public void setMasterdate(String masterdate) {       
		this.masterdate = masterdate;
	}

	public String getHidmasterdate() {
		return hidmasterdate;
	}

	public void setHidmasterdate(String hidmasterdate) {
		this.hidmasterdate = hidmasterdate;
	}

	public double getPrddiscount() {
		return prddiscount;
	}

	public void setPrddiscount(double prddiscount) {
		this.prddiscount = prddiscount;
	}

	public String getReqmasterdocno() {
		return reqmasterdocno;
	}

	public void setReqmasterdocno(String reqmasterdocno) {
		this.reqmasterdocno = reqmasterdocno;
	}

	public double getDescgridhid() {
		return descgridhid;
	}

	public void setDescgridhid(double descgridhid) {
		this.descgridhid = descgridhid;
	}

	public double getDescgridtax() {
		return descgridtax;
	}

	public void setDescgridtax(double descgridtax) {
		this.descgridtax = descgridtax;
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

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
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

	public String getPuraccname() {
		return puraccname;
	}

	public void setPuraccname(String puraccname) {
		this.puraccname = puraccname;
	}

	public double getCurrate() {
		return currate;
	}

	public void setCurrate(double currate) {
		this.currate = currate;
	}

	public double getProductTotal() {
		return productTotal;
	}

	public void setProductTotal(double productTotal) {
		this.productTotal = productTotal;
	}

	public double getDescPercentage() {
		return descPercentage;
	}

	public void setDescPercentage(double descPercentage) {
		this.descPercentage = descPercentage;
	}

	public double getDescountVal() {
		return descountVal;
	}

	public void setDescountVal(double descountVal) {
		this.descountVal = descountVal;
	}

	public double getRoundOf() {
		return roundOf;
	}

	public void setRoundOf(double roundOf) {
		this.roundOf = roundOf;
	}

	public double getNetTotaldown() {
		return netTotaldown;
	}

	public void setNetTotaldown(double netTotaldown) {
		this.netTotaldown = netTotaldown;
	}

	public double getNettotal() {
		return nettotal;
	}

	public void setNettotal(double nettotal) {
		this.nettotal = nettotal;
	}

	public double getOrderValue() {
		return orderValue;
	}

	public void setOrderValue(double orderValue) {
		this.orderValue = orderValue;
	}

	public double getCmbcurrval() {
		return cmbcurrval;
	}

	public void setCmbcurrval(double cmbcurrval) {
		this.cmbcurrval = cmbcurrval;
	}

	public String getRefno() {
		return refno;
	}

	public void setRefno(String refno) {
		this.refno = refno;
	}

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public int getCmbcurr() {
		return cmbcurr;
	}

	public void setCmbcurr(int cmbcurr) {
		this.cmbcurr = cmbcurr;
	}

	public int getChkdiscount() {
		return chkdiscount;
	}

	public void setChkdiscount(int chkdiscount) {
		this.chkdiscount = chkdiscount;
	}

	public int getAccdocno() {
		return accdocno;
	}

	public void setAccdocno(int accdocno) {
		this.accdocno = accdocno;
	}

	public int getDescgridlenght() {
		return descgridlenght;
	}

	public void setDescgridlenght(int descgridlenght) {
		this.descgridlenght = descgridlenght;
	}

	public int getServiecGridlength() {
		return serviecGridlength;
	}

	public void setServiecGridlength(int serviecGridlength) {
		this.serviecGridlength = serviecGridlength;
	}

	public int getMasterdoc_no() {
		return masterdoc_no;
	}

	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}

	public int getChkdiscountval() {
		return chkdiscountval;
	}

	public void setChkdiscountval(int chkdiscountval) {
		this.chkdiscountval = chkdiscountval;
	}

	public int getPuraccid() {
		return puraccid;
	}

	public void setPuraccid(int puraccid) {
		this.puraccid = puraccid;
	}

	public String getReftype() {
		return reftype;
	}

	public void setReftype(String reftype) {
		this.reftype = reftype;
	}

	public String getRrefno() {
		return rrefno;
	}

	public void setRrefno(String rrefno) {
		this.rrefno = rrefno;
	}

	public String getReftypeval() {
		return reftypeval;
	}

	public void setReftypeval(String reftypeval) {
		this.reftypeval = reftypeval;
	}
	
	
	
	

	private String lbldate,lbltype,lblvendoeacc,lblvendoeaccName,lbltrnno, expdeldate,lbldelterms ,lblpaytems, lbldesc1,lblrefno,lblinvno,lblinvdate,lblloc;
	
	
	private int lbldoc;


	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname,lblbranchtrno;





	private String  lblsubtotal,lbltotal,lbltax,lblroundOf,lbltotnetamnt,lblnetamount,lblnetTotaldown,lblordervalue,lblordervaluewords,lblsubtotalexp,lblexptotal;
	
	
	private int firstarray,secarray,thirdarray;



	public String getLblroundOf() {
		return lblroundOf;
	}

	public void setLblroundOf(String lblroundOf) {
		this.lblroundOf = lblroundOf;
	}

	public String getLbltotnetamnt() {
		return lbltotnetamnt;
	}

	public void setLbltotnetamnt(String lbltotnetamnt) {
		this.lbltotnetamnt = lbltotnetamnt;
	}

	public String getLblbranchtrno() {
		return lblbranchtrno;
	}

	public void setLblbranchtrno(String lblbranchtrno) {
		this.lblbranchtrno = lblbranchtrno;
	}

	public String getLbltax() {
		return lbltax;
	}

	public void setLbltax(String lbltax) {
		this.lbltax = lbltax;
	}

	public String getLblnetamount() {
		return lblnetamount;
	}

	public void setLblnetamount(String lblnetamount) {
		this.lblnetamount = lblnetamount;
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

	public String getLblvendoeacc() {
		return lblvendoeacc;
	}

	public void setLblvendoeacc(String lblvendoeacc) {
		this.lblvendoeacc = lblvendoeacc;
	}

	public String getLblvendoeaccName() {
		return lblvendoeaccName;
	}

	public void setLblvendoeaccName(String lblvendoeaccName) {
		this.lblvendoeaccName = lblvendoeaccName;
	}

	public String getLbltrnno() {
		return lbltrnno;
	}

	public void setLbltrnno(String lbltrnno) {
		this.lbltrnno = lbltrnno;
	}

	public String getExpdeldate() {
		return expdeldate;
	}

	public void setExpdeldate(String expdeldate) {
		this.expdeldate = expdeldate;
	}

	public String getLbldelterms() {
		return lbldelterms;
	}

	public void setLbldelterms(String lbldelterms) {
		this.lbldelterms = lbldelterms;
	}

	public String getLblpaytems() {
		return lblpaytems;
	}

	public void setLblpaytems(String lblpaytems) {
		this.lblpaytems = lblpaytems;
	}

	public String getLbldesc1() {
		return lbldesc1;
	}

	public void setLbldesc1(String lbldesc1) {
		this.lbldesc1 = lbldesc1;
	}

	public String getLblrefno() {
		return lblrefno;
	}

	public void setLblrefno(String lblrefno) {
		this.lblrefno = lblrefno;
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

	public String getLblloc() {
		return lblloc;
	}

	public void setLblloc(String lblloc) {
		this.lblloc = lblloc;
	}

	public int getLbldoc() {
		return lbldoc;
	}

	public void setLbldoc(int lbldoc) {
		this.lbldoc = lbldoc;
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

	public String getLblsubtotal() {
		return lblsubtotal;
	}

	public void setLblsubtotal(String lblsubtotal) {
		this.lblsubtotal = lblsubtotal;
	}

	public String getLbltotal() {
		return lbltotal;
	}

	public void setLbltotal(String lbltotal) {
		this.lbltotal = lbltotal;
	}

	public String getLblordervalue() {
		return lblordervalue;
	}

	public void setLblordervalue(String lblordervalue) {
		this.lblordervalue = lblordervalue;
	}

	public String getLblordervaluewords() {
		return lblordervaluewords;
	}

	public void setLblordervaluewords(String lblordervaluewords) {
		this.lblordervaluewords = lblordervaluewords;
	}

	public int getFirstarray() {
		return firstarray;
	}

	public void setFirstarray(int firstarray) {
		this.firstarray = firstarray;
	}

	public int getSecarray() {
		return secarray;
	}

	public void setSecarray(int secarray) {
		this.secarray = secarray;
	}

	public int getThirdarray() {
		return thirdarray;
	}

	public void setThirdarray(int thirdarray) {
		this.thirdarray = thirdarray;
	}

	public String getLblsubtotalexp() {
		return lblsubtotalexp;
	}

	public void setLblsubtotalexp(String lblsubtotalexp) {
		this.lblsubtotalexp = lblsubtotalexp;
	}	

	private String attn,tel,fax,email,wordnetamount;
	private String termQry,prdQry;
	private String srvQyy,prdtotal,srvtotal,wordnetAmtPrint,netAmountprint;




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

	public String getWordnetamount() {
		return wordnetamount;
	}

	public void setWordnetamount(String wordnetamount) {
		this.wordnetamount = wordnetamount;
	}

	public String getTermQry() {
		return termQry;
	}

	public void setTermQry(String termQry) {
		this.termQry = termQry;
	}

	public String getPrdQry() {
		return prdQry;
	}

	public void setPrdQry(String prdQry) {
		this.prdQry = prdQry;
	}

	public String getSrvQyy() {
		return srvQyy;
	}

	public void setSrvQyy(String srvQyy) {
		this.srvQyy = srvQyy;
	}

	public String getPrdtotal() {
		return prdtotal;
	}

	public void setPrdtotal(String prdtotal) {
		this.prdtotal = prdtotal;
	}

	public String getSrvtotal() {
		return srvtotal;
	}

	public void setSrvtotal(String srvtotal) {
		this.srvtotal = srvtotal;
	}

	public String getWordnetAmtPrint() {
		return wordnetAmtPrint;
	}

	public void setWordnetAmtPrint(String wordnetAmtPrint) {
		this.wordnetAmtPrint = wordnetAmtPrint;
	}

	public String getNetAmountprint() {
		return netAmountprint;
	}

	public void setNetAmountprint(String netAmountprint) {
		this.netAmountprint = netAmountprint;
	}

	public String getLblnetTotaldown() {
		return lblnetTotaldown;
	}

	public void setLblnetTotaldown(String lblnetTotaldown) {
		this.lblnetTotaldown = lblnetTotaldown;
	}

	public String getLblexptotal() {
		return lblexptotal;
	}

	public void setLblexptotal(String lblexptotal) {
		this.lblexptotal = lblexptotal;
	}
	
	

}
