package com.dashboard.accounts.ageingstatementreport;

public class ClsAgeingStatementReportBean {
	
	//Print
	private String lblcompname;
	private String lblcompaddress;
	private String lblprintname;
	private String lblprintname1;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private String lblservicetax;
	private String lblpan;
	private String lblcstno;
	private String lblaccountno;
	private String lblaccountname;
	private String lblaccountaddress;
	private String lblaccountemail;
	private String lblaccountmobileno;
	private String lblaccountphone;
	private String lblaccountfax;
	private String lblcreditperiodmin;
	private String lblcreditperiodmax;
	private String lblcreditlimit;
	
	private String lblsumnetamount;
	private String lblsumapplied;
	private String lblsumbalance;
	
	private String lblsumoutnetamount;
	private String lblsumoutapplied;
	private String lblsumoutbalance;
	
	private String lblnetamount;
	
	//for hide
	private int firstarray;
	private int secarray;
	private String refname,address,per_mob,aed_amount,cur_date,fax,email;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getAed_amount() {
		return aed_amount;
	}
	public void setAed_amount(String aed_amount) {
		this.aed_amount = aed_amount;
	}
	public String getCur_date() {
		return cur_date;
	}
	public void setCur_date(String cur_date) {
		this.cur_date = cur_date;
	}
	public String getRefname() {
		return refname;
	}
	public void setRefname(String refname) {
		this.refname = refname;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPer_mob() {
		return per_mob;
	}
	public void setPer_mob(String per_mob) {
		this.per_mob = per_mob;
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
	public String getLblprintname1() {
		return lblprintname1;
	}
	public void setLblprintname1(String lblprintname1) {
		this.lblprintname1 = lblprintname1;
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
	public String getLblservicetax() {
		return lblservicetax;
	}
	public void setLblservicetax(String lblservicetax) {
		this.lblservicetax = lblservicetax;
	}
	public String getLblpan() {
		return lblpan;
	}
	public void setLblpan(String lblpan) {
		this.lblpan = lblpan;
	}
	public String getLblcstno() {
		return lblcstno;
	}
	public void setLblcstno(String lblcstno) {
		this.lblcstno = lblcstno;
	}
	public String getLblaccountno() {
		return lblaccountno;
	}
	public void setLblaccountno(String lblaccountno) {
		this.lblaccountno = lblaccountno;
	}
	public String getLblaccountname() {
		return lblaccountname;
	}
	public void setLblaccountname(String lblaccountname) {
		this.lblaccountname = lblaccountname;
	}
	public String getLblaccountaddress() {
		return lblaccountaddress;
	}
	public void setLblaccountaddress(String lblaccountaddress) {
		this.lblaccountaddress = lblaccountaddress;
	}
	public String getLblaccountemail() {
		return lblaccountemail;
	}
	public void setLblaccountemail(String lblaccountemail) {
		this.lblaccountemail = lblaccountemail;
	}
	public String getLblaccountmobileno() {
		return lblaccountmobileno;
	}
	public void setLblaccountmobileno(String lblaccountmobileno) {
		this.lblaccountmobileno = lblaccountmobileno;
	}
	public String getLblaccountphone() {
		return lblaccountphone;
	}
	public void setLblaccountphone(String lblaccountphone) {
		this.lblaccountphone = lblaccountphone;
	}
	public String getLblaccountfax() {
		return lblaccountfax;
	}
	public void setLblaccountfax(String lblaccountfax) {
		this.lblaccountfax = lblaccountfax;
	}
	public String getLblcreditperiodmin() {
		return lblcreditperiodmin;
	}
	public void setLblcreditperiodmin(String lblcreditperiodmin) {
		this.lblcreditperiodmin = lblcreditperiodmin;
	}
	public String getLblcreditperiodmax() {
		return lblcreditperiodmax;
	}
	public void setLblcreditperiodmax(String lblcreditperiodmax) {
		this.lblcreditperiodmax = lblcreditperiodmax;
	}
	public String getLblcreditlimit() {
		return lblcreditlimit;
	}
	public void setLblcreditlimit(String lblcreditlimit) {
		this.lblcreditlimit = lblcreditlimit;
	}
	public String getLblsumnetamount() {
		return lblsumnetamount;
	}
	public void setLblsumnetamount(String lblsumnetamount) {
		this.lblsumnetamount = lblsumnetamount;
	}
	public String getLblsumapplied() {
		return lblsumapplied;
	}
	public void setLblsumapplied(String lblsumapplied) {
		this.lblsumapplied = lblsumapplied;
	}
	public String getLblsumbalance() {
		return lblsumbalance;
	}
	public void setLblsumbalance(String lblsumbalance) {
		this.lblsumbalance = lblsumbalance;
	}
	public String getLblsumoutnetamount() {
		return lblsumoutnetamount;
	}
	public void setLblsumoutnetamount(String lblsumoutnetamount) {
		this.lblsumoutnetamount = lblsumoutnetamount;
	}
	public String getLblsumoutapplied() {
		return lblsumoutapplied;
	}
	public void setLblsumoutapplied(String lblsumoutapplied) {
		this.lblsumoutapplied = lblsumoutapplied;
	}
	public String getLblsumoutbalance() {
		return lblsumoutbalance;
	}
	public void setLblsumoutbalance(String lblsumoutbalance) {
		this.lblsumoutbalance = lblsumoutbalance;
	}
	public String getLblnetamount() {
		return lblnetamount;
	}
	public void setLblnetamount(String lblnetamount) {
		this.lblnetamount = lblnetamount;
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
	
}