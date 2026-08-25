package com.operations.clientrelations.clientreview;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsClientReviewAction extends ActionSupport{
    
	ClsCommon commonDAO= new ClsCommon();
	ClsClientReviewDAO clientReviewDAO = new ClsClientReviewDAO();
	ClsClientReviewBean clientReviewBean;

	private int txtnonfinancialdocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxNonFinancialDate;
	private String hidjqxNonFinancialDate;
	private String txtnonfinancialcomment;
	private int txtcldocno;
	private int txtaccno;
	private String txtclientname;
	private String txtdescription;
	private String txtdescriptions;
	private double txtbalance;
	private String lblclientstatus;
	
	public int getTxtnonfinancialdocno() {
		return txtnonfinancialdocno;
	}
	public void setTxtnonfinancialdocno(int txtnonfinancialdocno) {
		this.txtnonfinancialdocno = txtnonfinancialdocno;
	}
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
	public String getJqxNonFinancialDate() {
		return jqxNonFinancialDate;
	}
	public void setJqxNonFinancialDate(String jqxNonFinancialDate) {
		this.jqxNonFinancialDate = jqxNonFinancialDate;
	}
	public String getHidjqxNonFinancialDate() {
		return hidjqxNonFinancialDate;
	}
	public void setHidjqxNonFinancialDate(String hidjqxNonFinancialDate) {
		this.hidjqxNonFinancialDate = hidjqxNonFinancialDate;
	}
	public String getTxtnonfinancialcomment() {
		return txtnonfinancialcomment;
	}
	public void setTxtnonfinancialcomment(String txtnonfinancialcomment) {
		this.txtnonfinancialcomment = txtnonfinancialcomment;
	}
	public int getTxtcldocno() {
		return txtcldocno;
	}
	public void setTxtcldocno(int txtcldocno) {
		this.txtcldocno = txtcldocno;
	}
	public int getTxtaccno() {
		return txtaccno;
	}
	public void setTxtaccno(int txtaccno) {
		this.txtaccno = txtaccno;
	}
	public String getTxtclientname() {
		return txtclientname;
	}
	public void setTxtclientname(String txtclientname) {
		this.txtclientname = txtclientname;
	}
	public String getTxtdescription() {
		return txtdescription;
	}
	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}
	public String getTxtdescriptions() {
		return txtdescriptions;
	}
	public void setTxtdescriptions(String txtdescriptions) {
		this.txtdescriptions = txtdescriptions;
	}
	public double getTxtbalance() {
		return txtbalance;
	}
	public void setTxtbalance(double txtbalance) {
		this.txtbalance = txtbalance;
	}
	public String getLblclientstatus() {
		return lblclientstatus;
	}
	public void setLblclientstatus(String lblclientstatus) {
		this.lblclientstatus = lblclientstatus;
	}

	java.sql.Date nonFinancialDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		String mode=getMode();
		ClsClientReviewBean bean = new ClsClientReviewBean();
		nonFinancialDate = commonDAO.changeStringtoSqlDate(getJqxNonFinancialDate());
		
		if(mode.equalsIgnoreCase("A")){
						int val=clientReviewDAO.insert(nonFinancialDate,getTxtnonfinancialcomment(),getTxtcldocno(),getFormdetailcode(),session,mode);
						if(val>0.0){
							
							setTxtnonfinancialdocno(val);
							setHidjqxNonFinancialDate(nonFinancialDate.toString());
							setTxtnonfinancialcomment(getTxtnonfinancialcomment());
							setTxtcldocno(getTxtcldocno());
							setTxtaccno(getTxtaccno());
							setTxtclientname(getTxtclientname());
							setTxtdescription(getTxtdescription());
							setTxtdescriptions(getTxtdescriptions());
							setTxtbalance(getTxtbalance());
							setLblclientstatus(getLblclientstatus());
							
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setHidjqxNonFinancialDate(nonFinancialDate.toString());
							setTxtnonfinancialcomment(getTxtnonfinancialcomment());
							setTxtcldocno(getTxtcldocno());
							setTxtaccno(getTxtaccno());
							setTxtclientname(getTxtclientname());
							setTxtdescription(getTxtdescription());
							setTxtdescriptions(getTxtdescriptions());
							setTxtbalance(getTxtbalance());
							setLblclientstatus(getLblclientstatus());
							
							setMsg("Not Saved");
							return "fail";
						}	
		}
		
		else if(mode.equalsIgnoreCase("E")){

			boolean Status=clientReviewDAO.edit(getTxtnonfinancialdocno(),nonFinancialDate,getTxtnonfinancialcomment(),getTxtcldocno(),getFormdetailcode(),session,mode);
			if(Status){

				setTxtnonfinancialdocno(getTxtnonfinancialdocno());
				setHidjqxNonFinancialDate(nonFinancialDate.toString());
				setTxtnonfinancialcomment(getTxtnonfinancialcomment());
				setTxtcldocno(getTxtcldocno());
				setTxtaccno(getTxtaccno());
				setTxtclientname(getTxtclientname());
				setTxtdescription(getTxtdescription());
				setTxtdescriptions(getTxtdescriptions());
				setTxtbalance(getTxtbalance());
				setLblclientstatus(getLblclientstatus());
				
				setMsg("Updated Successfully");
			    return "success";
		}
		else{
			setTxtnonfinancialdocno(getTxtnonfinancialdocno());
			setHidjqxNonFinancialDate(nonFinancialDate.toString());
			setTxtnonfinancialcomment(getTxtnonfinancialcomment());
			setTxtcldocno(getTxtcldocno());
			setTxtaccno(getTxtaccno());
			setTxtclientname(getTxtclientname());
			setTxtdescription(getTxtdescription());
			setTxtdescriptions(getTxtdescriptions());
			setTxtbalance(getTxtbalance());
			setLblclientstatus(getLblclientstatus());
			
			setMsg("Not Updated");
			return "fail";
		}
	  }
		
		
		else if(mode.equalsIgnoreCase("D")){
			
			boolean Status=clientReviewDAO.delete(getTxtnonfinancialdocno(),getFormdetailcode(),session,mode);
			if(Status){
				
				setTxtnonfinancialdocno(getTxtnonfinancialdocno());
				setTxtnonfinancialcomment(getTxtnonfinancialcomment());
				setTxtcldocno(getTxtcldocno());
				setTxtaccno(getTxtaccno());
				setTxtclientname(getTxtclientname());
				setTxtdescription(getTxtdescription());
				setTxtdescriptions(getTxtdescriptions());
				setTxtbalance(getTxtbalance());
				setLblclientstatus(getLblclientstatus());
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setTxtnonfinancialcomment(getTxtnonfinancialcomment());
				setTxtcldocno(getTxtcldocno());
				setTxtaccno(getTxtaccno());
				setTxtclientname(getTxtclientname());
				setTxtdescription(getTxtdescription());
				setTxtdescriptions(getTxtdescriptions());
				setTxtbalance(getTxtbalance());
				setLblclientstatus(getLblclientstatus());
				
				setMsg("Not Deleted");
				return "fail";
			   }
			}
		
		return "fail";
     }
	
}