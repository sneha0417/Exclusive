package com.dashboard.marketing.enquiryScheduler;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsenquirySchedulerAction extends ActionSupport{

	ClsenquirySchedulerDAO clsenquirySchedulerDAO= new ClsenquirySchedulerDAO();
	ClsenquirySchedulerBean clsenquirySchedulerBean;
	
	//Print
	private String lblcompname;
	private String lblcompaddress;
	private String lblprintname;
	private String lblprintname1;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	
	private String lblname;
	
	private String lbldocno;
	private String lbldate;
	private String lblcusname;
	private String lbladdrs;
	private String lblconper;
	private String lblcontr;
	private String lblsurveyed;
	private String lbllocn;
	private String lblservice;
	private String lblremarks;
	private String lblconnum;
	
	private int secondarray;
	private int thirdarray;

	
	
	
	

	public int getSecondarray() {
		return secondarray;
	}

	public void setSecondarray(int secondarray) {
		this.secondarray = secondarray;
	}

	public int getThirdarray() {
		return thirdarray;
	}

	public void setThirdarray(int thirdarray) {
		this.thirdarray = thirdarray;
	}

	public String getLblconnum() {
		return lblconnum;
	}

	public void setLblconnum(String lblconnum) {
		this.lblconnum = lblconnum;
	}

	public String getLbldocno() {
		return lbldocno;
	}

	public void setLbldocno(String lbldocno) {
		this.lbldocno = lbldocno;
	}

	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}

	

	public String getLblcusname() {
		return lblcusname;
	}

	public void setLblcusname(String lblcusname) {
		this.lblcusname = lblcusname;
	}

	public String getLbladdrs() {
		return lbladdrs;
	}

	public void setLbladdrs(String lbladdrs) {
		this.lbladdrs = lbladdrs;
	}

	public String getLblconper() {
		return lblconper;
	}

	public void setLblconper(String lblconper) {
		this.lblconper = lblconper;
	}

	public String getLblcontr() {
		return lblcontr;
	}

	public void setLblcontr(String lblcontr) {
		this.lblcontr = lblcontr;
	}

	public String getLblsurveyed() {
		return lblsurveyed;
	}

	public void setLblsurveyed(String lblsurveyed) {
		this.lblsurveyed = lblsurveyed;
	}

	public String getLbllocn() {
		return lbllocn;
	}

	public void setLbllocn(String lbllocn) {
		this.lbllocn = lbllocn;
	}

	public String getLblservice() {
		return lblservice;
	}

	public void setLblservice(String lblservice) {
		this.lblservice = lblservice;
	}

	public String getLblremarks() {
		return lblremarks;
	}

	public void setLblremarks(String lblremarks) {
		this.lblremarks = lblremarks;
	}

	public String getLblname() {
		return lblname;
	}

	public void setLblname(String lblname) {
		this.lblname = lblname;
	}


	

	public int getFirstarray() {
		return firstarray;
	}

	public void setFirstarray(int firstarray) {
		this.firstarray = firstarray;
	}


	
	
	//for hide
	private int firstarray;
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


	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		int docno=Integer.parseInt(request.getParameter("docno"));
		String branch=request.getParameter("branch");
		System.out.println(docno);
		clsenquirySchedulerBean=clsenquirySchedulerDAO.getPrint(request,docno);
		setLbldocno(clsenquirySchedulerBean.getLbldocno());
		setLbldate(clsenquirySchedulerBean.getLbldate());
		setLbladdrs(clsenquirySchedulerBean.getLbladdrs());
		setLblcusname(clsenquirySchedulerBean.getLblcusname());
		setLblconper(clsenquirySchedulerBean.getLblconper());
		setLblservice(clsenquirySchedulerBean.getLblservice());
		setLblconnum(clsenquirySchedulerBean.getLblconnum());
		setLblcompname(clsenquirySchedulerBean.getLblcompname());
		setLblcompaddress(clsenquirySchedulerBean.getLblcompaddress());
		setLbllocn(clsenquirySchedulerBean.getLbllocn());
		setLblprintname(clsenquirySchedulerBean.getLblprintname());
		setLblprintname1(clsenquirySchedulerBean.getLblprintname1());
		setLblcomptel(clsenquirySchedulerBean.getLblcomptel());
		setLblcompfax(clsenquirySchedulerBean.getLblcompfax());
		setLblbranch(clsenquirySchedulerBean.getLblbranch());
		setLbllocation(clsenquirySchedulerBean.getLbllocation());
		setLblname(clsenquirySchedulerBean.getLblname());
		setLblremarks(clsenquirySchedulerBean.getLblremarks());
		
	
		setFirstarray(clsenquirySchedulerBean.getFirstarray());
	
		
		return "print";
	}
		
}
