package com.dashboard.leadmanagement.leadfollowuplog;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsLeadFollowupLogAction extends ActionSupport{

	ClsLeadFollowupLogDAO clientfollowupDAO= new ClsLeadFollowupLogDAO();
	ClsLeadFollowupLogBean clientfollowupBean;
	
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
	public String getLblname() {
		return lblname;
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
		int cldocno=Integer.parseInt(request.getParameter("cldocno"));
		String fromdate=request.getParameter("fromdate");
		String todate=request.getParameter("todate");
		clientfollowupBean=clientfollowupDAO.getPrint(request,cldocno,fromdate,todate);
		setLblcompname(clientfollowupBean.getLblcompname());
		setLblcompaddress(clientfollowupBean.getLblcompaddress());
		setLblprintname(clientfollowupBean.getLblprintname());
		setLblprintname1(clientfollowupBean.getLblprintname1());
		setLblcomptel(clientfollowupBean.getLblcomptel());
		setLblcompfax(clientfollowupBean.getLblcompfax());
		setLblbranch(clientfollowupBean.getLblbranch());
		setLbllocation(clientfollowupBean.getLbllocation());
		setLblname(clientfollowupBean.getLblname());
		setLblacno(clientfollowupBean.getLblacno());
		setLbladdress(clientfollowupBean.getLbladdress());
		setLblmobno(clientfollowupBean.getLblmobno());
		setLblcodeno(clientfollowupBean.getLblcodeno());
		
		setFirstarray(clientfollowupBean.getFirstarray());
	
		
		return "print";
	}
		
}
