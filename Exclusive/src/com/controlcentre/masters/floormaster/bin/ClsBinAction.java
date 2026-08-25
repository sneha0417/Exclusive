package com.controlcentre.masters.floormaster.bin;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

 
public class ClsBinAction  {
	
	ClsBinDAO binDAO= new ClsBinDAO();
	ClsBinBean bean;
	ClsCommon ClsCommon=new ClsCommon();
	private int txtbindocno;
	private String formdetailcode;
	private String formdetail;
	private String mode;
	private String deleted;
	private String msg;
	private String binDate;
	private String hidbinDate;
	private String txtrackcode;
	private String txtrackname;
	private String txtfloorcode;
	private String txtbincode;
	private String txtbinname;

	public int getTxtbindocno() {
		return txtbindocno;
	}

	public void setTxtbindocno(int txtbindocno) {
		this.txtbindocno = txtbindocno;
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

	public String getBinDate() {
		return binDate;
	}

	public void setBinDate(String binDate) {
		this.binDate = binDate;
	}

	public String getHidbinDate() {
		return hidbinDate;
	}

	public void setHidbinDate(String hidbinDate) {
		this.hidbinDate = hidbinDate;
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

	public String getTxtfloorcode() {
		return txtfloorcode;
	}

	public void setTxtfloorcode(String txtfloorcode) {
		this.txtfloorcode = txtfloorcode;
	}

	public String getTxtbincode() {
		return txtbincode;
	}

	public void setTxtbincode(String txtbincode) {
		this.txtbincode = txtbincode;
	}

	public String getTxtbinname() {
		return txtbinname;
	}

	public void setTxtbinname(String txtbinname) {
		this.txtbinname = txtbinname;
	}

	java.sql.Date binMasterDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		
		binMasterDate = ClsCommon.changeStringtoSqlDate(getBinDate());
		
		if(mode.equalsIgnoreCase("A")){

			int val=binDAO.insert(getFormdetailcode(),binMasterDate,getTxtfloorcode(),getTxtrackcode(),getTxtbincode(),getTxtbinname(),session,mode);
			if(val>0.0){
				setTxtbindocno(val);
				setData();
				
				setMsg("Successfully Saved");
				return "success";
			}
			else if(val==-1){
				setData();
				
				setMsg("Bin Already Exists");
				return "fail";
			}
			else{
				setData();
				
				setMsg("Not Saved");
				return "fail";
			}	
		}


		else if(mode.equalsIgnoreCase("E")){
				int Status=binDAO.edit(getTxtbindocno(),getFormdetailcode(),binMasterDate,getTxtfloorcode(),getTxtrackcode(),getTxtbincode(),getTxtbinname(),session,mode);
				if(Status>0){
					setTxtbindocno(getTxtbindocno());
					setData();
					
					setMsg("Updated Successfully");
					return "success";
				}
				else if(Status==-1){
					setTxtbindocno(getTxtbindocno());
					setData();
					
					setMsg("Bin Already Exists");
					return "fail";
				}
				else{
					setTxtbindocno(getTxtbindocno());
					setData();
					
					setMsg("Not Updated");
					return "fail";
				}
			}
			else if(mode.equalsIgnoreCase("D")){
				
			int Status=binDAO.delete(getTxtbindocno(), getFormdetailcode(), session, mode);
			if(Status>0){
				setTxtbindocno(getTxtbindocno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}else{
					
				setTxtbindocno(getTxtbindocno());
				setData();
				
				setMsg("Not Deleted");
				return "fail";
			  }
			}
		return "fail";
	 }
		
		public void setData() {
			if(getBinDate()!=null){
				setHidbinDate(binMasterDate.toString());
			}
			setTxtfloorcode(getTxtfloorcode());
			setTxtrackcode(getTxtrackcode());
			setTxtrackname(getTxtrackname());
			setTxtbincode(getTxtbincode());
			setTxtbinname(getTxtbinname());
		}
}