package com.dashboard.salik;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;
@SuppressWarnings("serial")

public class ClsSalikAction extends ActionSupport{
	
	ClsCommon ClsCommon=new ClsCommon();

    
	ClsSalikDAO salikDAO= new ClsSalikDAO();
	ClsSalikBean salikBean;
	
	//Print
	private String lblcompname;
	private String lblcompaddress;
	private String lblprintname;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private String msg;
	private String mode;
	private String cmbbranch;
	private String fromdate;
	private String todate;
	private String txtcldocno;
	private String rentaltype;
	private String txtagreementno;
	private String detail;
	private String detailname;
	
	
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

	public String getCmbbranch() {
		return cmbbranch;
	}

	public void setCmbbranch(String cmbbranch) {
		this.cmbbranch = cmbbranch;
	}

	public String getFromdate() {
		return fromdate;
	}

	public void setFromdate(String fromdate) {
		this.fromdate = fromdate;
	}

	public String getTodate() {
		return todate;
	}

	public void setTodate(String todate) {
		this.todate = todate;
	}

	public String getTxtcldocno() {
		return txtcldocno;
	}

	public void setTxtcldocno(String txtcldocno) {
		this.txtcldocno = txtcldocno;
	}

	public String getRentaltype() {
		return rentaltype;
	}

	public void setRentaltype(String rentaltype) {
		this.rentaltype = rentaltype;
	}

	public String getTxtagreementno() {
		return txtagreementno;
	}

	public void setTxtagreementno(String txtagreementno) {
		this.txtagreementno = txtagreementno;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getDetailname() {
		return detailname;
	}

	public void setDetailname(String detailname) {
		this.detailname = detailname;
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

	
	public String printTobeInvoicedAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		String branch = request.getParameter("branch").toString();
		String fromDate = request.getParameter("fromDate").toString();
		String toDate = request.getParameter("toDate").toString();
		String agmtno=request.getParameter("agmtno")==null || request.getParameter("agmtno").trim().equalsIgnoreCase("")?"0":request.getParameter("agmtno").toString();
		String rentaltype=request.getParameter("rentaltype")==null || request.getParameter("rentaltype").trim().equalsIgnoreCase("")?"0":request.getParameter("rentaltype").toString();
		String cldocno=request.getParameter("cldocno")==null || request.getParameter("cldocno").trim().equalsIgnoreCase("")?"0":request.getParameter("cldocno").toString();
		salikBean=salikDAO.getPrintToBeInvoiced(request,branch,fromDate,toDate,agmtno,rentaltype,cldocno);
	//	System.out.println("After Print Grid Action ");
		setLblcompname(salikBean.getLblcompname());
		setLblcompaddress(salikBean.getLblcompaddress());
		setLblprintname("Salik - To be Invoiced");
		setLblcomptel(salikBean.getLblcomptel());
		setLblcompfax(salikBean.getLblcompfax());
		setLblbranch(salikBean.getLblbranch());
		setLbllocation(salikBean.getLbllocation());
		
		return "print";
	}
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		String branch = request.getParameter("branch");
		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		salikBean=salikDAO.getPrint(request,branch,fromDate,toDate);
		setLblcompname(salikBean.getLblcompname());
		setLblcompaddress(salikBean.getLblcompaddress());
		setLblprintname("Salik - Invoiced");
		setLblcomptel(salikBean.getLblcomptel());
		setLblcompfax(salikBean.getLblcompfax());
		setLblbranch(salikBean.getLblbranch());
		setLbllocation(salikBean.getLbllocation());
		
		return "print";
	}
}