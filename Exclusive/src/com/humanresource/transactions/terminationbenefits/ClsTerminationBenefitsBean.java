package com.humanresource.transactions.terminationbenefits;

public class ClsTerminationBenefitsBean {
	
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	
	private String terminationBenefitsPostingDate;
	private String hidterminationBenefitsPostingDate;
	private int txtjvno;
	private double txtterminalbenefitstotal;
	private double txtleavesalarytotal;
	private double txttravelstotal;
	private double txtdrtotal;
	private double txtcrtotal;
	private int txttrno;
	
	//Terminal Benefits Details Grid 
	private int gridlength;
	
	//Account Details Grid
	private int journalgridlength;
	
	private String url;
	
	//Print
	private String lblcompname;
	private String lblcompaddress;
	private String lblpobox;
	private String lblprintname;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private String lblservicetax;
	private String lblpan;
	private String lblcstno;
	
	private String lblvoucherno;
	private String lbldate;
	private String lblterminalbenefits;
	private String lblleavesalary;
	private String lbltravel;
	private String lblnetamount;
	private String lblnetamountwords;
	private String lbldebittotal;
	private String lblcredittotal;
	private String lbldepreciationtotal;
	private String lblpreparedby;
	private String lblpreparedon;
	private String lblpreparedat;

	//for hide
	private int firstarray;
	private int secarray;
	private int txtheader;
	
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
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
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getTerminationBenefitsPostingDate() {
		return terminationBenefitsPostingDate;
	}
	public void setTerminationBenefitsPostingDate(
			String terminationBenefitsPostingDate) {
		this.terminationBenefitsPostingDate = terminationBenefitsPostingDate;
	}
	public String getHidterminationBenefitsPostingDate() {
		return hidterminationBenefitsPostingDate;
	}
	public void setHidterminationBenefitsPostingDate(
			String hidterminationBenefitsPostingDate) {
		this.hidterminationBenefitsPostingDate = hidterminationBenefitsPostingDate;
	}
	public int getTxtjvno() {
		return txtjvno;
	}
	public void setTxtjvno(int txtjvno) {
		this.txtjvno = txtjvno;
	}
	public double getTxtterminalbenefitstotal() {
		return txtterminalbenefitstotal;
	}
	public void setTxtterminalbenefitstotal(double txtterminalbenefitstotal) {
		this.txtterminalbenefitstotal = txtterminalbenefitstotal;
	}
	public double getTxtleavesalarytotal() {
		return txtleavesalarytotal;
	}
	public void setTxtleavesalarytotal(double txtleavesalarytotal) {
		this.txtleavesalarytotal = txtleavesalarytotal;
	}
	public double getTxttravelstotal() {
		return txttravelstotal;
	}
	public void setTxttravelstotal(double txttravelstotal) {
		this.txttravelstotal = txttravelstotal;
	}
	public double getTxtdrtotal() {
		return txtdrtotal;
	}
	public void setTxtdrtotal(double txtdrtotal) {
		this.txtdrtotal = txtdrtotal;
	}
	public double getTxtcrtotal() {
		return txtcrtotal;
	}
	public void setTxtcrtotal(double txtcrtotal) {
		this.txtcrtotal = txtcrtotal;
	}
	public int getTxttrno() {
		return txttrno;
	}
	public void setTxttrno(int txttrno) {
		this.txttrno = txttrno;
	}
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	public int getJournalgridlength() {
		return journalgridlength;
	}
	public void setJournalgridlength(int journalgridlength) {
		this.journalgridlength = journalgridlength;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
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
	public String getLblpobox() {
		return lblpobox;
	}
	public void setLblpobox(String lblpobox) {
		this.lblpobox = lblpobox;
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
	public String getLblvoucherno() {
		return lblvoucherno;
	}
	public void setLblvoucherno(String lblvoucherno) {
		this.lblvoucherno = lblvoucherno;
	}
	public String getLbldate() {
		return lbldate;
	}
	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}
	public String getLblterminalbenefits() {
		return lblterminalbenefits;
	}
	public void setLblterminalbenefits(String lblterminalbenefits) {
		this.lblterminalbenefits = lblterminalbenefits;
	}
	public String getLblleavesalary() {
		return lblleavesalary;
	}
	public void setLblleavesalary(String lblleavesalary) {
		this.lblleavesalary = lblleavesalary;
	}
	public String getLbltravel() {
		return lbltravel;
	}
	public void setLbltravel(String lbltravel) {
		this.lbltravel = lbltravel;
	}
	public String getLblnetamount() {
		return lblnetamount;
	}
	public void setLblnetamount(String lblnetamount) {
		this.lblnetamount = lblnetamount;
	}
	public String getLblnetamountwords() {
		return lblnetamountwords;
	}
	public void setLblnetamountwords(String lblnetamountwords) {
		this.lblnetamountwords = lblnetamountwords;
	}
	public String getLbldebittotal() {
		return lbldebittotal;
	}
	public void setLbldebittotal(String lbldebittotal) {
		this.lbldebittotal = lbldebittotal;
	}
	public String getLblcredittotal() {
		return lblcredittotal;
	}
	public void setLblcredittotal(String lblcredittotal) {
		this.lblcredittotal = lblcredittotal;
	}
	public String getLbldepreciationtotal() {
		return lbldepreciationtotal;
	}
	public void setLbldepreciationtotal(String lbldepreciationtotal) {
		this.lbldepreciationtotal = lbldepreciationtotal;
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
	public int getTxtheader() {
		return txtheader;
	}
	public void setTxtheader(int txtheader) {
		this.txtheader = txtheader;
	}

}
