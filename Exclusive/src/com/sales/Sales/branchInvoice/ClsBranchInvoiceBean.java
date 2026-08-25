package com.sales.Sales.branchInvoice;

public class ClsBranchInvoiceBean {


	private String date;
	private String hiddate;
	private String txtrefno;
	private String docno;
	private String txtclient;
	private int clientid;
	private String txtclientdet;
	private String txtsalesperson;
	private int salespersonid;
	private String cmbcurr;
	private String currate;
	private String hidcmbcurrency;
	private String cmbreftype;
	private String hidcmbreftype;
	private String rrefno;
	private String txtpaymentterms;
	private String txtdescription;
	private String txtproductamt;
	private String txtdiscount;
	private String txtnettotal;
	private String formdetailcode;
	private String mode;
	private String msg;
	private String deleted;
	private int gridlength;
	private int termsgridlength;
	private int masterdoc_no;
	private String refmasterdocno;
	private String prodsearchtype;
	private String descPercentage;
	private String roundOf;
	private String nettotal;
	private String orderValue;
	private String cmbprice;
	private String hidcmbprice;
	private String cmbmodeofpay;
	private String payDueDate;
	private String hidpayDueDate,txtdelterms,lblduedate;
	private String txtlocation;
	private int    locationid; 
	
	

	private int	shipdatagridlenght,shipdocno;
	
	 
	private String  shipto,shipaddress,contactperson,shiptelephone,shipmob,shipemail,shipfax;
	
	
	private String  lblshipto,lblshipaddress,lblcontactperson,lblshiptelephone,lblshipmob,lblshipemail,lblshipfax;
	
	
	
	
	private double st,taxontax1,taxontax2,taxontax3,taxtotal;
	
	
	private int cmbbilltype,hidcmbbilltype;
	
	
	
	
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
	public String getLblshipto() {
		return lblshipto;
	}
	public void setLblshipto(String lblshipto) {
		this.lblshipto = lblshipto;
	}
	public String getLblshipaddress() {
		return lblshipaddress;
	}
	public void setLblshipaddress(String lblshipaddress) {
		this.lblshipaddress = lblshipaddress;
	}
	public String getLblcontactperson() {
		return lblcontactperson;
	}
	public void setLblcontactperson(String lblcontactperson) {
		this.lblcontactperson = lblcontactperson;
	}
	public String getLblshiptelephone() {
		return lblshiptelephone;
	}
	public void setLblshiptelephone(String lblshiptelephone) {
		this.lblshiptelephone = lblshiptelephone;
	}
	public String getLblshipmob() {
		return lblshipmob;
	}
	public void setLblshipmob(String lblshipmob) {
		this.lblshipmob = lblshipmob;
	}
	public String getLblshipemail() {
		return lblshipemail;
	}
	public void setLblshipemail(String lblshipemail) {
		this.lblshipemail = lblshipemail;
	}
	public String getLblshipfax() {
		return lblshipfax;
	}
	public void setLblshipfax(String lblshipfax) {
		this.lblshipfax = lblshipfax;
	}
	public int getShipdatagridlenght() {
		return shipdatagridlenght;
	}
	public void setShipdatagridlenght(int shipdatagridlenght) {
		this.shipdatagridlenght = shipdatagridlenght;
	}
	public int getShipdocno() {
		return shipdocno;
	}
	public void setShipdocno(int shipdocno) {
		this.shipdocno = shipdocno;
	}
	public String getShipto() {
		return shipto;
	}
	public void setShipto(String shipto) {
		this.shipto = shipto;
	}
	public String getShipaddress() {
		return shipaddress;
	}
	public void setShipaddress(String shipaddress) {
		this.shipaddress = shipaddress;
	}
	public String getContactperson() {
		return contactperson;
	}
	public void setContactperson(String contactperson) {
		this.contactperson = contactperson;
	}
	public String getShiptelephone() {
		return shiptelephone;
	}
	public void setShiptelephone(String shiptelephone) {
		this.shiptelephone = shiptelephone;
	}
	public String getShipmob() {
		return shipmob;
	}
	public void setShipmob(String shipmob) {
		this.shipmob = shipmob;
	}
	public String getShipemail() {
		return shipemail;
	}
	public void setShipemail(String shipemail) {
		this.shipemail = shipemail;
	}
	public String getShipfax() {
		return shipfax;
	}
	public void setShipfax(String shipfax) {
		this.shipfax = shipfax;
	}
	public String getLblduedate() {
		return lblduedate;
	}
	public void setLblduedate(String lblduedate) {
		this.lblduedate = lblduedate;
	}
	public String getTxtdelterms() {
		return txtdelterms;
	}
	public void setTxtdelterms(String txtdelterms) {
		this.txtdelterms = txtdelterms;
	}
	public String getCmbprice() {
		return cmbprice;
	}
	public void setCmbprice(String cmbprice) {
		this.cmbprice = cmbprice;
	}
	public String getHidcmbprice() {
		return hidcmbprice;
	}
	public void setHidcmbprice(String hidcmbprice) {
		this.hidcmbprice = hidcmbprice;
	}
	public String getCmbmodeofpay() {
		return cmbmodeofpay;
	}
	public void setCmbmodeofpay(String cmbmodeofpay) {
		this.cmbmodeofpay = cmbmodeofpay;
	}
	public String getPayDueDate() {
		return payDueDate;
	}
	public void setPayDueDate(String payDueDate) {
		this.payDueDate = payDueDate;
	}
	public String getHidpayDueDate() {
		return hidpayDueDate;
	}
	public void setHidpayDueDate(String hidpayDueDate) {
		this.hidpayDueDate = hidpayDueDate;
	}
	public String getTxtlocation() {
		return txtlocation;
	}
	public void setTxtlocation(String txtlocation) {
		this.txtlocation = txtlocation;
	}
	public int getLocationid() {
		return locationid;
	}
	public void setLocationid(int locationid) {
		this.locationid = locationid;
	}
	public String getOrderValue() {
		return orderValue;
	}
	public void setOrderValue(String orderValue) {
		this.orderValue = orderValue;
	}
	public String getNettotal() {
		return nettotal;
	}
	public void setNettotal(String nettotal) {
		this.nettotal = nettotal;
	}
	public String getRoundOf() {
		return roundOf;
	}
	public void setRoundOf(String roundOf) {
		this.roundOf = roundOf;
	}
	public String getDescPercentage() {
		return descPercentage;
	}
	public void setDescPercentage(String descPercentage) {
		this.descPercentage = descPercentage;
	}
	
	
	public String getHidcmbcurrency() {
		return hidcmbcurrency;
	}
	public void setHidcmbcurrency(String hidcmbcurrency) {
		this.hidcmbcurrency = hidcmbcurrency;
	}
	public String getProdsearchtype() {
		return prodsearchtype;
	}
	public void setProdsearchtype(String prodsearchtype) {
		this.prodsearchtype = prodsearchtype;
	}

	
	public String getRefmasterdocno() {
		return refmasterdocno;
	}
	public void setRefmasterdocno(String refmasterdocno) {
		this.refmasterdocno = refmasterdocno;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
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

	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
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
	public int getClientid() {
		return clientid;
	}
	public void setClientid(int clientid) {
		this.clientid = clientid;
	}
	public String getTxtclientdet() {
		return txtclientdet;
	}
	public void setTxtclientdet(String txtclientdet) {
		this.txtclientdet = txtclientdet;
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

	public String getTxtrefno() {
		return txtrefno;
	}
	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
	}
	public String getTxtsalesperson() {
		return txtsalesperson;
	}
	public void setTxtsalesperson(String txtsalesperson) {
		this.txtsalesperson = txtsalesperson;
	}
	public int getSalespersonid() {
		return salespersonid;
	}
	public void setSalespersonid(int salespersonid) {
		this.salespersonid = salespersonid;
	}
	public String getRrefno() {
		return rrefno;
	}
	public void setRrefno(String rrefno) {
		this.rrefno = rrefno;
	}
	public String getTxtpaymentterms() {
		return txtpaymentterms;
	}
	public void setTxtpaymentterms(String txtpaymentterms) {
		this.txtpaymentterms = txtpaymentterms;
	}
	public String getTxtdescription() {
		return txtdescription;
	}
	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}
	public String getTxtproductamt() {
		return txtproductamt;
	}
	public void setTxtproductamt(String txtproductamt) {
		this.txtproductamt = txtproductamt;
	}
	public String getTxtdiscount() {
		return txtdiscount;
	}
	public void setTxtdiscount(String txtdiscount) {
		this.txtdiscount = txtdiscount;
	}
	public String getTxtnettotal() {
		return txtnettotal;
	}
	public void setTxtnettotal(String txtnettotal) {
		this.txtnettotal = txtnettotal;
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
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	public int getTermsgridlength() {
		return termsgridlength;
	}
	public void setTermsgridlength(int termsgridlength) {
		this.termsgridlength = termsgridlength;
	}
	
	private String lbldate,lbltype,lblvendoeacc,lblvendoeaccName, expdeldate,lbldelterms ,lblpaytems, lbldesc1,lblrefno,lblsubtotal,lbltotal,lblordervalue,lblordervaluewords;
	private int lbldoc,firstarray,secarray,thirdarray;
	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname,lblsalesPerson,lbllocation1;




	public int getThirdarray() {
		return thirdarray;
	}
	public void setThirdarray(int thirdarray) {
		this.thirdarray = thirdarray;
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
	public int getLbldoc() {
		return lbldoc;
	}
	public void setLbldoc(int lbldoc) {
		this.lbldoc = lbldoc;
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
	public String getLblsalesPerson() {
		return lblsalesPerson;
	}
	public void setLblsalesPerson(String lblsalesPerson) {
		this.lblsalesPerson = lblsalesPerson;
	}
	public String getLbllocation1() {
		return lbllocation1;
	}
	public void setLbllocation1(String lbllocation1) {
		this.lbllocation1 = lbllocation1;
	}	
	
	
	
	private String lblclientaddress,lblclientcity,lblclientcountry,lblclientmob,lblinvno,lblcompemail;




	public String getLblclientaddress() {
		return lblclientaddress;
	}
	public void setLblclientaddress(String lblclientaddress) {     
		this.lblclientaddress = lblclientaddress;
	}
	public String getLblclientcity() {
		return lblclientcity;
	}
	public void setLblclientcity(String lblclientcity) {
		this.lblclientcity = lblclientcity;
	}
	public String getLblclientcountry() {
		return lblclientcountry;
	}
	public void setLblclientcountry(String lblclientcountry) {
		this.lblclientcountry = lblclientcountry;
	}
	public String getLblclientmob() {
		return lblclientmob;
	}
	public void setLblclientmob(String lblclientmob) {
		this.lblclientmob = lblclientmob;
	}
	public String getLblinvno() {
		return lblinvno;
	}
	public void setLblinvno(String lblinvno) {
		this.lblinvno = lblinvno;
	}
	public String getLblcompemail() {
		return lblcompemail;
	}
	public void setLblcompemail(String lblcompemail) {
		this.lblcompemail = lblcompemail;
	}
	
	
	
	

}
