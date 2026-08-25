package com.controlcentre.masters.floormaster.rack;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

 
public class ClsRackAction  {
	
	ClsRackDAO rackDAO= new ClsRackDAO();
	ClsRackBean bean;
	ClsCommon ClsCommon=new ClsCommon();
	private int txtrackdocno;
	private String formdetailcode;
	private String formdetail;
	private String mode;
	private String deleted;
	private String msg;
	private String rackDate;
	private String hidrackDate;
	private String txtfloorcode;
	private String txtfloorname;
	private String txtrackcode;
	private String txtrackname;
	
	public int getTxtrackdocno() {
		return txtrackdocno;
	}

	public void setTxtrackdocno(int txtrackdocno) {
		this.txtrackdocno = txtrackdocno;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getFormdetail() {
		return formdetail;
	}

	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
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

	public String getRackDate() {
		return rackDate;
	}

	public void setRackDate(String rackDate) {
		this.rackDate = rackDate;
	}

	public String getHidrackDate() {
		return hidrackDate;
	}

	public void setHidrackDate(String hidrackDate) {
		this.hidrackDate = hidrackDate;
	}

	public String getTxtfloorcode() {
		return txtfloorcode;
	}

	public void setTxtfloorcode(String txtfloorcode) {
		this.txtfloorcode = txtfloorcode;
	}

	public String getTxtfloorname() {
		return txtfloorname;
	}

	public void setTxtfloorname(String txtfloorname) {
		this.txtfloorname = txtfloorname;
	}

	public String getTxtrackcode() {
		return txtrackcode;
	}

	public void setTxtrackcode(String txtrackcode) {
		this.txtrackcode = txtrackcode;
	}

	public String getTxtrackname() {
		return txtrackname;
	}

	public void setTxtrackname(String txtrackname) {
		this.txtrackname = txtrackname;
	}

	java.sql.Date rackMasterDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		
		rackMasterDate = ClsCommon.changeStringtoSqlDate(getRackDate());
		
		if(mode.equalsIgnoreCase("A")){

			int val=rackDAO.insert(getFormdetailcode(),rackMasterDate,getTxtfloorcode(),getTxtrackcode(),getTxtrackname(),session,mode);
			if(val>0.0){
				setTxtrackdocno(val);
				setData();
				
				setMsg("Successfully Saved");
				return "success";
			}
			else if(val==-1){
				setData();
				
				setMsg("Rack Already Exists");
				return "fail";
			}
			else{
				setData();
				
				setMsg("Not Saved");
				return "fail";
			}	
		}


		else if(mode.equalsIgnoreCase("E")){
				int Status=rackDAO.edit(getTxtrackdocno(),getFormdetailcode(),rackMasterDate,getTxtfloorcode(),getTxtrackcode(),getTxtrackname(),session,mode);
				if(Status>0){
					setTxtrackdocno(getTxtrackdocno());
					setData();
					
					setMsg("Updated Successfully");
					return "success";
				}
				else if(Status==-1){
					setTxtrackdocno(getTxtrackdocno());
					setData();
					setMsg("Rack Already Exists");
					return "fail";
				}
				else{
					setTxtrackdocno(getTxtrackdocno());
					setData();
					
					setMsg("Not Updated");
					return "fail";
				}
			}
			else if(mode.equalsIgnoreCase("D")){
				
			int Status=rackDAO.delete(getTxtrackdocno(), getFormdetailcode(), session, mode);
			if(Status>0){
				setTxtrackdocno(getTxtrackdocno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}else{
					
				setTxtrackdocno(getTxtrackdocno());
				setData();
				
				setMsg("Not Deleted");
				return "fail";
			  }
			}
		return "fail";
	 }
		
		public void setData() {
			if(getRackDate()!=null){
				setHidrackDate(rackMasterDate.toString());
			}
			setTxtfloorcode(getTxtfloorcode());
			setTxtfloorname(getTxtfloorname());
			setTxtrackcode(getTxtrackcode());
			setTxtrackname(getTxtrackname());
		}
	}

