package com.controlcentre.masters.floormaster.floor;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

 
public class ClsFloorAction  {
	
	ClsFloorDAO floorDAO= new ClsFloorDAO();
	ClsFloorBean bean;
	ClsCommon ClsCommon=new ClsCommon();
	private int txtfloordocno;
	private String formdetailcode;
	private String formdetail;
	private String mode;
	private String deleted;
	private String msg;
	private String floorDate;
	private String hidfloorDate;
	private String txtfloorcode;
	private String txtfloorname;
	
	public int getTxtfloordocno() {
		return txtfloordocno;
	}
	public void setTxtfloordocno(int txtfloordocno) {
		this.txtfloordocno = txtfloordocno;
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
	public String getFloorDate() {
		return floorDate;
	}
	public void setFloorDate(String floorDate) {
		this.floorDate = floorDate;
	}
	public String getHidfloorDate() {
		return hidfloorDate;
	}
	public void setHidfloorDate(String hidfloorDate) {
		this.hidfloorDate = hidfloorDate;
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
	
	java.sql.Date floorMasterDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		
		floorMasterDate = ClsCommon.changeStringtoSqlDate(getFloorDate());
		
		if(mode.equalsIgnoreCase("A")){

			int val=floorDAO.insert(getFormdetailcode(),floorMasterDate,getTxtfloorcode(),getTxtfloorname(),session,mode);
			if(val>0.0){
				setTxtfloordocno(val);
				setData();
				
				setMsg("Successfully Saved");
				return "success";
			}
			else if(val==-1){
				setData();
				
				setMsg("Floor Already Exists");
				return "fail";
			}
			else{
				setData();
				
				setMsg("Not Saved");
				return "fail";
			}	
		}


		else if(mode.equalsIgnoreCase("E")){
				int Status=floorDAO.edit(getTxtfloordocno(),getFormdetailcode(),floorMasterDate,getTxtfloorcode(),getTxtfloorname(),session,mode);
				if(Status>0){
					setTxtfloordocno(getTxtfloordocno());
					setData();
					
					setMsg("Updated Successfully");
					return "success";
				}
				else if(Status==-1){
					setTxtfloordocno(getTxtfloordocno());
					setData();
					setMsg("Floor Already Exists");
					return "fail";
				}
				else{
					setTxtfloordocno(getTxtfloordocno());
					setData();
					
					setMsg("Not Updated");
					return "fail";
				}
			}
			else if(mode.equalsIgnoreCase("D")){
				
			int Status=floorDAO.delete(getTxtfloordocno(), getFormdetailcode(), session, mode);
			if(Status>0){
				setTxtfloordocno(getTxtfloordocno());
				setData();
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}else{
					
				setTxtfloordocno(getTxtfloordocno());
				setData();
				
				setMsg("Not Deleted");
				return "fail";
			  }
			}
		return "fail";
	 }
		
		public void setData() {
			if(getFloorDate()!=null){
				setHidfloorDate(floorMasterDate.toString());
			}
			setTxtfloorcode(getTxtfloorcode());
			setTxtfloorname(getTxtfloorname());
		}
	}

