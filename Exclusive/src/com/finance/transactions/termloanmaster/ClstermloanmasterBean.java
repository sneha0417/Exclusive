package com.finance.transactions.termloanmaster;
import java.io.IOException;
import java.math.BigDecimal;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
public class ClstermloanmasterBean {

	  private String jqxStartDate,hidjqxStartDate,secchaqueno,nameincheque,txtdescription,uptoDate,hiduptoDate;;
    private int  calcumethod,finaccdocno,banckaccdocno,interestaccdocno,loanaccdocno,paymentmethod,instnos,detval;
    private int Clstatus,masterstatus; 
    
    
   private BigDecimal downpayment,loanamount,chqamount;
   
   
   private String financeaccid,financeaccname,bankaccid,bankaccname,interestaccid,intaccname,loanaccid,loanaccname,masterrefno,dealno;

 
   private double perinterest;
   
   private int  calcuval,paymentval,masterdoc_no; 
   
   
   

	public String getJqxStartDate() {
		return jqxStartDate;
	}

	public void setJqxStartDate(String jqxStartDate) {
		this.jqxStartDate = jqxStartDate;
	}

	public String getHidjqxStartDate() {
		return hidjqxStartDate;
	}

	public void setHidjqxStartDate(String hidjqxStartDate) {
		this.hidjqxStartDate = hidjqxStartDate;
	}

	public String getSecchaqueno() {
		return secchaqueno;
	}

	public void setSecchaqueno(String secchaqueno) {
		this.secchaqueno = secchaqueno;
	}

	public String getNameincheque() {
		return nameincheque;
	}

	public void setNameincheque(String nameincheque) {
		this.nameincheque = nameincheque;
	}

	public String getTxtdescription() {
		return txtdescription;
	}

	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}

	public int getCalcumethod() {
		return calcumethod;
	}

	public void setCalcumethod(int calcumethod) {
		this.calcumethod = calcumethod;
	}

	public int getFinaccdocno() {
		return finaccdocno;
	}

	public void setFinaccdocno(int finaccdocno) {
		this.finaccdocno = finaccdocno;
	}

	public int getBanckaccdocno() {
		return banckaccdocno;
	}

	public void setBanckaccdocno(int banckaccdocno) {
		this.banckaccdocno = banckaccdocno;
	}

	public int getInterestaccdocno() {
		return interestaccdocno;
	}

	public void setInterestaccdocno(int interestaccdocno) {
		this.interestaccdocno = interestaccdocno;
	}

	public int getLoanaccdocno() {
		return loanaccdocno;
	}

	public void setLoanaccdocno(int loanaccdocno) {
		this.loanaccdocno = loanaccdocno;
	}

	public int getPaymentmethod() {
		return paymentmethod;
	}

	public void setPaymentmethod(int paymentmethod) {
		this.paymentmethod = paymentmethod;
	}

	public int getInstnos() {
		return instnos;
	}

	public void setInstnos(int instnos) {
		this.instnos = instnos;
	}

	
	
	

	public String getDealno() {
		return dealno;
	}

	public void setDealno(String dealno) {
		this.dealno = dealno;
	}

	public BigDecimal getDownpayment() {
		return downpayment;
	}

	public void setDownpayment(BigDecimal downpayment) {
		this.downpayment = downpayment;
	}

	public BigDecimal getLoanamount() {
		return loanamount;
	}

	public void setLoanamount(BigDecimal loanamount) {
		this.loanamount = loanamount;
	}

	public BigDecimal getChqamount() {
		return chqamount;
	}

	public void setChqamount(BigDecimal chqamount) {
		this.chqamount = chqamount;
	}

	public String getFinanceaccid() {
		return financeaccid;
	}

	public void setFinanceaccid(String financeaccid) {
		this.financeaccid = financeaccid;
	}

	public String getFinanceaccname() {
		return financeaccname;
	}

	public void setFinanceaccname(String financeaccname) {
		this.financeaccname = financeaccname;
	}

	public String getBankaccid() {
		return bankaccid;
	}

	public void setBankaccid(String bankaccid) {
		this.bankaccid = bankaccid;
	}

	public String getBankaccname() {
		return bankaccname;
	}

	public void setBankaccname(String bankaccname) {
		this.bankaccname = bankaccname;
	}

	public String getInterestaccid() {
		return interestaccid;
	}

	public void setInterestaccid(String interestaccid) {
		this.interestaccid = interestaccid;
	}

	public String getIntaccname() {
		return intaccname;
	}

	public void setIntaccname(String intaccname) {
		this.intaccname = intaccname;
	}

	public String getLoanaccid() {
		return loanaccid;
	}

	public void setLoanaccid(String loanaccid) {
		this.loanaccid = loanaccid;
	}

	public String getLoanaccname() {
		return loanaccname;
	}

	public void setLoanaccname(String loanaccname) {
		this.loanaccname = loanaccname;
	}

	public double getPerinterest() {
		return perinterest;
	}

	public void setPerinterest(double perinterest) {
		this.perinterest = perinterest;
	}

	public int getCalcuval() {
		return calcuval;
	}

	public void setCalcuval(int calcuval) {
		this.calcuval = calcuval;
	}

	public int getPaymentval() {
		return paymentval;
	}



	public void setPaymentval(int paymentval) {
		this.paymentval = paymentval;
	}
   
   
   
	public int getDetval() {
		return detval;
	}

	public void setDetval(int detval) {
		this.detval = detval;
	}

	public int getClstatus() {
		return Clstatus;
	}

	public void setClstatus(int clstatus) {
		Clstatus = clstatus;
	}

	public String getUptoDate() {
		return uptoDate;
	}

	public void setUptoDate(String uptoDate) { 
		this.uptoDate = uptoDate;
	}

	public String getHiduptoDate() {
		return hiduptoDate;
	}

	public void setHiduptoDate(String hiduptoDate) {
		this.hiduptoDate = hiduptoDate;
	}


	public int getMasterstatus() {
		return masterstatus;
	}

	public void setMasterstatus(int masterstatus) {
		this.masterstatus = masterstatus;
	}

	public String getMasterrefno() {
		return masterrefno;
	}

	public void setMasterrefno(String masterrefno) {
		this.masterrefno = masterrefno;
	}

	public int getMasterdoc_no() {
		return masterdoc_no;
	}

	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
   
	private String lbldate,lbltype,lbldesc1,expdeldate,lblvendoeacc,lblvendoeaccName,lbltotal,lblpurchaseDate,lblinvno;
	
	private int lbldoc,firstarray,rowdatascount;
	
	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname;

  private String lbldownpayment,lblloanamt,lblstartdate,lblperinterst,lblcalcumethod,lblnoofinst,lblfinacc,lblfinaccName,lblbankacc,lblbankaccName;
  private String lblintacc,lblintaccName,lblloanacc,lblloanaccName,lblsecucqNo,lblanamt,lbluptodate,lblpayval,lblnameinchq,lblDesc,amountinwords;
	//-------------------------------------

  public int getRowdatascount() {
		return rowdatascount;
	}

	public void setRowdatascount(int rowdatascount) {
		this.rowdatascount = rowdatascount;
	}
	public String getLbldate() {
		return lbldate;
	}

	

	public String getAmountinwords() {
		return amountinwords;
	}

	public void setAmountinwords(String amountinwords) {
		this.amountinwords = amountinwords;
	}

	public int getFirstarray() {
		return firstarray;
	}

	public void setFirstarray(int firstarray) {
		this.firstarray = firstarray;
	}

	public String getLbldownpayment() {
		return lbldownpayment;
	}

	public void setLbldownpayment(String lbldownpayment) {
		this.lbldownpayment = lbldownpayment;
	}

	public String getLblloanamt() {
		return lblloanamt;
	}

	public void setLblloanamt(String lblloanamt) {
		this.lblloanamt = lblloanamt;
	}

	public String getLblstartdate() {
		return lblstartdate;
	}

	public void setLblstartdate(String lblstartdate) {
		this.lblstartdate = lblstartdate;
	}

	public String getLblperinterst() {
		return lblperinterst;
	}

	public void setLblperinterst(String lblperinterst) {
		this.lblperinterst = lblperinterst;
	}

	public String getLblcalcumethod() {
		return lblcalcumethod;
	}

	public void setLblcalcumethod(String lblcalcumethod) {
		this.lblcalcumethod = lblcalcumethod;
	}

	public String getLblnoofinst() {
		return lblnoofinst;
	}

	public void setLblnoofinst(String lblnoofinst) {
		this.lblnoofinst = lblnoofinst;
	}

	public String getLblfinacc() {
		return lblfinacc;
	}

	public void setLblfinacc(String lblfinacc) {
		this.lblfinacc = lblfinacc;
	}

	public String getLblfinaccName() {
		return lblfinaccName;
	}

	public void setLblfinaccName(String lblfinaccName) { 
		this.lblfinaccName = lblfinaccName;
	}

	public String getLblbankacc() {
		return lblbankacc;
	}

	public void setLblbankacc(String lblbankacc) { 
		this.lblbankacc = lblbankacc;
	}

	public String getLblbankaccName() {
		return lblbankaccName;
	}

	public void setLblbankaccName(String lblbankaccName) {
		this.lblbankaccName = lblbankaccName;
	}

	public String getLblintacc() {
		return lblintacc;
	}

	public void setLblintacc(String lblintacc) {
		this.lblintacc = lblintacc;
	}

	public String getLblintaccName() {
		return lblintaccName;
	}

	public void setLblintaccName(String lblintaccName) {
		this.lblintaccName = lblintaccName;
	}

	public String getLblloanacc() {
		return lblloanacc;
	}

	public void setLblloanacc(String lblloanacc) {
		this.lblloanacc = lblloanacc;
	}

	public String getLblloanaccName() {
		return lblloanaccName;
	}

	public void setLblloanaccName(String lblloanaccName) {
		this.lblloanaccName = lblloanaccName;
	}

	public String getLblsecucqNo() {
		return lblsecucqNo;
	}

	public void setLblsecucqNo(String lblsecucqNo) {
		this.lblsecucqNo = lblsecucqNo;
	}

	public String getLblanamt() {
		return lblanamt;
	}

	public void setLblanamt(String lblanamt) {
		this.lblanamt = lblanamt;
	}

	public String getLbluptodate() {
		return lbluptodate;
	}

	public void setLbluptodate(String lbluptodate) {
		this.lbluptodate = lbluptodate;
	}

	public String getLblpayval() {
		return lblpayval;
	}

	public void setLblpayval(String lblpayval) {
		this.lblpayval = lblpayval;
	}

	public String getLblnameinchq() {
		return lblnameinchq;
	}

	public void setLblnameinchq(String lblnameinchq) {
		this.lblnameinchq = lblnameinchq;
	}

	public String getLblDesc() {
		return lblDesc;
	}

	public void setLblDesc(String lblDesc) {
		this.lblDesc = lblDesc;
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

	public String getLbldesc1() {
		return lbldesc1;
	}

	public void setLbldesc1(String lbldesc1) {
		this.lbldesc1 = lbldesc1;
	}

	public String getExpdeldate() {
		return expdeldate;
	}

	public void setExpdeldate(String expdeldate) {
		this.expdeldate = expdeldate;
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

	public String getLbltotal() {
		return lbltotal;
	}

	public void setLbltotal(String lbltotal) {
		this.lbltotal = lbltotal;
	}

	public String getLblpurchaseDate() {
		return lblpurchaseDate;
	}

	public void setLblpurchaseDate(String lblpurchaseDate) {
		this.lblpurchaseDate = lblpurchaseDate;
	}

	public String getLblinvno() {
		return lblinvno;
	}

	public void setLblinvno(String lblinvno) {
		this.lblinvno = lblinvno;
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
	
	private String lblpricitotalamount,lblinttotalamount,lbltotalgridamount,lbltotalint;




	public String getLblpricitotalamount() {
		return lblpricitotalamount;
	}

	public void setLblpricitotalamount(String lblpricitotalamount) {   
		this.lblpricitotalamount = lblpricitotalamount;
	}

	public String getLblinttotalamount() {
		return lblinttotalamount;
	}

	public void setLblinttotalamount(String lblinttotalamount) {
		this.lblinttotalamount = lblinttotalamount;
	}

	public String getLbltotalgridamount() {
		return lbltotalgridamount;
	}

	public void setLbltotalgridamount(String lbltotalgridamount) {
		this.lbltotalgridamount = lbltotalgridamount;
	}

	public String getLbltotalint() {
		return lbltotalint;
	}

	public void setLbltotalint(String lbltotalint) {
		this.lbltotalint = lbltotalint;
	}
	
	
	private String restructure;




	public String getRestructure() {
		return restructure;
	}

	public void setRestructure(String restructure) {
		this.restructure = restructure;
	}
	
	
}
