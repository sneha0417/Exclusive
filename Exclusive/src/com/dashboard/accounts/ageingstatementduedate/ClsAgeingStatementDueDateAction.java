package com.dashboard.accounts.ageingstatementduedate;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
@SuppressWarnings("serial")

public class ClsAgeingStatementDueDateAction extends ActionSupport{
    
	ClsAgeingStatementDueDateDAO accountStatementDAO= new ClsAgeingStatementDueDateDAO();
	ClsAgeingStatementDueDateBean ageingStatementDueDateBean;
	
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
	private String lblaccountname;
	private String lblaccountaddress;
	private String lblaccountmobileno;
	private String lblcurrencycode;
	
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
	private int thirdarray;
		
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

	public String getLblaccountmobileno() {
		return lblaccountmobileno;
	}

	public void setLblaccountmobileno(String lblaccountmobileno) {
		this.lblaccountmobileno = lblaccountmobileno;
	}

	public String getLblcurrencycode() {
		return lblcurrencycode;
	}

	public void setLblcurrencycode(String lblcurrencycode) {
		this.lblcurrencycode = lblcurrencycode;
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

	public String saveAction() throws ParseException, SQLException{
		return lblaccountname;
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

	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		String atype = request.getParameter("atype");
		int acno=Integer.parseInt(request.getParameter("acno"));
		int level1from=Integer.parseInt(request.getParameter("level1from"));
		int level1to=Integer.parseInt(request.getParameter("level1to"));
		int level2from=Integer.parseInt(request.getParameter("level2from"));
		int level2to=Integer.parseInt(request.getParameter("level2to"));
		int level3from=Integer.parseInt(request.getParameter("level3from"));
		int level3to=Integer.parseInt(request.getParameter("level3to"));
		int level4from=Integer.parseInt(request.getParameter("level4from"));
		int level4to=Integer.parseInt(request.getParameter("level4to"));
		int level5from=Integer.parseInt(request.getParameter("level5from"));
		String branch = request.getParameter("branch");
		String uptoDate = request.getParameter("uptoDate");
		ageingStatementDueDateBean=accountStatementDAO.getPrint(request,atype,acno,branch,uptoDate,level1from,level1to,level2from,level2to,level3from,level3to,level4from,level4to,level5from);
		setLblcompname(ageingStatementDueDateBean.getLblcompname());
		setLblcompaddress(ageingStatementDueDateBean.getLblcompaddress());
		setLblprintname(ageingStatementDueDateBean.getLblprintname());
		setLblprintname1(ageingStatementDueDateBean.getLblprintname1());
		setLblcomptel(ageingStatementDueDateBean.getLblcomptel());
		setLblcompfax(ageingStatementDueDateBean.getLblcompfax());
		setLblbranch(ageingStatementDueDateBean.getLblbranch());
		setLbllocation(ageingStatementDueDateBean.getLbllocation());
		setLblservicetax(ageingStatementDueDateBean.getLblservicetax());
		setLblpan(ageingStatementDueDateBean.getLblpan());
		setLblcstno(ageingStatementDueDateBean.getLblcstno());
		setLblaccountname(ageingStatementDueDateBean.getLblaccountname());
		setLblaccountaddress(ageingStatementDueDateBean.getLblaccountaddress());
		setLblaccountmobileno(ageingStatementDueDateBean.getLblaccountmobileno());
		setLblcurrencycode(ageingStatementDueDateBean.getLblcurrencycode());

		setLblsumnetamount(ageingStatementDueDateBean.getLblsumnetamount());
		setLblsumapplied(ageingStatementDueDateBean.getLblsumapplied());
		setLblsumbalance(ageingStatementDueDateBean.getLblsumbalance());
		
		setLblsumoutnetamount(ageingStatementDueDateBean.getLblsumoutnetamount());
		setLblsumoutapplied(ageingStatementDueDateBean.getLblsumoutapplied());
		setLblsumoutbalance(ageingStatementDueDateBean.getLblsumoutbalance());
		
		setLblnetamount(ageingStatementDueDateBean.getLblnetamount());
		
		// for hide
		setFirstarray(ageingStatementDueDateBean.getFirstarray());
		setSecarray(ageingStatementDueDateBean.getSecarray());
		setThirdarray(ageingStatementDueDateBean.getThirdarray());
		
		return "print";
	}
}