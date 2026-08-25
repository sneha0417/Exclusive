package com.controlcentre.settings.servicesettings;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.controlcentre.settings.activity.ClsActivityBean;

public class ClsServiceSettingAction {

	ClsCommon com=new ClsCommon();
	
	private int docno;
	private String date;
	private String txtcategory;
	private String txtcode;
	private String txtname;
	private String txtdesc;
	private String mode;
	private String msg;
	private String deleted;
	private String hidtxtcategory;
	
	
	public String getHidtxtcategory() {
		return hidtxtcategory;
	}
	public void setHidtxtcategory(String hidtxtcategory) {
		this.hidtxtcategory = hidtxtcategory;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getTxtcategory() {
		return txtcategory;
	}
	public void setTxtcategory(String txtcategory) {
		this.txtcategory = txtcategory;
	}
	public String getTxtcode() {
		return txtcode;
	}
	public void setTxtcode(String txtcode) {
		this.txtcode = txtcode;
	}
	public String getTxtname() {
		return txtname;
	}
	public void setTxtname(String txtname) {
		this.txtname = txtname;
	}
	public String getTxtdesc() {
		return txtdesc;
	}
	public void setTxtdesc(String txtdesc) {
		this.txtdesc = txtdesc;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	
	
	
	public String saveAction() throws SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		java.sql.Date sqlDate=com.changeStringtoSqlDate(getDate());
		
		ClsServiceSettingDAO DAO= new ClsServiceSettingDAO();
		
if(mode.equalsIgnoreCase("A")){
			
			int val=DAO.insert(sqlDate,getTxtcategory(),getTxtcode(),getTxtname(),getTxtdesc(),session,request,mode);
			if(val>0){
				setDate(sqlDate+"");
				setDocno(val);
				setTxtcategory(getTxtcategory());
				setHidtxtcategory(getTxtcategory());
				setTxtcode(getTxtcode());
				setTxtname(getTxtname());
				setTxtdesc(getTxtdesc());
				setMsg("Successfully Saved");
				
				return "success";
			}
			else{
				setDate(sqlDate+"");
				setDocno(val);
				setTxtcategory(getTxtcategory());
				setHidtxtcategory(getTxtcategory());
				setTxtcode(getTxtcode());
				setTxtname(getTxtname());
				setTxtdesc(getTxtdesc());
				setMsg("Not Saved");
				return "fail";
			}	
			
		}

else if(mode.equalsIgnoreCase("E")){
	
	int val=DAO.edit(getDocno(),sqlDate,getTxtcategory(),getTxtcode(),getTxtname(),getTxtdesc(),session,request,mode);
	if(val>0){
		setDate(sqlDate+"");
		setDocno(val);
		setTxtcategory(getTxtcategory());
		setHidtxtcategory(getTxtcategory());
		setTxtcode(getTxtcode());
		setTxtname(getTxtname());
		setTxtdesc(getTxtdesc());
		setMsg("Updated Successfully");
		
		return "success";
	}
	else{
		setDate(sqlDate+"");
		setDocno(val);
		setTxtcategory(getTxtcategory());
		setHidtxtcategory(getTxtcategory());
		setTxtcode(getTxtcode());
		setTxtname(getTxtname());
		setTxtdesc(getTxtdesc());
		setMsg("Not Saved");
		return "fail";
	}	
	
}

else if(mode.equalsIgnoreCase("D")){
	
	int val=DAO.delete(getDocno(),sqlDate,getTxtcategory(),getTxtcode(),getTxtname(),getTxtdesc(),session,request,mode);
	if(val>0){
		setDate(sqlDate+"");
		setDocno(val);
		setTxtcategory(getTxtcategory());
		setHidtxtcategory(getTxtcategory());
		setTxtcode(getTxtcode());
		setTxtname(getTxtname());
		setTxtdesc(getTxtdesc());
		setMsg("Successfully Deleted");
		
		return "success";
	}
	else{
		setDate(sqlDate+"");
		setDocno(val);
		setTxtcategory(getTxtcategory());
		setHidtxtcategory(getTxtcategory());
		setTxtcode(getTxtcode());
		setTxtname(getTxtname());
		setTxtdesc(getTxtdesc());
		setMsg("Not Deleted");
		return "fail";
	}	
	
}
		
		return "";
		
	}
	
	
	
public String saveChargingMasterAction() throws SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		java.sql.Date sqlDate=com.changeStringtoSqlDate(getDate());
		
		ClsServiceSettingDAO DAO= new ClsServiceSettingDAO();
		
if(mode.equalsIgnoreCase("A")){
			
			int val=DAO.insertCm(sqlDate,getTxtcategory(),getTxtcode(),getTxtname(),getTxtdesc(),session,request,mode);
			if(val>0){
				setDate(sqlDate+"");
				setDocno(val);
				setTxtcategory(getTxtcategory());
				setHidtxtcategory(getTxtcategory());
				setTxtcode(getTxtcode());
				setTxtname(getTxtname());
				setTxtdesc(getTxtdesc());
				setMsg("Successfully Saved");
				
				return "success";
			}
			else{
				setDate(sqlDate+"");
				setDocno(val);
				setTxtcategory(getTxtcategory());
				setHidtxtcategory(getTxtcategory());
				setTxtcode(getTxtcode());
				setTxtname(getTxtname());
				setTxtdesc(getTxtdesc());
				setMsg("Not Saved");
				return "fail";
			}	
			
		}

else if(mode.equalsIgnoreCase("E")){
	
	int val=DAO.editCm(getDocno(),sqlDate,getTxtcategory(),getTxtcode(),getTxtname(),getTxtdesc(),session,request,mode);
	if(val>0){
		setDate(sqlDate+"");
		setDocno(val);
		setTxtcategory(getTxtcategory());
		setHidtxtcategory(getTxtcategory());
		setTxtcode(getTxtcode());
		setTxtname(getTxtname());
		setTxtdesc(getTxtdesc());
		setMsg("Updated Successfully");
		
		return "success";
	}
	else{
		setDate(sqlDate+"");
		setDocno(val);
		setTxtcategory(getTxtcategory());
		setHidtxtcategory(getTxtcategory());
		setTxtcode(getTxtcode());
		setTxtname(getTxtname());
		setTxtdesc(getTxtdesc());
		setMsg("Not Saved");
		return "fail";
	}	
	
}


else if(mode.equalsIgnoreCase("D")){
	
	int val=DAO.deleteCm(getDocno(),sqlDate,getTxtcategory(),getTxtcode(),getTxtname(),getTxtdesc(),session,request,mode);
	if(val>0){
		setDate(sqlDate+"");
		setDocno(val);
		setTxtcategory(getTxtcategory());
		setHidtxtcategory(getTxtcategory());
		setTxtcode(getTxtcode());
		setTxtname(getTxtname());
		setTxtdesc(getTxtdesc());
		setMsg("Successfully Deleted");
		
		return "success";
	}
	else{
		setDate(sqlDate+"");
		setDocno(val);
		setTxtcategory(getTxtcategory());
		setHidtxtcategory(getTxtcategory());
		setTxtcode(getTxtcode());
		setTxtname(getTxtname());
		setTxtdesc(getTxtdesc());
		setMsg("Not Deleted");
		return "fail";
	}	
	
}
		
		return "";
		
	}
	
	
}
