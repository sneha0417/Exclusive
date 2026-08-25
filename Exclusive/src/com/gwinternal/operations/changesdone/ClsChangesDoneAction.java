package com.gwinternal.operations.changesdone;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsChangesDoneAction extends ActionSupport{

	ClsCommon commonDAO= new ClsCommon();
	ClsChangesDoneDAO changesDoneDAO= new ClsChangesDoneDAO();
	ClsChangesDoneBean changesDoneBean;
	
	private String formdetailcode;
	private String chkstatus;
	private String mode;
	private String deleted;
	private String msg;
	private int txtchangesdonedocno;
	private String changesDoneDate;
	private String hidchangesDoneDate;
	private String cmbproject;
	private String hidcmbproject;
	private String txtchangedformname;
	private String txtchangedformpath;
	private String txtchangedformquery;
	private String txtchangedformfiles;
	private String txtchangedformdescription;

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getChkstatus() {
		return chkstatus;
	}

	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
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

	public int getTxtchangesdonedocno() {
		return txtchangesdonedocno;
	}

	public void setTxtchangesdonedocno(int txtchangesdonedocno) {
		this.txtchangesdonedocno = txtchangesdonedocno;
	}

	public String getChangesDoneDate() {
		return changesDoneDate;
	}

	public void setChangesDoneDate(String changesDoneDate) {
		this.changesDoneDate = changesDoneDate;
	}

	public String getHidchangesDoneDate() {
		return hidchangesDoneDate;
	}

	public void setHidchangesDoneDate(String hidchangesDoneDate) {
		this.hidchangesDoneDate = hidchangesDoneDate;
	}

	public String getCmbproject() {
		return cmbproject;
	}

	public void setCmbproject(String cmbproject) {
		this.cmbproject = cmbproject;
	}

	public String getHidcmbproject() {
		return hidcmbproject;
	}

	public void setHidcmbproject(String hidcmbproject) {
		this.hidcmbproject = hidcmbproject;
	}

	public String getTxtchangedformname() {
		return txtchangedformname;
	}

	public void setTxtchangedformname(String txtchangedformname) {
		this.txtchangedformname = txtchangedformname;
	}

	public String getTxtchangedformpath() {
		return txtchangedformpath;
	}

	public void setTxtchangedformpath(String txtchangedformpath) {
		this.txtchangedformpath = txtchangedformpath;
	}

	public String getTxtchangedformquery() {
		return txtchangedformquery;
	}

	public void setTxtchangedformquery(String txtchangedformquery) {
		this.txtchangedformquery = txtchangedformquery;
	}

	public String getTxtchangedformfiles() {
		return txtchangedformfiles;
	}

	public void setTxtchangedformfiles(String txtchangedformfiles) {
		this.txtchangedformfiles = txtchangedformfiles;
	}

	public String getTxtchangedformdescription() {
		return txtchangedformdescription;
	}

	public void setTxtchangedformdescription(String txtchangedformdescription) {
		this.txtchangedformdescription = txtchangedformdescription;
	}

	java.sql.Date changesDoneDates=null;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		String mode=getMode();
		
		if(mode.equalsIgnoreCase("A")){
			
			changesDoneDates = (getChangesDoneDate()==null || getChangesDoneDate().trim().equalsIgnoreCase(""))?null:commonDAO.changeStringtoSqlDate(getChangesDoneDate());
			
			int val=changesDoneDAO.insert(getFormdetailcode(),changesDoneDates,getCmbproject(),getTxtchangedformname(),getTxtchangedformpath(),getTxtchangedformquery(),getTxtchangedformfiles(),getTxtchangedformdescription(),session,mode);
			if(val>0.0){
				
				setTxtchangesdonedocno(val);
				setHidchangesDoneDate(changesDoneDates==null?null:changesDoneDates.toString());
				setData();
				
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setData();
				setMsg("Not Saved");
				return "fail";
			}	
		}
		else if(mode.equalsIgnoreCase("E")){
			
			changesDoneDates = (getChangesDoneDate()==null || getChangesDoneDate().trim().equalsIgnoreCase(""))?null:commonDAO.changeStringtoSqlDate(getChangesDoneDate());
			
			int Status=changesDoneDAO.edit(getFormdetailcode(),changesDoneDates,getTxtchangesdonedocno(),getCmbproject(),getTxtchangedformname(),getTxtchangedformpath(),getTxtchangedformquery(),getTxtchangedformfiles(),getTxtchangedformdescription(),session,mode);
			if(Status>0){
				
				setTxtchangesdonedocno(getTxtchangesdonedocno());
				setHidchangesDoneDate(changesDoneDates==null?null:changesDoneDates.toString());
				setData();
				
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setTxtchangesdonedocno(getTxtchangesdonedocno());
				setHidchangesDoneDate(changesDoneDates==null?null:changesDoneDates.toString());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("D")){
			boolean Status=changesDoneDAO.delete(getTxtchangesdonedocno(),getFormdetailcode(),session,mode);
		if(Status){
			
			setTxtchangesdonedocno(getTxtchangesdonedocno());
			setData();
			
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else{
			setTxtchangesdonedocno(getTxtchangesdonedocno());
			setData();
			setMsg("Not Deleted");
			return "fail";
		}
		}
		
		else if(mode.equalsIgnoreCase("View")){
			
			changesDoneBean=changesDoneDAO.getViewDetails(getTxtchangesdonedocno());
			
			setChangesDoneDate(changesDoneBean.getChangesDoneDate());
			setHidcmbproject(changesDoneBean.getHidcmbproject());
			setTxtchangedformname(changesDoneBean.getTxtchangedformname());
			setTxtchangedformpath(changesDoneBean.getTxtchangedformpath());
			setTxtchangedformquery(changesDoneBean.getTxtchangedformquery());
			setTxtchangedformfiles(changesDoneBean.getTxtchangedformfiles());
			setTxtchangedformdescription(changesDoneBean.getTxtchangedformdescription());
			setFormdetailcode(changesDoneBean.getFormdetailcode());
			
			return "success";
		}
		return "fail";
	}

	public void setData(){
		setHidcmbproject(getCmbproject());
		setTxtchangedformname(getTxtchangedformname());
		setTxtchangedformpath(getTxtchangedformpath());
		setTxtchangedformquery(getTxtchangedformquery());
		setTxtchangedformfiles(getTxtchangedformfiles());
		setTxtchangedformdescription(getTxtchangedformdescription());
		setFormdetailcode(getFormdetailcode());
	}
}
