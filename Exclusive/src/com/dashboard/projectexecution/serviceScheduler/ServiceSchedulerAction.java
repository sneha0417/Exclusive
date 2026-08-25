package com.dashboard.projectexecution.serviceScheduler;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ServiceSchedulerAction extends ActionSupport{

	ServiceSchedulerDAO serviceschedulerDAO= new ServiceSchedulerDAO();
	ServiceSchedulerBean serviceschedulerBean;
	
	//Print
	private String lblcompname;
	private String lblcompaddress;
	private String lblprintname;
	private String lblprintname1;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private String lblclname;
	private String lblname,lblsite,lblcntprsn,lblcontact,lblamc,lbldocnno,lbljobdat;;
	private String lblstype;
	private String lblschno;
	private String lblassngrp;
	private String lblclientlpo;
	private String description;
	private String paydescription;
	
	public String getLblschno() {
		return lblschno;
	}

	public void setLblschno(String lblschno) {
		this.lblschno = lblschno;
	}

	public String getLblassngrp() {
		return lblassngrp;
	}

	public void setLblassngrp(String lblassngrp) {
		this.lblassngrp = lblassngrp;
	}

	public String getLblclientlpo() {
		return lblclientlpo;
	}

	public void setLblclientlpo(String lblclientlpo) {
		this.lblclientlpo = lblclientlpo;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPaydescription() {
		return paydescription;
	}

	public void setPaydescription(String paydescription) {
		this.paydescription = paydescription;
	}

	public String getLblstype() {
		return lblstype;
	}

	public void setLblstype(String lblstype) {
		this.lblstype = lblstype;
	}

	public String getLblamc() {
		return lblamc;
	}

	public void setLblamc(String lblamc) {
		this.lblamc = lblamc;
	}

	public String getLbldocnno() {
		return lbldocnno;
	}

	public void setLbldocnno(String lbldocnno) {
		this.lbldocnno = lbldocnno;
	}

	public String getLbljobdat() {
		return lbljobdat;
	}

	public void setLbljobdat(String lbljobdat) {
		this.lbljobdat = lbljobdat;
	}

	public String getLblcntprsn() {
		return lblcntprsn;
	}

	public void setLblcntprsn(String lblcntprsn) {
		this.lblcntprsn = lblcntprsn;
	}

	public String getLblcontact() {
		return lblcontact;
	}

	public void setLblcontact(String lblcontact) {
		this.lblcontact = lblcontact;
	}

	public String getLblsite() {
		return lblsite;
	}

	public void setLblsite(String lblsite) {
		this.lblsite = lblsite;
	}

	public String getLblname() {
		return lblname;
	}

	public String getLblclname() {
		return lblclname;
	}

	public void setLblclname(String lblclname) {
		this.lblclname = lblclname;
	}

	public void setLblname(String lblname) {
		this.lblname = lblname;
	}

	public String getLblacno() {
		return lblacno;
	}

	public void setLblacno(String lblacno) {
		this.lblacno = lblacno;
	}

	public String getLbladdress() {
		return lbladdress;
	}

	public void setLbladdress(String lbladdress) {
		this.lbladdress = lbladdress;
	}

	public String getLblmobno() {
		return lblmobno;
	}

	public void setLblmobno(String lblmobno) {
		this.lblmobno = lblmobno;
	}

	public String getLblcodeno() {
		return lblcodeno;
	}

	public void setLblcodeno(String lblcodeno) {
		this.lblcodeno = lblcodeno;
	}

	public int getFirstarray() {
		return firstarray;
	}

	public void setFirstarray(int firstarray) {
		this.firstarray = firstarray;
	}


	private String lblacno;
	private String lbladdress;
	private String lblmobno;
	private String lblcodeno;
	
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
		String dtype=request.getParameter("dtype");
		String srno=request.getParameter("srno");
		String branch=request.getParameter("branch");
		//System.out.println(branch);
		
		serviceschedulerBean=serviceschedulerDAO.getPrint(request,docno,dtype,srno,branch);
		
		setLblclname(serviceschedulerBean.getLblclname());
		setLblsite(serviceschedulerBean.getLblsite());
		setLblcompname(serviceschedulerBean.getLblcompname());
		setLblcompaddress(serviceschedulerBean.getLblcompaddress());
		setLblcomptel(serviceschedulerBean.getLblcomptel());
		setLblcompfax(serviceschedulerBean.getLblcompfax());
		setLblbranch(serviceschedulerBean.getLblbranch());
		setLbllocation(serviceschedulerBean.getLbllocation());
		setLblprintname("JOB SHEET");
		setFirstarray(serviceschedulerBean.getFirstarray());
		setLblcntprsn(serviceschedulerBean.getLblcntprsn());
		setLblcontact(serviceschedulerBean.getLblcontact());
		setLblamc(serviceschedulerBean.getLblamc());
		setLbldocnno(serviceschedulerBean.getLbldocnno());
		setLbljobdat(serviceschedulerBean.getLbljobdat());
		setLblstype(serviceschedulerBean.getLblstype());
		/*setLblcompaddress(serviceschedulerBean.getLblcompaddress());
		setLblprintname(serviceschedulerBean.getLblprintname());
		setLblprintname1(serviceschedulerBean.getLblprintname1());
		setLblcomptel(serviceschedulerBean.getLblcomptel());
		setLblcompfax(serviceschedulerBean.getLblcompfax());
		setLblbranch(serviceschedulerBean.getLblbranch());
		setLbllocation(serviceschedulerBean.getLbllocation());
		setLblname(serviceschedulerBean.getLblname());
		setLblacno(serviceschedulerBean.getLblacno());
		setLbladdress(serviceschedulerBean.getLbladdress());
		setLblmobno(serviceschedulerBean.getLblmobno());
		setLblcodeno(serviceschedulerBean.getLblcodeno());
		
		setFirstarray(serviceschedulerBean.getFirstarray());
	*/
		
		return "print";
	}
	
	public String printAction1() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
	
		int docno=Integer.parseInt(request.getParameter("docno"));
		String dtype=request.getParameter("dtype");
		String srno=request.getParameter("srno");
		String branch=request.getParameter("branch");
		//System.out.println(branch);
		
		serviceschedulerBean=serviceschedulerDAO.getPrint(request,docno,dtype,srno,branch);
		
		setLblclname(serviceschedulerBean.getLblclname());
		setLblsite(serviceschedulerBean.getLblsite());
		setLblcompname(serviceschedulerBean.getLblcompname());
		setLblcompaddress(serviceschedulerBean.getLblcompaddress());
		setLblcomptel(serviceschedulerBean.getLblcomptel());
		setLblcompfax(serviceschedulerBean.getLblcompfax());
		setLblbranch(serviceschedulerBean.getLblbranch());
		setLbllocation(serviceschedulerBean.getLbllocation());
		setLblprintname("JOB SHEET");
		setFirstarray(serviceschedulerBean.getFirstarray());
		setLblcntprsn(serviceschedulerBean.getLblcntprsn());
		setLblcontact(serviceschedulerBean.getLblcontact());
		setLblamc(serviceschedulerBean.getLblamc());
		setLbldocnno(serviceschedulerBean.getLbldocnno());
		setLbljobdat(serviceschedulerBean.getLbljobdat());
		setLblstype(serviceschedulerBean.getLblstype());
		setLblassngrp(serviceschedulerBean.getLblassngrp());
		setLblclientlpo(serviceschedulerBean.getLblclientlpo());
		setDescription(serviceschedulerBean.getDescription());
		setPaydescription(serviceschedulerBean.getPaydescription());
		setLblschno(serviceschedulerBean.getLblschno());
		/*setLblcompaddress(serviceschedulerBean.getLblcompaddress());
		setLblprintname(serviceschedulerBean.getLblprintname());
		setLblprintname1(serviceschedulerBean.getLblprintname1());
		setLblcomptel(serviceschedulerBean.getLblcomptel());
		setLblcompfax(serviceschedulerBean.getLblcompfax());
		setLblbranch(serviceschedulerBean.getLblbranch());
		setLbllocation(serviceschedulerBean.getLbllocation());
		setLblname(serviceschedulerBean.getLblname());
		setLblacno(serviceschedulerBean.getLblacno());
		setLbladdress(serviceschedulerBean.getLbladdress());
		setLblmobno(serviceschedulerBean.getLblmobno());
		setLblcodeno(serviceschedulerBean.getLblcodeno());
		
		setFirstarray(serviceschedulerBean.getFirstarray());
	*/
		
		return "print";
	}
		
	
}
